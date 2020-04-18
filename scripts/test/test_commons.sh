check_file() {
  if [[ -e "$1" ]]; then
    echo -e "\e[92m$2 -> VALID\e[0m"
  else
    echo -e "\e[91m$2 -> INVALID\e[0m"
    exit 1
  fi
}