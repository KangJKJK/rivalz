#!/bin/bash

BOLD=$(tput bold)
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)

print_command() {
  echo -e "${BOLD}${YELLOW}$1${RESET}"
}

echo -e "${GREEN}Rivalz노드 설치를 시작합니다.${NC}"

cd $HOME

# NVM이 이미 설치되어 있는지 확인
if [ -d "$HOME/.nvm" ] || [ -d "/usr/local/share/nvm" ]; then
    print_command "NVM이 이미 설치되어 있습니다."
else
    print_command "NVM과 Node 설치 중..."
    # NVM(Node Version Manager)과 Node.js를 설치합니다.
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
fi

# NVM 디렉터리를 설정합니다.
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

# nvm.sh 파일이 있는지 확인한 후, 로드합니다.
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
elif [ -s "/usr/local/share/nvm/nvm.sh" ]; then
    . "/usr/local/share/nvm/nvm.sh"
else
    echo "오류: nvm.sh 파일을 찾을 수 없습니다!"
    exit 1
fi

# nvm bash_completion이 있으면 로드합니다.
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

print_command "Node 버전 관리자를 사용 중..."
# nvm을 사용하여 Node.js를 설치하고 사용합니다.
nvm install node
nvm use node

# npm이 설치되어 있는지 확인
if ! command -v npm &> /dev/null
then
    print_command "npm이 설치되어 있지 않습니다. npm을 설치합니다..."
    # npm이 없을 경우 설치합니다.
    curl -L https://www.npmjs.com/install.sh | sh
else
    print_command "npm이 이미 설치되어 있습니다."
fi

print_command "Rivalz CLI 패키지 설치 중..."
# Rivalz CLI 패키지를 전역으로 설치합니다.
npm i -g rivalz-node-cli

print_command "Rivalz 노드 실행 중..."
# Rivalz 노드를 실행합니다.
rivalz run

echo -e "${GREEN}모든 작업이 완료되었습니다. 컨트롤+A+D로 스크린을 종료해주세요.${NC}"
echo -e "${GREEN}스크립트 작성자: https://t.me/kjkresearch${NC}"
