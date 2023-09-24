#!/usr/bin/env texlua

module = "tikz-minesweeper"

sourcefiles = { "*.dtx", "./translation" }

unpackexe = "xelatex"
unpackfiles = { "*.dtx" }

typesetexe = "xelatex"

installfiles = { "*.sty" }

function update_tag(file, content, tagname, tagdate)
    if string.match(file, "%.dtx$") then
        return string.gsub(content,
            "{%d%d%d%d%-%d%d%-%d%d}{%d%.%d.%d%S*}", "{" ..
            tagdate .. "}{" .. string.gsub(tagname, "^v+", "") .. "}")
    end
    return content
end
