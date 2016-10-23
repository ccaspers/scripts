# fork-function to detach processes conveniently
fork() { (setsid "$@" &>/dev/null); }
export -f fork

# add mirror function to download websites recursively
mirror() {
  if ! [[ "$@" =~ ^https?://* ]]; then
    echo "URLs should start with protocol http(s)://. Given <$@>"
    return -1
  fi
  domain=$(echo $@ | awk -F/ '{print $3}')
  wget \
    --recursive \
    --no-clobber \
    --page-requisites \
    --html-extension \
    --convert-links \
    --restrict-file-names=windows \
    --domains $domain \
    --level 10\
    --no-check-certificate\
    $@
}
export -f mirror

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  open() { fork xdg-open "$@"; }
  export -f open
fi
