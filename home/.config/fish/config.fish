set -x MANPATH /usr/share/man/
# set -x PATH ~/ocamlbrew/ocaml-4.02.0/bin/ $PATH
eval (opam config env)

# Prompt (user, host, cwd, git branch/status)
function fish_prompt
    printf '%s%s%s' (set_color brown) (hostname|cut -d . -f 1) (set_color normal)

    # Color writeable dirs green, read-only dirs red
    if test -w "."
        printf ' %s%s' (set_color green) (prompt_pwd)
    else
        printf ' %s%s' (set_color red) (prompt_pwd)
    end

    # git (current branch, status)
    if [ -d .git ]
        # branch
        set branch (git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \([^ ]*\)/\1/')
        if [ -z $branch ]
          set branch '__init__'
        end
        echo -n (set_color black)' git:'(set_color yellow)$branch
        # status
        git diff --quiet HEAD ^&-
        if [ $status = 1 ]
            echo -n (set_color red)♺
        else
            echo -n (set_color green)✓
        end
    end

    # cherry
    echo (set_color magenta)' > '
end

# Disable welcome msg
set fish_greeting ""
