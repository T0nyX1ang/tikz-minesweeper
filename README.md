# tikz-minesweeper

Draw a minesweeper board in LaTeX.

## Installation

### Compliation

- Clone this repository

- Change the directory to target folder

- Compile `tikz-minesweeper.ins` with XeTeX or XeLaTeX (this step will generate `tikz-minesweeper.sty`)

```bash
    xetex tikz-minesweeper.ins
```

- Compile `tikz-minesweeper.dtx` with XeLaTeX for two times (this step will generate `tikz-minesweeper.pdf`)

```bash
    xelatex tikz-minesweeper.dtx (twice)
```

- Move `tikz-minesweeper.sty` to your project folder

### Install globally on your disk

- Move `tikz-minesweeper.sty` to `TEXMF/tex/latex/tikz-minesweeper`

- Move `tikz-minesweeper.pdf` to `TEXMF/doc/latex/tikz-minesweeper`

- Refresh local database with `texhash` or `mktexlsr` (with texlive)

## Usage

- `\flag`: draw a flag

- `\mine`: draw a mine

- `\cellup`: draw an untouched cell

- `\celldown`: draw a pressed cell

- `\cellnum{n}`: draw a cell with a centered number (0-8)

- `\border[-tlbr]`: draw a border with edge options

- `\cell{r}{c}{xxx}`: draw `xxx` at (`r`, `c`), see #1 for detailed command discussions

- `\row{r}{xxx}`: draw a row with `xxx` according to `\cell`

- `\col{c}{xxx}`: draw a column with `xxx` according to `\cell`

- `\board[-tlbr]{r}{c}`: draw a board with border

- `\colorcell{color}{pos}`: fill an area with a certain color

## Contribution

- Issues and PRs are welcomed.

- LaTeX3 is preferred.

## Copyright and License

- Copyright (C) 2021-2022 by Tian-Yi Pu, Fei-Yu Xiang and Yao-Yu Zhu

- This file may be distributed and/or modified under the conditions of the LaTeX Project Public License, either version 1.3 of this license or (at your option) any later version.

- The latest version of this license is in: http://www.latex-project.org/lppl.txt and version 1.3 or later is part of all distributions of LaTeX version 2005/12/01 or later.

## Other notes

- `tikz-minesweeper.pdf` is fully in Chinese, and we don't have the efforts to translate it into other languages now.

test
