#!/bin/sh

# dockerインストール
if ! type docker >/dev/null 2>&1; then
    echo "[install docker]"
    sudo apt-get update
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
fi

# docker composeのインストール
if ! type docker-compose >/dev/null 2>&1; then
    echo "[install docker-compose]"
    sudo curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# gitのインストール
if ! type docker >/dev/null 2>&1; then
    echo "[install git]"
    sudo apt-get update
    sudo apt-get install git
fi

# gitからクローン
if [ ! -e '~/time_checker2' ]; then
    echo "[clone time_checker2]"
    git clone https://github.com/godyp/time_checker2.git
    cd ~/time_checker2
fi

# 環境構築
cd ~/time_checker2
sudo docker-compose build
sudo docker-compose up


# docker hubからイメージファイルを取得


# docker-composeで環境構築
# railsのインストール
# sudo docker-compose run rails rails new . --api --force --database=mysql --skip-bundle
# railsのdatabase.ymlの設定
# mv ./database.yml ./docker/rails/config/database.yml
# ビルドする
# sudo docker-compose build
# reactのインストール
# sudo docker-compose run --rm react sh -c "npm install -g create-react-app && create-react-app react"


# sudo docker-compose up -d