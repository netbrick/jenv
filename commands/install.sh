#!/bin/bash

# Simple installation script for jenv
if [[ ! "${JENV_DIR}" ]]; then
	JENV_DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )
	JENV_DIR=${JENV_DIR%/commands}
fi

export JENV_DIR

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

if [[ $(whoami) == 'root' ]]; then

	touch '/etc/profile.d/jenv.sh'
	if [[ -z `grep "jenv-init.sh" "/etc/profile.d/jenv.sh"` ]]; then
		jenv_profile_global=$( echo '[[ -z `grep "jenv-init.sh" "${HOME}/.profile"` ]] && export JENV_GLOBAL="true" && export JENV_DIR=/usr/local/jenv && source "${JENV_DIR}/bin/jenv-init.sh" && source "${JENV_DIR}/commands/completion.sh"' )

		echo -e $jenv_profile_global >> /etc/profile.d/jenv.sh
	fi

	JENV_DIR='/usr/local/jenv'
	JENV_GLOBAL='true'

	export JENV_DIR
	export JENV_GLOBAL
fi

echo -e "Running ${JENV_DIR}/bin/jenv-init.sh ..."
source "${JENV_DIR}/bin/jenv-init.sh" && echo "Done, jenv was successfully installed"
