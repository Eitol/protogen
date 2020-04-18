if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

${_sudo} apt-get install curl wget git build-essential dialog apt-utils  unzip  -y

