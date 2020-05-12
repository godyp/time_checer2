#!/bin/sh

# gitもインストールされてない状態からの起動

sudo apt-get update

# dockerインストール
if ! type docker >/dev/null 2>&1; then
    echo "[install docker]"
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
    sudo apt-get install docker-ce docker-ce-cli containerd.io
fi

# docker composeのインストール
if ! type docker-compose >/dev/null 2>&1; then
    echo "[install docker-compose]"
    sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# gitのインストール
if ! type docker >/dev/null 2>&1; then
    echo "[install git]"
    sudo apt-get install git
fi

# gitからクローン
git clone https://github.com/godyp/time_checker2.git

# 環境構築
cd ~/time_checker2
sudo docker-compose run rails rails new . --api --force --database=mysql --skip-bundle
mv ./database.yml ./docker/rails/config/database.yml
sudo docker-compose build
sudo docker-compose run --rm react sh -c "npm install -g create-react-app && create-react-app react-app"
sudo docker-compose up -d
docker-compose run rails rails db:create


# docker hubからイメージファイルを取得