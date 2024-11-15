#!/bin/bash

BOLD=$(tput bold)
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
CYAN=$(tput setaf 6)

print_command() {
  echo -e "${BOLD}${YELLOW}$1${RESET}"
}

echo -e "${GREEN}Rivalz 노드 설치를 시작합니다.${RESET}"

cd $HOME

# 기존 폴더가 존재한다면 삭제합니다.
if [ -d "/root/.rivalz" ]; then
  echo -e "${RED}폴더가 존재하므로 삭제합니다.${RESET}"
  sudo rm -rf /root/.rivalz
fi

# NVM이 이미 설치되어 있는지 확인
if [ -d "$HOME/.nvm" ] || [ -d "/usr/local/share/nvm" ]; then
    print_command "NVM이 이미 설치되어 있습니다."
else
    echo -e "${BOLD}NVM과 Node 설치 중...${RESET}"
    
    # NVM(Node Version Manager)과 Node.js를 설치합니다.
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
fi

# NVM 디렉터리를 설정합니다.
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

# nvm.sh 파일이 있는지 확인한 후, 로드합니다.
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
elif [ -s "/usr/local/share/nvm/nvm.sh" ]; then
    . "/usr/local/share/nvm/nvm.sh"
else
    echo -e "${RED}오류: nvm.sh 파일을 찾을 수 없습니다!${RESET}"
    exit 1
fi

# nvm bash_completion이 있으면 로드합니다.
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo -e "${BOLD}Node 버전 관리자를 사용 중...${RESET}"

# nvm을 사용하여 Node.js를 설치하고 사용합니다.
nvm install 20
nvm use 20

# npm이 설치되어 있는지 확인
if ! command -v npm &> /dev/null; then
    print_command "npm이 설치되어 있지 않습니다. npm을 설치합니다..."
    # npm이 없을 경우 설치합니다.
    curl -L https://www.npmjs.com/install.sh | sh
else
    print_command "npm이 이미 설치되어 있습니다."
fi

echo -e "${BOLD}Rivalz CLI 패키지 설치 중...${RESET}"

# Rivalz CLI 패키지를 전역으로 설치합니다.
npm i -g rivalz-node-cli

echo -e "${BOLD}Rivalz 노드 실행 중...${RESET}"

# 노드를 실행합니다.
rivalz run

echo -e "${GREEN}모든 작업이 완료되었습니다. 컨트롤+A+D로 스크린을 종료해주세요.${RESET}"
echo -e "${GREEN}스크립트 작성자: https://t.me/kjkresearch${RESET}"
