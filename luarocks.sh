#|------------------------------------------------- |--------- ______-----------------_________---|
#|   ______   __   ______    _____     _____    __  |  _____  |  ____|  __     __    /  _______/  |
#|  |__  __| |  | |__  __|  /     \   |     \  |  | | |__   | | |____  |  |   |  |  /  /______    |
#|    |  |   |  |   |  |   /  /_\  \  |  |\  \ |  | |   /  /  |  ____| |  |   |  |  \______   /   |
#|    |  |   |  |   |  |  /  _____  \ |  | \  \|  | |  /  /_  | |____  |  |___|  |   _____/  /    |
#|    |__|   |__|   |__| /__/     \__\|__|  \_____| | |_____| |______|  \_______/  /________/     |
#|--------------------------------------------------|---------------------------------------------|
#|  This Project Powered by : Pouya Poorrahman CopyRight 2016 Jove Version 4.0 Anti Spam Cli Bot  |
#|------------------------------------------------------------------------------------------------|
#!/bin/bash

read -p "Do you want me to install luarocks? (yes/no):"

if [ "$REPLY" != "yes" ]; then
	echo "
"
else 
        echo "luarocks"
sudo apt-get install luarocks

sudo luarocks install 30log

sudo luarocks install abelhas

sudo luarocks install serpent

sudo luarocks install feedparser

sudo luarocks install lua-cjson

sudo luarocks install luasec

sudo luarocks install luasocket

sudo luarocks install luafilesystem

sudo luarocks install luacrypto

sudo luarocks install luaexpat

sudo luarocks install lub


fi
