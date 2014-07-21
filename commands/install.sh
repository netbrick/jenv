#!/bin/bash

# Simple installation script for jenv
if [ ! $ZSH_NAME ]; then
	COMPLETE='complete'
else
        COMPLETE=''
fi

echo "Checking dependencies"
echo "====================================================="

for cmdName in sed tar git svn curl grep unzip $COMPLETE
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
source "${HOME}/.jenv/bin/jenv-init.sh" && echo "Done, jenv was successfully installed"

