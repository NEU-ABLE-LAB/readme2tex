#!/bin/bash
# POST-COMMIT hook to convert *.texmd files
# containing LaTeX into *.md files with embedded
# PNGs using readme2tex. Works with private repos 
# and wikis
#
# See also:
#   texmd2md.sh
#   python -m readme2tex -h

echo $(pwd)

if [ ! -z "$postcommit" ]; then
    exit
fi

export postcommit=true

bold=$(tput bold)
color=$(tput setaf 2)
reset=$(tput sgr0)

branch=$(git rev-parse --abbrev-ref HEAD)

# run readme2tex on each changed .texmd file
#find . -name "*.texmd" -exec texmd2md {} \;
find . -name "*.texmd" -print0 | xargs -0 -n1 hooks/texmd2md_per_file.sh

echo
echo "Processed the following files:"
find . -name "*.texmd" -exec echo {} \;
read -p "Do you want to amend changes to the files above now? [Y/n]: " meh
if [ "$meh" = "" ]; then
    meh='Y'
fi

case $meh in
    [Yy] ) ;;
    [Nn] ) exit;;
    * ) exit;;
esac

echo
echo "Amending commit...$color"
git commit --amend --no-edit
echo $reset
echo "You should run '${bold}git push origin :${reset}' to push all branches simultaneously."
echo
