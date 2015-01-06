# Fish git prompt

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showstashstate 'yes'
set -g __fish_git_prompt_showupstream 'yes'

set -g __fish_git_prompt_color_branch magenta bold
set -g __fish_git_prompt_showupstream "verbose"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "+"
set -g __fish_git_prompt_char_dirtystate "*"
set -g __fish_git_prompt_char_untrackedfiles "?"
set -g __fish_git_prompt_char_conflictedstate "@"
set -g __fish_git_prompt_char_cleanstate "-"
set -g __fish_git_prompt_char_stashstate "\$"

set -g __fish_git_prompt_color_upstream
set -g __fish_git_prompt_color_dirtystate ff5f00
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green bold
set -g __fish_git_prompt_color_upstream 00afff bold

function fish_prompt --description 'Write out the prompt'

  set -l last_status $status

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  # PWD
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal
  
  printf '%s ' (__fish_git_prompt)
  
  if not test $last_status -eq 0
    set_color $fish_color_error
  end
  
  echo -n '$ '
  
end

set -x PATH ~/bin /usr/local/sbin /usr/local/bin $PATH
set -x DOCKER_HOST tcp://localhost:4243

function docker
  /usr/local/bin/docker -H tcp://127.0.0.1:4243 $argv
end
