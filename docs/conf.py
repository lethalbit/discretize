# SPDX-License-Identifier: BSD-3-Clause
import os, sys, datetime
from pathlib import Path

sys.path.insert(0, os.path.abspath('.'))

REPO_ROOT = Path(__file__).parent.parent

def version():
	try:
		from setuptools_scm.git import parse as parse_git
	except ImportError:
		return ''

	git = parse_git(str(REPO_ROOT))
	if not git:
		return ''
	elif git.exact:
		return git.format_with('{tag}')
	else:
		return 'latest'

project   = 'discretize'
version   = version()
release   = version.split('+')[0]
copyright = f'{datetime.date.today().year}, Aki "lethalbit" Van Ness'
language  = 'en'

extensions = [
	'sphinx.ext.autodoc',
	'sphinx.ext.doctest',
	'sphinx.ext.githubpages',
	'sphinx.ext.graphviz',
	'sphinx.ext.napoleon',
	'sphinx.ext.todo',
	'sphinxcontrib.platformpicker',
	'myst_parser',
	'sphinx_rtd_theme',
]

source_suffix = {
	'.rst': 'restructuredtext',
	'.md': 'markdown',
}

pygments_style         = 'monokai'
autodoc_member_order   = 'bysource'
graphviz_output_format = 'svg'
todo_include_todos     = True


napoleon_google_docstring = False
napoleon_numpy_docstring  = True
napoleon_use_ivar         = True
napoleon_custom_sections  = [
	'Platform overrides'
]

myst_heading_anchors = 3

html_baseurl     = 'https://lethalbit.github.io/'
html_theme       = 'sphinx_rtd_theme'
html_copy_source = False

html_theme_options = {
	'collapse_navigation' : False,
	'style_external_links': True,
}

html_static_path = [
	'_static'
]

html_css_files = [
	'css/styles.css'
]

html_style = 'css/styles.css'

autosectionlabel_prefix_document = True
