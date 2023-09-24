CURV=`git tag --sort=committerdate | grep -v conti | tail -n 1`
PREV=`git tag --sort=committerdate | grep -v conti | tail -n 2 | head -n1`

git log ${PREV}..${CURV} > .l
grep ^Author .l | cut -d : -f 2- | uniq > .A

echo "# Release Notes"
echo
echo "## Overview"
echo
echo "- Current version: ${CURV}"
echo "- Previous version: ${PREV}"
echo "- Commits: `grep ^commit .l | wc -l`"
echo "- Contributors: `wc -l .A | awk '{print $1}'`"
echo
echo "## Changes"
echo
cat .l | grep -v ^commit | grep -v ^Author | grep -v ^Date > .x

echo "### Fixed"
echo
cat .x | grep 'Fix' | sed 's/^[ ]*//' | sed 's/^/- /g'
echo

echo "### New Features"
echo
cat .x | grep 'Feat' | sed 's/^[ ]*//' | sed 's/^/- /g'
echo

echo "### Chores / CI"
echo
cat .x | grep 'Chore' | sed 's/^[ ]*//' | sed 's/^/- /g'
cat .x | grep 'CI' | sed 's/^[ ]*//' | sed 's/^/- /g'
echo

echo "Full Changelog: <`git remote get-url origin | sed 's/\.git//g'`/compare/${PREV}...${CURV}>"

rm .l .A .x
