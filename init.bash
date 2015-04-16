#!/bin/bash

function scd() {
	local options
	local dir1
	local dir2

	local stopOptionsParsing

	for i in $* ; do
		if [[ -z "$stopOptionsParsing" ]]; then
			if [[ "$i" == "-v" || "$i" == "-h" ]]; then
				if [[ -z "$options" ]]; then
					options=$i
				else
					echo "Usage: $0 [-h|-v] [--] dir1 dir2"
					return 64
				fi
			elif [[ "$i" == "--" ]]; then
				stopOptionsParsing="Y"
			elif [[ -z "$dir1" ]]; then
				dir1=$(realpath -- $i)
			elif [[ -z "$dir2" ]]; then
				dir2=$(realpath -- $i)
			else
				echo "Usage: $0 [-h|-v] [--] dir1 dir2"
				return 64
			fi
		else
			if [[ -z "$dir1" ]]; then
				dir1=$(realpath -- $i)
			elif [[ -z "$dir2" ]]; then
				dir2=$(realpath -- $i)
			else
				echo "Usage: $0 [-h|-v] [--] dir1 dir2"
				return 64
			fi
		fi
	done

	if [[ -z "$dir1" || -z "$dir2" ]]; then
		echo "Usage: $0 [-h|-v] [--] dir1 dir2"
		return 64
	fi

	if [[ -d "$dir1" && -d "$dir2" ]]; then
		if [[ -z "$TMUX" ]]; then
			if [[ -z "$VIM" && -z "$EMACS" ]]; then
				echo "To be implemented"
				return 69
			else
				echo "Will not launch tmux in vim or emacs shell"
				return 78
			fi
		else
			tmux split-window $options "$SHELL -c 'cd $dir2 ; $SHELL -i'"
			cd $dir1
			clear
		fi
	else
		echo "One of the dirs does not exist"
	fi
}
