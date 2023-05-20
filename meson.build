# SPDX-License-Identifier: BSD-3-Clause
project(
	'discretize',
	'cpp',
	default_options: [
		'buildtype=release',
		'cpp_std=c++17',
		'warning_level=3',
		'b_ndebug=if-release',
		'b_lto=true',
		'strip=true'
	],
	license: 'BSD-3-Clause',
	version: '0.0.1',
	meson_version: '>= 1.0.0',
	subproject_dir: 'deps'
)

cxx = meson.get_compiler('cpp')
if get_option('cpp_std') not in ['c++17', 'c++20', 'c++23', 'gnu++17', 'gnu++20', 'gnu++23']
	error('Unsupported C++ Version @0@, must be c++17/gnu++17 or newer'.format(get_option('cpp_std')))
endif

extended_warnings = [
	'-Wdouble-promotion',
	'-Wformat=2',
	'-Wformat-overflow=2',
	'-Wformat-signedness',
	'-Wformat-truncation',
	'-Wnull-dereference',
	'-Wmissing-attributes',
	'-Wmissing-braces',
	'-Wsequence-point',
	'-Wreturn-type',
	'-Wunused',
	'-Wunused-local-typedefs',
	'-Wunused-const-variable=2',
	'-Wmaybe-uninitialized',
	'-Wunknown-pragmas',
	'-Wstrict-aliasing',
	'-Wstrict-overflow=3',
	'-Wstring-compare',
	'-Wstringop-overflow',
	'-Warith-conversion',
	'-Wvla-parameter',
	'-Wduplicated-branches',
	'-Wshadow=local',
	'-Wunsafe-loop-optimizations',
	'-Wbad-function-cast',
	'-Wcast-qual',
	'-Wcast-align=strict',
	'-Wcast-function-type',
	'-Wconversion',
	'-Wdangling-else',
	'-Wsign-conversion',
	'-Wfloat-conversion',
	'-Wredundant-decls',
	'-Winline',
	'-Wvla',
	'-Wstack-protector',
	'-Wunsuffixed-float-constant',
	'-Wimplicit-fallthrough',
]

add_project_arguments(
	cxx.get_supported_arguments(extended_warnings),
	language: 'cpp'
)

is_clang         = (cxx.get_id() == 'clang')
is_gcc           = (cxx.get_id() == 'gcc')
compiler_version = cxx.version()
yosys_datdir     = get_option('yosys_datdir')
yosys_cxxflags   = ''

if yosys_datdir == ''
	yosys_config = find_program('yosys-config', required: false)

	if yosys_config.found()
		yosys_datdir = run_command(yosys_config, '--datdir', check: true).stdout().strip()
		yosys_cxxflags = run_command(yosys_config, '--cxxflags', check: true).stdout().strip()
	endif
endif

yosys_incdir    = yosys_datdir / 'include'
yosys_plugindir = yosys_datdir / 'plugins'
yosys_defines   = []

foreach elem : yosys_cxxflags.split()
	if elem.startswith('-D')
		yosys_defines += elem
	endif
endforeach

message('Yosys data dir `@0@`'.format(yosys_datdir))
message('Yosys include dir `@0@`'.format(yosys_incdir))
message('Yosys plugin dir `@0@`'.format(yosys_plugindir))

subdir('contrib')
subdir('src')

if get_option('build_tests')
	subdir('tests')
endif
