#!/usr/bin/env texlua

module = "tikz-minesweeper"

sourcefiles = { "*.dtx", "./translation" }

unpackexe = "xelatex"
unpackfiles = { "*.dtx" }

typesetexe = "xelatex"

installfiles = { "*.sty" }
