-- This is file `update_checksum.lua'.
--
-- Copyright (C) 2021-2023 by Fei-Yu Xiang
--
-- This file may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License, either
-- version 1.3 of this license or (at your option) any later
-- version. The latest version of this license is in:
--
--     http://www.latex-project.org/lppl.txt
--
-- and version 1.3 or later is part of all distributions of
-- LaTeX version 2005/12/01 or later.

local function update_checksum(filename)
    --[[ update the checksum of a certain dtx file ]]

    -- read the file
    local fin = assert(io.open(filename, "rb"), "Failed to read file: " .. filename)
    local content = fin:read("*all")
    fin:close()

    -- check whether the file contains \CheckSum only once
    local found_once = content:find("\\CheckSum")
    if not found_once then
        error("\\Checksum not found, abort updating.")
    end
    local found_twice = content:find("\\CheckSum", found_once + 1)
    if found_twice then
        error("Multiple \\CheckSum found, abort updating.")
    end

    -- calculate the original checksum
    local right_bound = content:find("}", found_once + 1)
    local old_checksum = content:sub(found_once + 10, right_bound - 1)
    print("Original checksum: " .. old_checksum)

    -- validate the format of the macrocode block
    for sub_content in content:gmatch("\\begin{macrocode}.-\\begin{macrocode}") do
        if not sub_content:find("\\end{macrocode}") then
            error("Unmatched macrocode environments, abort updating.")
        end
    end
    for sub_content in content:gmatch("\\end{macrocode}.-\\end{macrocode}") do
        if not sub_content:find("\\begin{macrocode}") then
            error("Unmatched macrocode environments, abort updating.")
        end
    end

    -- calculate the new checksum
    local new_checksum = 0
    for sub_content in content:gmatch("\\begin{macrocode}.-\\end{macrocode}") do
        for _ in sub_content:gmatch("\\") do
            new_checksum = new_checksum + 1
        end
        -- remove two backslashes in \begin{macrocode} and \end{macrocode}
        new_checksum = new_checksum - 2
    end
    print("New checksum: " .. new_checksum)

    -- replace the checksum
    content = content:gsub("(\\CheckSum%s*{%s*)" .. old_checksum .. "(%s*})",
                           "%1" .. new_checksum .. "%2")

    -- write the file
    local fout = assert(io.open(filename, "wb"), "Failed to write file: " .. filename)
    fout:write(content)
    fout:close()

    print("Checksum updated successfully.")
end

-- read filename from argument
local filename = arg[1]

-- check if filename is not nil and ends with .dtx
if filename and filename:match("%.dtx$") then
    -- fix the checksum of a certain file
    local status, errorinfo = pcall(update_checksum, filename)
    if not status then
        print(errorinfo)
    end
    os.exit(status)
end
