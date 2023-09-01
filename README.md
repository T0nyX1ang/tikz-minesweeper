# Introduction of `tikz-minesweeper`

Draw a minesweeper board in LaTeX.

## Installation

### Compilation with `VSCode`

- Clone this repository

- Install `VSCode` and `LaTeX Workshop` extension (at least `v8.29.0`)

- Compile `tikz-minesweeper.dtx` in `VSCode` with recipe `Build dtx`, and all the steps will be done in one click!

- Move `tikz-minesweeper.sty` to `TEXMF-LOCAL/tex/latex/tikz-minesweeper`

- Move `tikz-minesweeper.pdf` to `TEXMF-LOCAL/doc/latex/tikz-minesweeper`

- Refresh local database with `texhash` or `mktexlsr` (with TeX Live)

### Compilation with `l3build`

- Clone this repository

- Run the following commands:

```bash
    l3build install --full --texmfhome $TEXMF-LOCAL$
```

- Refresh local database with `texhash` or `mktexlsr` (with TeX Live)

### Using `sty` releases

- See [GitHub Releases](https://github.com/T0nyX1ang/tikz-minesweeper/releases) page.

- Download the latest `sty` file, and use it for your projects.

### Using prebuilt artifacts

- See [GitHub Actions](https://github.com/T0nyX1ang/tikz-minesweeper/actions) page

- Click on the latest successful build and download the artifacts

- Unzip the `tds` zip and move all things unzipped to `TEXMF-LOCAL/`

## Usage

- `\cell{r}{c}{info}`: draw `info` at (`r`, `c`), see [here](https://github.com/T0nyX1ang/tikz-minesweeper/discussions/16) for detailed command discussions

- `\row{r}{seq: info}`: draw a row with a sequence of `info` according to `\cell`

- `\border[-tlbr]{r}{c}`: draw a border with edge options

- `\board[-tlbrx]{r}{c}`: draw a board with border

- `\colorcell{color}{seq: pos}`: fill an area with up to four colors.

## Contribution

- Issues and PRs are welcomed.

- `LaTeX3` is preferred.

## Copyright and License

- Copyright (C) 2021-2023 by Tian-Yi Pu, Fei-Yu Xiang and Yao-Yu Zhu

- This file may be distributed and/or modified under the conditions of the LaTeX Project Public License, either version 1.3 of this license or (at your option) any later version.

- The latest version of this license is at: <http://www.latex-project.org/lppl.txt> and version 1.3 or later is part of all distributions of LaTeX version 2005/12/01 or later.
