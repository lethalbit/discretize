# SPDX-License-Identifier: BSD-3-Clause

import shutil
from pathlib        import Path

import nox
from nox.sessions import Session

ROOT_DIR  = Path(__file__).parent

BUILD   = (ROOT_DIR / 'build'  ).resolve()
TESTS   = (ROOT_DIR / 'tests'  ).resolve()
CONTRIB = (ROOT_DIR / 'contrib').resolve()
TECHLIB = (ROOT_DIR / 'techlib').resolve()


if not BUILD.exists():
	BUILD.mkdir()

# Default sessions to run
nox.options.sessions = ( )


@nox.session(venv_backend = 'none')
def clean(session: Session) -> None:

	if BUILD.exists():
		shutil.rmtree(BUILD)
		BUILD.mkdir()

@nox.session(venv_backend = 'none')
def build(session: Session) -> None:
	SYNTH_MODULE = (TECHLIB / 'synth_discretize.cc')
	in_tree = '--in-tree' in session.posargs
	if not in_tree:
		session.run(
			'yosys-config', '--build', f'{BUILD}/{SYNTH_MODULE.stem}.so', str(SYNTH_MODULE)
		)
	else:
		YOSYS_DIR  = (BUILD     / 'yosys' )
		YOSYS_TLB  = (YOSYS_DIR / 'techlibs')
		DISCRETIZE = (YOSYS_TLB / 'discretize')

		yosys_repo = 'https://github.com/YosysHQ/yosys.git'

		if not YOSYS_DIR.exists():
			session.run(
				'git', 'clone', yosys_repo, str(YOSYS_DIR)
			)
		if not DISCRETIZE.exists():
			DISCRETIZE.symlink_to(TECHLIB, target_is_directory = True)

		session.chdir(YOSYS_DIR)
		if not (YOSYS_DIR / 'Makefile.conf').exists():
			session.run(
				'make', 'config-gcc'
			)

		session.run(
			'make', 'PREFIX="/"', '-j16'
		)

		session.run(
			'make', 'PREFIX="/"', f'DESTDIR="{BUILD}"', 'install'
		)

