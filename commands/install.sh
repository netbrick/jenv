#!/bin/bash

# Simple installation script for jenv
echo "Checking dependencies"
echo "====================================================="

for cmdName in sed tar git svn curl grep unzip complete
do
        type $cmdName >/dev/null 2>&1

        if [ "$?" -eq "0" ] ; then
                printf "\e[32m%12s %15s\e[00m\n" "${cmdName}" "Available"
        else
                printf "\e[31m%12s %15s\e[00m\n" "${cmdName}" "Unavailable"
                exit 1
        fi
done

echo -e "Running ${HOME}/.jenv/bin/jenv-init.sh ..."
source "${HOME}/.jenv/bin/jenv-init.sh"

