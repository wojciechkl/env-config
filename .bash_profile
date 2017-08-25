alias python27='/System/Library/Frameworks/Python.framework/Versions/2.7/bin/python'
export PATH="~/bin:$PATH"
alias svim='vim -u NONE'
export EDITOR='vim'

# Open editor and shell in new window using main-vertical layout.
# Usage: qq [num-panes] [working-directory] [...other-args]
function qq() {
	local panes=1; [[ "$1" =~ ^[0-9]+$ ]] && panes=$1 && shift
	local dir="$PWD"; [[ -d "$1" ]] && dir="$1" && shift
	local win=$(tmux new-window -P -a -c "$dir" -n "$(basename "$dir")")
	for run in {1..$panes}
	do
		tmux split-window -t $win -c "$dir"
	done
	tmux select-layout -t $win main-horizontal
	tmux select-pane -t $win
	tmux send-keys -t $win "$EDITOR $@" Enter
}
alias q2='qq 2'
alias q3='qq 3'

function editnewestfile(){
	tmppath=${1:-.}
	candidate="`ls -t $tmppath | head -1`"
	if [[ -f $tmppath/$candidate ]]; then
		$EDITOR "$tmppath/$candidate"
	else
		echo "$tmppath/$candidate is a directory"
	fi
}

alias elast='editnewestfile'
alias el='editnewestfile'
alias eld='editnewestfile ~/Downloads'

function downloadAndEditAppsLogs(){
	~/bin/log_apps/get_app_logs.sh
	echo "Log files: $resultLogFile"	
	editnewestfile ~/bin/log_apps
}

alias applogs='downloadAndEditAppsLogs'
alias eal='applogs'

function searchInGit(){
	git log --all --grep="$1"
}

function sendFile(){
	echo " send file $1 $2 $3"
	echo "File send" | mutt -a "$3" -s "$2" -- $1
}

function sendFileToMe(){
	sendFile wojciech.klicki@gmail.com "Catch!" "$1"
}

function sendFileToWilk(){
	sendFile michal.wilk@dysant.com "Catch!" "$1"
}

alias git-search='searchInGit'

alias col-stat='~/bin/col_stat.sh'

alias sfWilk='sendFileToWilk'
alias sfMe='sendFileToMe'
. ~/.bashrc
