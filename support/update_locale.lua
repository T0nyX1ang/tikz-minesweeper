-- This is file `update_locale.lua'.
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

local function update_locale(filename, locale)
    --[[ update the locale of a certain dtx file ]]

    -- read the file
    local fin = assert(io.open(filename, "rb"), 'Failed to read file: ' .. filename)
    local content = fin:read("*all")
    fin:close()

    -- replace the checksum
    content = content:gsub("translation/%w+.tex", "translation/" .. locale .. ".tex")

    -- write the file
    local fout = assert(io.open(filename, "wb"), 'Failed to write file: ' .. filename)
    fout:write(content)
    fout:close()

    print("Localed updated successfully.")
end

-- read filename from argument
local filename = arg[1]
local locale = arg[2]

if not locale then
    print("Parameter <locale> is missing.")
    os.exit(false)
end

-- check if filename is not nil and ends with .dtx
if filename and filename:match("%.dtx$") then
    -- fix the checksum of a certain file
    local status, errorinfo = pcall(update_locale, filename, locale)
    if not status then
        print(errorinfo)
    end
    os.exit(status)
end
