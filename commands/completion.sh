#!/bin/sh

if [[ "${JENV_SHELL}" == "zsh" ]]; then
   source "${JENV_DIR}/commands/completion-zsh.sh"
else
   source "${JENV_DIR}/commands/completion-bash.sh"
fi
