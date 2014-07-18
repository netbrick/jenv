#!/bin/sh

jenv_bash_profile="${HOME}/.bash_profile"
jenv_profile="${HOME}/.profile"

JENV_DIR="$HOME/.jenv"

jenv_init_snippet=$( cat << EOF
source "${JENV_DIR}/bin/jenv-init.sh" && source "${JENV_DIR}/commands/completion.sh"
EOF
)

if [  -e "${jenv_bash_profile}" ]; then
	if [[ ! `grep 'jenv-init.sh' "${jenv_bash_profile}"` ]]; then
		echo -e "${jenv_init_snippet}" >> "${jenv_bash_profile}"
	fi
else
	if [[ ! `grep 'jenv-init.sh' "${jenv_profile}"` ]]; then
     		echo -e "${jenv_init_snippet}" >> "${jenv_profile}"
	fi
fi
