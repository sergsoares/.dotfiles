# Default lab path.
LAB_CONFIG="${HOME}/.dotfiles"

create_bash_lab_config(){
  mkdir -p $LAB_CONFIG
  touch "${LAB_CONFIG}/init"

  echo "source ${LAB_CONFIG}/init" >> ~/.bashrc
}

install_arkade() {
  if ! command -v arkade &> /dev/null; then
    curl -sLS https://get.arkade.dev | sudo sh
    echo 'export PATH=$PATH:$HOME/.arkade/bin/' > $LAB_CONFIG/arkade
    echo "source ${LAB_CONFIG}/arkade" >> $LAB_CONFIG/init
  fi
  echo "arkade exits"
}

install_micro() {
  if ! command -v micro &> /dev/null; then
    sudo apt install micro
    sudo apt update
  fi
  echo "micro exists"
}

install_asdf() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

  echo "source ${LAB_CONFIG}/asdf" >> $LAB_CONFIG/init 


  echo '. $HOME/.asdf/asdf.sh' > $LAB_CONFIG/asdf
  echo '. $HOME/.asdf/completions/asdf.bash' > $LAB_CONFIG/asdf
}

install_brave() {
  sudo apt install -y apt-transport-https curl
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

  sudo apt update
  sudo apt install -y brave-browser
}

install_kubectl(){
  if ! command -v kubectl &> /dev/null; then
        arkade get kubectl
  fi
  echo "kubectl exists"
}

install_docker_compose(){
  if ! command -v docker-compose &> /dev/null; then
        arkade get docker-compose
  fi
  echo "docker-compose exists"
}

install_gh(){
  if ! command -v gh &> /dev/null; then
        arkade get gh
  fi
  echo "gh exists"
}


install_helm(){
  if ! command -v helm &> /dev/null; then
        arkade get helm
  fi
  echo "helm  exists"
}

install_kind(){
  if ! command -v kind &> /dev/null; then
        arkade get kind
  fi
  echo "kind exists"
}

install_terraform(){
  if ! command -v terraform &> /dev/null; then
        arkade get terraform
  fi
  echo "terraform exists"
}

install_vscode(){
  if ! command -v code &> /dev/null; then
	cd /tmp
        curl -LO https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 
        sudo dpkg -i vscode-linux-x64.deb
  fi
  echo "code exists"
}

install_falkon(){
  if ! command -v falkon &> /dev/null; then
        sudo apt-get install -y falkon 
  fi
  echo "falcon exists"
}

install_curl(){
  if ! command -v curl &> /dev/null; then
        sudo apt-get install -y curl 
  fi
  echo "curl exists"
}

install_fish(){
  if ! command -v fish &> /dev/null; then
        sudo apt-get install -y fish
  fi
  echo "curl exists"
}

install_rofi(){
  if ! command -v rofi &> /dev/null; then
        sudo apt-get install -y rofi
  fi
  echo "rofi exists"
}


install_stow(){
  if ! command -v stow &> /dev/null; then
        sudo apt-get install -y stow
  fi
  echo "curl exists"
}

install_ulauncher(){
  if ! command -v ulauncher&> /dev/null; then
	sudo add-apt-repository ppa:agornostal/ulauncher && sudo apt update && sudo apt install -y ulauncher
  fi
  echo "ulauncher exists"
}

install_autojump(){
  if ! command -v autojump&> /dev/null; then
    sudo apt-get install autojump
  fi
  echo "autojump exists"
}


