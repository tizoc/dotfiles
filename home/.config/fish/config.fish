set -x CAML_LD_LIBRARY_PATH /Users/bruno/.opam/system/lib/stublibs /usr/local/lib/ocaml/stublibs
set -x PERL5LIB /Users/bruno/.opam/system/lib/perl5
set -x OCAML_TOPLEVEL_PATH /Users/bruno/.opam/system/lib/toplevel
set -x MANPATH /Users/bruno/.opam/system/man /usr/local/share/man /usr/share/man
set -x PATH /Users/bruno/.opam/system/bin /usr/bin /bin /usr/sbin /sbin /usr/local/bin

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
