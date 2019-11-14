# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" 

# -- ALIASES --
alias dc="docker-compose"
alias dce="docker-compose exec"
alias dcr="docker-compose restart"

# -- FUNCTIONS --
git_branch() {
  local branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
  local branch_name=""     # detached HEAD
  local branch_name=${branch_name##refs/heads/}
  echo $branch_name | tr -d '[:space:]'
}

# -- ALIASES --
open_github() {
  local base="https://github."
  local remote=$(git config remote.origin.url | cut -f2 -d. | tr ':' /)
  open "https://github.$remote/tree/$(git_branch)"
}

alias gh=open_github

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# -- export --
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
