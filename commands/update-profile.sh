#!/bin/sh

# Dont edit user profile files on global install
if [ $JENV_GLOBAL ]; then
	return 0
fi

jenv_bash_profile="${HOME}/.bash_profile"
jenv_profile="${HOME}/.profile"
jenv_bashrc="${HOME}/.bashrc"
jenv_zshrc="${HOME}/.zshrc"

if [[ -z "${JENV_DIR}" ]]; then
	JENV_DIR=$( cd $( dirname "${BASH_SOURCE[0]:-$0}" ) && pwd )
        JENV_DIR=${JENV_DIR%/commands}
fi

JENV_SHELL="bash"

if [ $ZSH_NAME ]; then
   	JENV_SHELL="zsh"
fi

jenv_init_snippet=$( cat << EOF
source "${JENV_DIR}/bin/jenv-init.sh" && source "${JENV_DIR}/commands/completion.sh"
EOF
)

if [ ! -f "${jenv_bash_profile}" -a ! -f "${jenv_profile}" ]; then
	echo "#!/bin/bash" > "${jenv_bash_profile}"
    	echo "${jenv_init_snippet}" >> "${jenv_bash_profile}"
    	echo "Created and initialised ${jenv_bash_profile}"
else
    	if [ -f "${jenv_bash_profile}" ]; then
        	if [[ -z `grep 'jenv-init.sh' "${jenv_bash_profile}"` ]]; then
            		echo -e "\n${jenv_init_snippet}" >> "${jenv_bash_profile}"
            		echo "Updated existing ${jenv_bash_profile}"
        	fi
    	fi

    	if [ -f "${jenv_profile}" ]; then
        	if [[ -z `grep 'jenv-init.sh' "${jenv_profile}"` ]]; then
            		echo -e "\n${jenv_init_snippet}" >> "${jenv_profile}"
            		echo "Updated existing ${jenv_profile}"
        	fi
    	fi
fi

if [[ "${JENV_SHELL}" == 'bash' ]];then
	if [ ! -f "${jenv_bashrc}" ]; then
    		echo "#!/bin/bash" > "${jenv_bashrc}"
    		echo "${jenv_init_snippet}" >> "${jenv_bashrc}"
    		echo "Created and initialised ${jenv_bashrc}"
	else
    		if [[ -z `grep 'jenv-init.sh' "${jenv_bashrc}"` ]]; then
        		echo -e "\n${jenv_init_snippet}" >> "${jenv_bashrc}"
        		echo "Updated existing ${jenv_bashrc}"
    		fi
	fi
elif [[ "${JENV_SHELL}" == 'zsh' ]];then
	if [ ! -f "${jenv_zshrc}" ]; then
  		echo "Attempt update of zsh profiles..."
  		echo "${jenv_init_snippet}" >> "${jenv_zshrc}"
		echo "Created and initialised ${jenv_zshrc}"
	else
  		if  [[ -z `grep 'jenv-init.sh' "${jenv_zshrc}"` ]]; then
     			echo -e "\n${jenv_init_snippet}" >> "${jenv_zshrc}"
     			echo "Updated existing ${jenv_zshrc}"
  		fi
	fi
fi
