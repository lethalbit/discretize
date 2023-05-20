# SPDX-License-Identifier: BSD-3-Clause

write_kicad_srcs = files([
	'write_kicad.cc',
])

write_kicad = shared_module(
	'write_kicad',
	write_kicad_srcs,
	name_prefix: '',
	include_directories: [
		root_incs, include_directories('.')
	],
	dependencies: [

	],

	gnu_symbol_visibility: 'inlineshidden',
	implicit_include_directories: false,
	cpp_args: [
		'-DDISCRETIZE_BUILD_INTERNAL'
	] + yosys_defines,
	install: (not meson.is_subproject()),
	install_dir: yosys_plugindir
)
