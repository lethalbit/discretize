// SPDX-License-Identifier: BSD-3-Clause

#include <string>
#include <cstdint>

#include "kernel/yosys.h"

USING_YOSYS_NAMESPACE
PRIVATE_NAMESPACE_BEGIN

struct SynthDiscretizePass : public ScriptPass {

	SynthDiscretizePass() : ScriptPass("synth_discretize", "synthesis for discrete transistors") { }

	void help() override {
		//   |---v---|---v---|---v---|---v---|---v---|---v---|---v---|---v---|---v---|---v---|
		log("\n");
		log("	synth_discretize [options]\n");
		log("\n");
		log("This command runs synthesis for discrete transistors.");
		log("\n");
		log("	-top <module>\n");
		log("		Use the specified top module.\n");
		log("\n");
		log("	-json <file>\n");
		log("		Write the design to the specified JSON file.\n");
		log("		(Writing of an output file is omitted if this parameter is not set.)\n");
		log("\n");
		log("	-verilog <file>\n");
		log("		Write the design to the specified verilog file.\n");
		log("		(Writing of an output file is omitted if this parameter is not set.)\n");
		log("\n");
		log("	-stats <file>\n");
		log("		Write the design statistics to the specified json file.\n");
		log("		(Writing of an output file is omitted if this parameter is not set.)\n");
		log("\n");
		log("	-techlib <path>\n");
		log("		Specify the directory where to look for the discretize technology library.\n");
		log("		(default: +/discretize/)\n");
		log("		This is used in the case where the 'synth_discretize' is built out of tree\n");
		log("		from Yosys.\n");
		log("\n");
		log("	-dualfet\n");
		log("		Combine FETs in gates into either matched P/N FETS or dual PFETs and NFETS\n");
		log("		where appropriate.\n");
		log("\n");
		log("	-addties\n");
		log("		Insert pullup/pulldown cells into the design where appropriate.\n");
		log("		This is primarily used in conjunction with KiCad export for physical\n");
		log("		implementation.\n");
		log("\n");
		log("	-noautoname\n");
		log("		Don't run 'autoname' on the design, as it takes a while on big designs.\n");
		log("\n");
		log("	-dff\n");
		log("		Enable DFF mapping. (EXPERIMENTAL)\n");
		log("\n");
		log("	-mux\n");
		log("		Enable more advanced mux mapping. (EXPERIMENTAL)\n");
		log("\n");
		log("\n");
		log("The following commands are executed by this synthesis command:\n");
		help_script();
		log("\n");
	}

	std::string top_opt{"-auto-top"};
	std::string json_file{};
	std::string vlog_file{};
	std::string stat_file{};
	std::string techlib_path{"+/discretize"};
	bool dual_fet{false};
	bool add_ties{false};
	bool fixup_names{true};
	bool dff_map{false};
	bool mux_map{false};

	void execute(std::vector<std::string> args, RTLIL::Design *design) override {
		std::size_t argidx{1};

		for (; argidx < args.size(); ++argidx) {

			if (args[argidx] == "-top" && argidx + 1 < args.size()) {
				top_opt = "-top " + args[++argidx];
				continue;
			}

			if (args[argidx] == "-json" && argidx + 1 < args.size()) {
				json_file = args[++argidx];
				continue;
			}

			if (args[argidx] == "-verilog" && argidx + 1 < args.size()) {
				vlog_file = args[++argidx];
				continue;
			}

			if (args[argidx] == "-stats" && argidx + 1 < args.size()) {
				stat_file = args[++argidx];
				continue;
			}

			if (args[argidx] == "-techlib" && argidx + 1 < args.size()) {
				techlib_path = args[++argidx];
				continue;
			}

			if (args[argidx] == "-dualfet") {
				dual_fet = true;
				continue;
			}

			if (args[argidx] == "-addties") {
				add_ties = true;
				continue;
			}

			if (args[argidx] == "-noautoname") {
				fixup_names = false;
				continue;
			}

			if (args[argidx] == "-dff") {
				dff_map = false;
				continue;
			}

			if (args[argidx] == "-mux") {
				mux_map = false;
				continue;
			}

			break;
		}

		extra_args(args, argidx, design);

		if (!design->full_selection())
			log_cmd_error("This command only operates on fully selected designs!\n");

		log_header(design, "Executing SYNTH_DISCRETIZE pass.\n");
		log_push();

		run_script(design, "", "");

		log_pop();
	}

	void script() override {
		std::string defs{};

		if (dual_fet)
			defs += "-D DUAL_FETS";

		if (add_ties)
			defs += " -D INSERT_TIES";

		if (check_label("begin")) {
			run(stringf("hierarchy -check %s", help_mode ? "-top <top>" : top_opt.c_str()));
			run("proc");
		}

		if (check_label("flatten")) {
			run("flatten");
			run("deminout");
		}

		if (check_label("coarse")) {
			run("opt");
			run("wreduce");
			run("opt");
			run("opt_merge");
			run("peepopt");
		}

		if (check_label("synth")) {
			run("synth -run :fine");
		}

		if (check_label("map_cells")) {
			run(stringf("read_verilog %s -lib %s/cells_mod.v", defs.c_str(), techlib_path.c_str()));
			run(stringf("read_liberty -lib %s/discretize.lib", techlib_path.c_str()));
			run(stringf("techmap %s -map +/techmap.v -map %s/cells_map.v", defs.c_str(), techlib_path.c_str()));


			if (mux_map) {
				run("opt -full -mux_undef -mux_bool");
				if (dff_map) {
					run(stringf("techmap %s -map +/techmap.v -map %s/cells_dffe.v", defs.c_str(), techlib_path.c_str()));
				}
				run("opt");
				run("muxcover -mux4 -mux8");
				run("opt_merge");
			}

			run(stringf("techmap %s -map +/techmap.v -map %s/cells_map.v -map %s/cells_mux.v", defs.c_str(), techlib_path.c_str(), techlib_path.c_str()));

			if (dff_map) {
				run(stringf("dfflibmap -liberty %s/discretize.lib", techlib_path.c_str()));
				run(stringf("abc -liberty %s/discretize.lib", techlib_path.c_str()));
				run("opt -full");
				run("opt_clean -purge");
			}
		}

		if (check_label("fixup")) {
			run("hilomap -singleton -hicell VCC V -locell GND G");
			if (fixup_names) {
				run("autoname");
			}
		}

		if (check_label("check")) {
			run("stat");
		}

		if (check_label("json")) {
			if (!json_file.empty() || help_mode) {
				run(stringf("write_json %s", help_mode ? "<file-name>" : json_file.c_str()));
			}
		}

		if (check_label("verilog")) {
			if (!vlog_file.empty() || help_mode) {
				run(stringf("write_verilog -noexpr %s", help_mode ? "<file-name>" : json_file.c_str()));
			}
		}

		if (check_label("stat")) {
			if (!stat_file.empty() || help_mode) {
				run(stringf("tee -q -o %s stat -json", help_mode ? "<file-name>" : stat_file.c_str()));
			}
		}
	}

} SynthDiscretizePass;

PRIVATE_NAMESPACE_END
