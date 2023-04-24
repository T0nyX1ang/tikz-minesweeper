"""
A tool to calculate checksums and tag dtx files.

This file will be deprecated in next patch version (0.2.3).
The checksum update has been integrated with `texlua`
which ships with a modern LaTeX distribution.
Please use the lua version (update_checksum.lua) instead.
"""

import argparse
import datetime
import os
import sys
from copy import deepcopy


def update_checksum(content: str) -> str:
    """Update the checksum of the content."""
    found_once = content.find("\\CheckSum")
    if found_once == -1:
        print("\\Checksum not found, abort updating.")
        return content

    found_twice = content.find("\\CheckSum", found_once + 1)
    if found_twice >= 0:
        print("Multiple \\CheckSum found, abort updating.")
        return content

    right_bound = content.find("}", found_once + 1)
    old_checksum = content[found_once + 10:right_bound]
    if not old_checksum.isalnum():
        print("Original checksum (%s) is not a number, abort updating." %
              old_checksum)
        return content

    print("Original checksum: %s" % old_checksum)

    new_checksum = 0
    left_macro = content.find("\\begin{macrocode}")
    while left_macro >= 0:
        right_macro = content.find("\\end{macrocode}", left_macro)
        if right_macro == -1:
            print("Unmatched macrocode environments, abort updating.")
            return content
        new_checksum += content[left_macro + 1:right_macro - 1].count("\\")
        left_macro = content.find("\\begin{macrocode}", right_macro)

    print("New checksum: %s" % new_checksum)

    old_checksum_str = "\\CheckSum{%s}" % old_checksum
    new_checksum_str = "\\CheckSum{%s}" % new_checksum
    content = content.replace(old_checksum_str, new_checksum_str)
    print("Checksum updated successfully.")

    return content


def update_tag(content: str, tag: str) -> str:
    """Update the tag of the content."""
    found_package = content.find("\\ProvidesPackage")
    if found_package == -1:
        print("\\ProvidePackage not found, abort updating.")
        return content

    left_bracket = content.find("[", found_package + 1)
    right_bracket = content.find("]", left_bracket + 1)
    if left_bracket >= right_bracket:
        print("Syntax error, abort updating.")
        return content

    old_definition = content[left_bracket + 1: right_bracket]
    parts = old_definition.split()
    if len(parts) < 3:
        print("Syntax error, abort updating.")
        return content

    if " " in tag:
        print("Tag can not contain spaces, abort updating." % tag)
        return content

    print("Accepted new tag: %s" % tag)

    parts[0] = datetime.date.today().strftime("%Y/%m/%d")
    parts[1] = tag

    new_definition = ' '.join(parts)

    content = content.replace(old_definition, new_definition)

    print("Tag updated successfully.")

    return content


cwd = os.getcwd()

parser = argparse.ArgumentParser(
    prog="dtxutils.py",
    description="A tool to calculate checksums and tag dtx files.")

parser.add_argument("-c",
                    "--checksum",
                    help="Update checksum",
                    action="store_true")
parser.add_argument("-f", "--filename", help="Input filename", default="")
parser.add_argument("-t", "--tag", help="Update tag", default="")
args = parser.parse_args()

filename = args.filename
checksum = args.checksum
tag = args.tag

filepath = os.path.normpath(os.path.join(cwd, filename))
if not os.path.exists(filepath):
    print("File (%s) does not exist!" % filepath)
    sys.exit(1)

_, fileext = os.path.splitext(filepath)
if fileext != ".dtx":
    print("Wrong file extension (%s)" % fileext)
    sys.exit(1)

print("Located dtx file: %s" % filepath)

with open(filepath, "r", encoding="utf-8") as f:
    fin = f.read()

updated = deepcopy(fin)
if checksum:
    updated = update_checksum(updated)

if tag:
    updated = update_tag(updated, tag)

with open(filename, "w", encoding="utf-8", newline="\n") as f:
    f.write(updated)  # use LF instead of CRLF
