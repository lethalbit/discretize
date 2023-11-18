# SPDX-License-Identifier: BSD-3-Clause

yosys = find_program('yosys', required: true)


message('Building tests')

test_srcs = [
	'counter',
	'inverter',
	'picorv32',
]

foreach ex : test_srcs
	test(ex, yosys, args: [
		'-m', synth_discretize,
		'-p', 'read_verilog @0@/@1@.v'.format(meson.current_source_dir(), ex),
		'-p', 'synth_discretize -techlib @0@'.format(meson.project_source_root() / 'src' / 'techlib'),
		'-p', 'tee -o @0@/@1@.stat.json stat -json'.format(meson.current_build_dir(), ex),
		'-p', 'write_verilog -noexpr @0@/@1@.dmp.v'.format(meson.current_build_dir(), ex),
		'-p', 'write_json @0@/@1@.net.json'.format(meson.current_build_dir(), ex)
	], timeout: 300)
endforeach
