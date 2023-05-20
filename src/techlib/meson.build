# SPDX-License-Identifier: BSD-3-Clause

synth_discretize_srcs = files([
	'synth_discretize.cc',
])

synth_discretize = shared_module(
	'synth_discretize',
	synth_discretize_srcs,
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

if not meson.is_subproject()
	install_data(files([
		# 'cells_dffe.v',# Not done yet
		'cells_map.v',
		'cells_mod.v',
		'cells_mux.v',
		'discretize.lib',
	]), install_dir: yosys_datdir / 'discretize')
endif
