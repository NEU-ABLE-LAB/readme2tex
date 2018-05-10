#!/bin/bash
# This script is to be used with the post-commit hooks
# in the comment below to run readme2tex on every file 
# in the working directory (recursively) with the extension
# .texmd to convert any LaTeX in the file into PNGs (placed
# in the svgs/ directory), turning the .texmd files into a 
# .md file used by GitHub. Works with private repos and wikis
#
# Copy the post-commit file to the .git/hooks/ directory.

bold=$(tput bold)
color=$(tput setaf 2)
reset=$(tput sgr0)
 
# Remove "./" from beginning of string produced by find
texmd_fname=$(echo $1 | sed 's/^\.\///')


# Check if texmd was changed
echo "[readme2tex] Checking $texmd_fname for changes."
texmd_changes=$(git diff --name-only HEAD^ | grep "$texmd_fname")

if [ -z "$texmd_changes" ]; then
    echo "    No changes found."
    exit
else
    echo "    Changes found."
fi
 
# Check if md file was change, which would be overwritten
md_fname=$(echo $texmd_fname | sed 's/\.texmd$/.md/')
echo "[readme2tex] Checking $md_fname for changes."
md_changes=$(git diff --name-only HEAD^ | grep "$md_fname")

if ! [ -z "$md_changes" ] ; then
        
    read -p "[readme2tex] ${color}$md_fname$reset has changed.
    
    Would you like to overwrite changes to ${color}$md_fname$reset with ${color}$texmd_fname$reset? [Y/n]:" meh
    
    if [ "$meh" = "" ]; then
        meh='Y'
    fi
    
    case $meh in
        [Yy] ) ;;
        [Nn] ) exit;;
        * ) exit;;
    esac
fi

read -p "[readme2tex] ${color}$texmd_fname$reset has changed; would you like to update ${color}$md_fname$reset as well? This will run

  > python -m readme2tex --output ${color}$md_fname$reset --readme ${color}$texmd_fname$reset --nocdn --pngtrick --usepackage 'tikz' --usepackage 'xcolor'

Would you like to run this now? [Y/n]: " meh

if [ "$meh" = "" ]; then
    meh='Y'
fi

case $meh in
    [Yy] ) ;;
    [Nn] ) exit;;
    * ) exit;;
esac

tput setaf 3
echo
echo "Running readme2tex..."
python -m readme2tex --output $md_fname --readme $texmd_fname --nocdn --pngtrick --usepackage 'tikz' --usepackage 'xcolor'
echo "Completed readme2tex"
result=$?
echo $reset

if [ $result -eq 0 ]; then
    echo "Finished rendering."
    git add $md_fname
    git add svgs/*

else
    echo "$(tput setaf 1)Encountered error while translating $texmd_fname${reset}"
    echo "  Your environment may have changed; please make sure that you go back to a clean state."
    exit 1
fi