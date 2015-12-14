#WEB ENCODER
export CTFHELP=$CTFHELP"
urlencode <string> will print the string encoded as url.

					depends on xxd"
urlencode() {
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%s' "$c" | xxd -p -c1 |
                   while read c; do printf '%%%s' "$c"; done ;;
        esac
    done
}

export CTFHELP=$CTFHELP"
urlencode <string> will decode a string encoded as url."
urldecode() {
    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//"%"/\\x}"
}

