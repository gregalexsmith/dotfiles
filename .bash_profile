# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" 


# -- FUNCTIONS --
git_branch() {
  local branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
  local branch_name=""     # detached HEAD
  local branch_name=${branch_name##refs/heads/}
  echo $branch_name | tr -d '[:space:]'
}

open_github() {
  local base="https://github."
  local remote=$(git config remote.origin.url | cut -f2 -d. | tr ':' /)
  open "https://github.$remote/tree/$(git_branch)"
}

prompt_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

resetdev() {
  exe git checkout main
  exe git pull
  exe git branch -D dev
  exe git checkout -b dev
}

# -- ALIASES --

# docker compose
alias dc="docker-compose"
alias dce="docker-compose exec"
alias dcr="docker-compose restart"

# misc
alias edit="code ~/."
alias load="source ~/.bash_profile"


# -- EXPORT --
export PS1="\u@\h \W\[\033[32m\]\$(prompt_git_branch)\[\033[00m\] $ "
