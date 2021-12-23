#!/usr/bin/env bash
# Focus window from 1st argument or
# executes command from 2nd argument
wmctrl -ia $(wmctrl -l | grep -i ${1} | awk '{print $1}') || ${2} &
