"""Build sty file from system."""

import os
import sys


def build_xelatex():
    """Build dtx file with xelatex."""
    xelatex_no = os.system(
        "xelatex -synctex=1 -interaction=nonstopmode -file-line-error tikz-minesweeper.dtx"
    )  # compile with xelatex

    if xelatex_no != 0:
        print("Please make sure 'XeLaTeX' is in PATH.")
        sys.exit(1)


def build_makeindex():
    """Build gls/glo file with makeindex."""
    makeindex_no = os.system(
        "makeindex -s gglo.ist -o tikz-minesweeper.gls tikz-minesweeper.glo"
    )  # compile with makeindex

    if makeindex_no != 0:
        print("Please make sure 'makeindex' is in PATH.")
        sys.exit(1)


if not os.path.exists("tikz-minesweeper.dtx"):
    print(
        "Run this script from the root of the repository,",
        "and make sure 'tikz-minesweeper.dtx' is inside the current directory."
    )
    sys.exit(1)

build_xelatex()
build_makeindex()
build_xelatex()
build_xelatex()

if os.path.exists("tikz-minesweeper.sty"):
    print(
        "Build successfully! Please check 'tikz-minesweeper.sty' for details.",
    )
else:
    print("Build failed! Please check the error messages.")
    sys.exit(1)
