autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%b'

export VIRTUAL_ENV_DISABLE_PROMPT=1
unsetopt PROMPT_SUBST

: ${PROMPT_MAX_WIDTH:=60}
: ${PROMPT_NEWLINE_THRESHOLD:=60}

_PROMPT_PY_IMAGE_PATH="${${(%):-%x}:A:h:h:h}/assets/python-logo-only.png"
_PROMPT_NIX_IMAGE_PATH="${${(%):-%x}:A:h:h:h}/assets/nix-logo-only.png"
typeset -gA _PROMPT_IMAGE_IDS=()

_prompt_truncate_middle() {
    local value=$1 limit=$2

    if (( ${#value} <= limit )); then
        REPLY=$value
    elif (( limit <= 1 )); then
        REPLY='…'
    else
        local left=$(( limit / 2 ))
        local right=$(( limit - 1 - left ))

        if (( right == 0 )); then
            REPLY="${value[1,$left]}…"
        else
            REPLY="${value[1,$left]}…${value[-$right,-1]}"
        fi
    fi
}

_prompt_keep_branch_end() {
    local value=$1 limit=$2

    if (( ${#value} <= limit )); then
        REPLY=$value
    elif (( limit <= 1 )); then
        REPLY='…'
    else
        REPLY="…${value[-$(( limit - 1 )),-1]}"
    fi
}

_prompt_render_logo() {
    local logo_name=$1 image_path=$2 image_id_prefix=$3 fallback=$4

    REPLY=$fallback
    [[ -n $KITTY_WINDOW_ID && -r $image_path ]] || return

    local image_id=${_PROMPT_IMAGE_IDS[$logo_name]-}
    if [[ -z $image_id ]]; then
        local encoded_path
        encoded_path=$(printf '%s' "$image_path" | base64 -w0) || return
        image_id=$(( image_id_prefix | ($$ & (image_id_prefix - 1)) ))
        _PROMPT_IMAGE_IDS[$logo_name]=$image_id

        local graphics_command=$'\e_G'"a=T,f=100,t=f,U=1,C=1,q=2,i=${image_id},c=2,r=1;${encoded_path}"$'\e\\'
        if [[ -n $TMUX ]]; then
            graphics_command=${graphics_command//$'\e'/$'\e\e'}
            graphics_command=$'\ePtmux;'"${graphics_command}"$'\e\\'
        fi

        print -rn -- "$graphics_command"
    fi

    local red=$(( (image_id >> 16) & 255 ))
    local green=$(( (image_id >> 8) & 255 ))
    local blue=$(( image_id & 255 ))
    local esc=$'\e'

    REPLY="%{${esc}[38;2;${red};${green};${blue}m%}"$'\U10EEEE\u0305\u0305\U10EEEE'"%{${esc}[39m%}"
}

# Layout helpers share precmd's local variables through zsh's dynamic scoping.
_prompt_update_width() {
    width=$(( ${#indicator_part} + ${#host_part} + ${#cwd_display} + ${#branch_part} ))
}

_prompt_limit_branch() {
    (( width > max_width )) || return

    if (( ${#branch} > 24 )); then
        _prompt_keep_branch_end "$branch" 24
        branch=$REPLY
    fi

    [[ -n $branch ]] && branch_part=" $branch"
    _prompt_update_width
}

_prompt_abbreviate_parent_directories() {
    (( width > max_width )) && [[ $cwd_display == */* ]] || return

    local path_prefix='' rest=$cwd_display
    local -a dirs

    if [[ $rest == '~/'* ]]; then
        path_prefix='~/'
        rest=${rest#\~/}
    elif [[ $rest == /* ]]; then
        path_prefix='/'
        rest=${rest#/}
    fi

    dirs=("${(@s:/:)rest}")
    local i

    for (( i = 1; i < ${#dirs} && width > max_width; i++ )); do
        if [[ $dirs[i] == .* && ${#dirs[i]} -gt 1 ]]; then
            dirs[i]=${dirs[i][1,2]}
        else
            dirs[i]=${dirs[i][1]}
        fi

        cwd_display="${path_prefix}${(j:/:)dirs}"
        _prompt_update_width
    done
}

_prompt_reduce_branch() {
    while (( width > max_width && ${#branch} > 6 )); do
        _prompt_keep_branch_end "$vcs_info_msg_0_" $(( ${#branch} - 1 ))
        branch=$REPLY
        branch_part=" $branch"
        _prompt_update_width
    done
}

_prompt_make_room_for_leaf() {
    local leaf=${cwd_display:t}
    local leaf_space=$(( ${#leaf} + 1 ))

    if (( width > max_width && max_width - width + ${#cwd_display} < leaf_space )) && [[ -n $branch_part ]]; then
        branch_part=''
        _prompt_update_width
    fi

    if (( width > max_width && max_width - width + ${#cwd_display} < leaf_space )); then
        local host_space=$(( max_width - ${#indicator_part} - ${#branch_part} - leaf_space ))
        if (( host_space >= 4 )); then
            _prompt_truncate_middle "$host" $(( host_space - 3 ))
            host_part="[$REPLY] "
        else
            host_part=''
        fi
        _prompt_update_width
    fi

    if (( width > max_width && max_width - width + ${#cwd_display} < leaf_space )) && [[ -n $nix_part ]]; then
        nix_part=''
        indicator_part=$venv_part
        _prompt_update_width
    fi

    if (( width > max_width && max_width - width + ${#cwd_display} < leaf_space )) && [[ -n $venv_part ]]; then
        venv_part=''
        indicator_part=''
        _prompt_update_width
    fi
}

_prompt_trim_path_to_width() {
    (( width > max_width )) || return

    local path_space=$(( max_width - width + ${#cwd_display} ))
    if (( path_space <= 0 )); then
        cwd_display=''
    elif (( path_space == 1 )); then
        cwd_display='…'
    elif (( ${#cwd_display} > path_space )); then
        cwd_display="…${cwd_display[-$(( path_space - 1 )),-1]}"
    fi

    _prompt_update_width
}

_prompt_fit_minimum_layout() {
    if (( width > max_width )); then
        branch_part=''
        _prompt_update_width
    fi

    if (( width > max_width )); then
        local host_space=$(( max_width - ${#indicator_part} - ${#cwd_display} ))
        if (( host_space >= 4 )); then
            _prompt_truncate_middle "$host" $(( host_space - 3 ))
            host_part="[$REPLY] "
        else
            host_part=''
        fi
        _prompt_update_width
    fi

    if (( width > max_width )) && [[ -n $nix_part ]]; then
        nix_part=''
        indicator_part=$venv_part
        _prompt_update_width
    fi

    if (( width > max_width )); then
        venv_part=''
        indicator_part=''
        _prompt_update_width
    fi

    if (( width > max_width )); then
        local path_space=$(( max_width - ${#host_part} ))
        if (( path_space <= 0 )); then
            cwd_display=''
        elif (( path_space == 1 )); then
            cwd_display='…'
        else
            cwd_display="…${cwd_display[-$(( path_space - 1 )),-1]}"
        fi
    fi
}

_prompt_render() {
    host_part=${host_part//\%/%%}
    cwd_display=${cwd_display//\%/%%}
    branch_part=${branch_part//\%/%%}

    local indicator_display=''
    if [[ -n $nix_part ]]; then
        _prompt_render_logo nix "$_PROMPT_NIX_IMAGE_PATH" 0x400000 'N '
        indicator_display=$REPLY
    fi

    if [[ -n $venv_part ]]; then
        _prompt_render_logo python "$_PROMPT_PY_IMAGE_PATH" 0x800000 '* '
        indicator_display+=$REPLY
    fi

    _prompt_update_width
    local marker_separator=' '
    (( width + 3 > newline_threshold )) && marker_separator=$'\n'

    PROMPT="${indicator_display}%F{magenta}${host_part}%F{blue}${cwd_display}%f%F{red}${branch_part}%f${marker_separator}${marker} "
}

precmd() {
    vcs_info

    local max_width=$PROMPT_MAX_WIDTH
    [[ $max_width == <-> ]] || max_width=60
    (( max_width < 3 )) && max_width=3

    local newline_threshold=$PROMPT_NEWLINE_THRESHOLD
    [[ $newline_threshold == <-> ]] || newline_threshold=60

    local host=${HOST%%.*} cwd_display=$PWD branch=$vcs_info_msg_0_
    local marker='$' host_part="[${HOST%%.*}] " nix_part='' venv_part='' indicator_part='' branch_part='' width

    [[ $USER == root ]] && marker='#'

    if [[ $PWD == $HOME ]]; then
        cwd_display='~'
    elif [[ $PWD == $HOME/* ]]; then
        cwd_display="~${PWD#$HOME}"
    fi

    [[ -n $IN_NIX_SHELL ]] && nix_part='  '
    [[ -n $VIRTUAL_ENV ]] && venv_part='  '
    indicator_part="${nix_part}${venv_part}"

    [[ -n $branch ]] && branch_part=" $branch"
    _prompt_update_width

    _prompt_limit_branch
    _prompt_abbreviate_parent_directories
    _prompt_reduce_branch
    _prompt_make_room_for_leaf
    _prompt_trim_path_to_width
    _prompt_fit_minimum_layout
    _prompt_render
}
