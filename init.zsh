function scd() {
	if [[ -z "$1" || -z "$2" ]]; then
		echo "Usage: $0 dir1 dir2"
		return 64
	else
		dir1=$(realpath $1)
		dir2=$(realpath $2)

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
				cd $dir1
				tmux split-window "zsh -c 'cd $dir2 ; zsh -i'"
			fi
		else
			echo "One of the dirs does not exist"
		fi
	fi
}
