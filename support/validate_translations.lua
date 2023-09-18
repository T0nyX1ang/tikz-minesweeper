-- This is file `validate_translations.lua'.
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

local function validate_translations (filename)
    --[[ validate the translations of a certain dtx file ]]

    -- read the file
    local fin = assert(io.open(filename, "rb"), 'Failed to read file: ' .. filename)
    local lineno = 0
    local flag = true

    print("Validating the translations in " .. filename .. " ...\n")

    for line_content in fin:lines() do
        lineno = lineno + 1
        -- check if the line contains undefined translations
        if line_content:match("\\TransUndefined") then
            flag = false
            print("./" .. filename .. ":" .. lineno .. ": Undefined translation found.")
            print("l." .. lineno .. " " .. line_content .. "\n")
        end
    end
    fin:close()

    print("Output written on stdout (0 pages).\n")
    if not flag then
        os.exit(1)
    end
end

local filename = arg[1]

-- check if filename is not nil and ends with .dtx
if filename and filename:match("%.dtx$") then
    -- fix the checksum of a certain file
    local status, errorinfo = pcall(validate_translations, filename)
    if not status then
        print(errorinfo)
    end
    os.exit(status)
end
