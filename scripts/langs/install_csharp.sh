if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

DEFAULT_UBUNTU_VERSION="19.10"

check_ubuntu_version() {
  str="$(cat /etc/issue)"
  IFS=' ' # space is set as delimiter
  read -ra ADDR <<<"$str"
  counter_=0
  for i in "${ADDR[@]}"; do
    if [[ ${counter_} == 0 && "${i}" != "Ubuntu" ]]; then
      echo "other"
      break
    fi
    if [[ ${counter_} == 1 ]]; then
      echo "${i}"
      break
    fi
    counter_=1
  done
}

install_csharp() {
  ubuntu_version="$(check_ubuntu_version)"
  if [[ "${ubuntu_version}" == "other" ]]; then
    ubuntu_version=${DEFAULT_UBUNTU_VERSION}
  fi
  file="packages-microsoft-prod.deb"
  wget https://packages.microsoft.com/config/ubuntu/${ubuntu_version}/${file} -O ${file}
  ${_sudo} dpkg -i ${file}

  ${_sudo} apt-get update
  ${_sudo} apt-get install -y apt-transport-https dotnet-sdk-3.1
}

test_csharp() {
  cd ../test || exit
  bash ./test_csharp.sh
  cd ../langs || exit
}

check_ubuntu_version
install_csharp
test_csharp
