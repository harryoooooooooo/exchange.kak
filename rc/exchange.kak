declare-option -hidden range-specs exchange_target
add-highlighter global/exchange ranges exchange_target

define-command -docstring '
exchange [clear]: Exchange the contents of two selections.
`:exchange` to mark the first selection, then the second
`:exchange` exchanges the marked selection and the current.
`:exchange clear` to clear the mark.' \
    -params 0..1 -shell-script-completion %{echo clear} \
    exchange %{ evaluate-commands %sh{
    if [ "$1" = clear ]; then
        echo 'set-option window exchange_target 0'
        exit
    fi

    set -- ${kak_opt_exchange_target}
    shift
    target=${1%%|*}

    if [ -z "${target}" ]; then
        printf 'set-option window exchange_target %s "%s"\n' \
            "${kak_timestamp}" "${kak_selection_desc}|black,yellow+F"
        exit
    fi

    IFS=., cur=(${kak_selection_desc})
    IFS=., tar=(${target})

    point_greater() {
        local x1=$1 y1=$2 x2=$3 y2=$4
        ((x1 > x2 || (x1 == x2 && y1 > y2)))
    }

    if point_greater ${cur[0]} ${cur[1]} ${cur[2]} ${cur[3]}; then
        IFS=' ' cur=(${cur[2]} ${cur[3]} ${cur[0]} ${cur[1]})
    fi

    if point_greater ${cur[0]} ${cur[1]} ${tar[2]} ${tar[3]} ||
       point_greater ${tar[0]} ${tar[1]} ${cur[2]} ${cur[3]}; then
        printf 'exchange clear\n'
        printf 'execute-keys %%{%s}\n' \
            " y<c-s>:select ${target}<ret>pd<c-o>R"
    else
        printf 'fail Selections overlap\n'
    fi
}}
