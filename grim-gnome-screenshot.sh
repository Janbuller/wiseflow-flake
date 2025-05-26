#!/usr/bin/env bash

usage() {
    echo "Usage:" 1>&2;
    echo "  $0 [OPTION...]" 1>&2
    exit 1
}
c=""
w=""
a=""
p=""
f=""

while getopts ":cwpaf:" o; do
    case "${o}" in
        c)
            c=" - | wl-copy"
            ;;
        w)
            w=""
            ;;
        a)
            a=" -g \"\$(slurp -d)\""
            ;;
        p)
            p="-c"
            ;;
        f)
            f="\"${OPTARG}\""
            ;;
        *)
            usage
            ;;
    esac
done

cmd="grim $w $p $a $f $c"
eval "$cmd"
