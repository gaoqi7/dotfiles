# removes user@hostname from agnoster prompt
prompt_context() {
	 if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
       prompt_segment black default "%(!.%{%F{yellow}%}.)"
         fi
         }
