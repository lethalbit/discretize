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
