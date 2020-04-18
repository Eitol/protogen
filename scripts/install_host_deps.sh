if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

install_docker() {
  ${_sudo} apt-get update
  ${_sudo} apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  ${_sudo} curl -fsSL https://download.docker.com/linux/ubuntu/gpg | ${_sudo} apt-key add -
  ${_sudo} apt-key fingerprint 0EBFCD88
  ${_sudo} add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu disco stable"
  ${_sudo} apt-get update
  ${_sudo} apt-get install docker-ce -y
  if [[ "${USER}" != "" ]]; then
    ${_sudo} usermod -aG docker "${USER}"
    ${_sudo} newgrp docker
  fi
}

install_docker