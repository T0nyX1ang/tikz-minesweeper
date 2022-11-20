"""A simple tool to shift TiKZ path."""

import argparse
import re
import sys
from copy import deepcopy
from decimal import Decimal

parser = argparse.ArgumentParser(
    prog="tikz-path-xyshift.py",
    description="A simple tool to shift TiKZ path.")

parser.add_argument("-x", "--xshift", help="X shift", default="0")
parser.add_argument("-y", "--yshift", help="Y shift", default="0")
parser.add_argument("-p", "--path", help="TiKZ path command", default="")
parser.add_argument(
    "-c",
    "--copy",
    help="Copy new command at the same time (pyperclip needed)",
    action="store_true")
args = parser.parse_args()

try:
    xshift = Decimal(args.xshift)
    yshift = Decimal(args.yshift)
except Exception as e:
    print("Wrong parameter in xshift(%s) or yshift(%s). Please check first." %
          (args.xshift, args.yshift))
    sys.exit(1)

path = args.path
pyperclip_copy_enabled = args.copy

regex_float = r"(-?\d+\.?\d*)"
regex_coord = r"[(]\s*" + regex_float + r"\s*,\s*" + regex_float + r"\s*[)]"

float_pattern = re.compile(regex_float)
coord_pattern = re.compile(regex_coord)

last_end = 0
original_path = deepcopy(path)
for res in re.finditer(coord_pattern, path):
    start, end, matched_str = res.start(), res.end(), res.group(0)

    if '+' not in original_path[last_end:start]:
        old_x, old_y = re.findall(float_pattern, matched_str)
        new_x, new_y = Decimal(old_x) + xshift, Decimal(old_y) + yshift
        replaced_str = matched_str.replace(old_x, str(new_x),
                                           1).replace(old_y, str(new_y), 1)
        path = path.replace(matched_str, replaced_str, 1)  # replace string

    last_end = end  # restore the last end

print('-- Program results ---')
print('X shift:', xshift)
print('Y shift:', yshift)
print('Original:', original_path)
print('Shifted:', path)

if pyperclip_copy_enabled:
    import pyperclip
    pyperclip.copy(path)
