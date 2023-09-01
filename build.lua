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
            "%d%d%d%d%-%d%d%-%d%d v%d%.%d.%d%S*",
            tagdate .. " v" .. string.gsub(tagname, "^v+", ""))
    end
    return content
end

function tag_hook(tagname, tagdate)
    local orig_tagname, err_msg = io.popen("git describe --tags --abbrev=0"):read("*a")
    if err_msg or not orig_tagname then
        orig_tagname = '0.0.0'
        print("Critical: Failed to fetching newest Git tag.")
        return 1
    end
    orig_tagname = orig_tagname:gsub("[\n\r]", ""):gsub("^v", "")
    tagname = string.gsub(tagname, "^v+", "")
    print("Info: Bump version: " .. orig_tagname .. " -> " .. tagname)
    local errorlevel = os.execute("git commit -a -m \"" ..
        "Bump version: " .. orig_tagname .. " -> " .. tagname .. "\"")
    if errorlevel ~= 0 then
        print("Critical: Git commit failed.")
        return 1
    end

    print("Info: Deleting duplicate tags: " .. tagname)
    errorlevel = os.execute("git tag -d v" .. tagname)

    print("Info: Tagging version: " .. tagname)
    errorlevel = os.execute("git tag v" .. tagname)
    if errorlevel ~= 0 then
        print("Critical: Git tag failed.")
        return 1
    end
    print("Info: Tagged successfully.")
end
