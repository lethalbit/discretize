// SPDX-License-Identifier: BSD-3-Clause

#include <algorithm>
#include <unordered_map>
#include <vector>
#include <sstream>
#include <iterator>

#include "kernel/rtlil.h"
#include "kernel/register.h"
#include "kernel/sigtools.h"
#include "kernel/celltypes.h"
#include "kernel/log.h"

USING_YOSYS_NAMESPACE
PRIVATE_NAMESPACE_BEGIN

struct KiCadBackend : public Backend {
	KiCadBackend() : Backend("kicad", "generate KiCad design files") { }

	void help() override {

	}

	void execute(
		std::ostream *&f, std::string filename, std::vector<std::string> args, RTLIL::Design *design
	) override {
	}

} KiCadBackend;

PRIVATE_NAMESPACE_END
