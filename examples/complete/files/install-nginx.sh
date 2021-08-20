#!/bin/bash
sleep 30
sudo apt update
sudo apt install nginx -y
sudo sed 's/80/9100/g' -i /etc/nginx/sites-enabled/default
sudo chmod 777 /var/www/html/index.nginx-debian.html
sudo echo "<h1>This is a test site</h1><h2> Please uninstall nginx before starting tamr</h2>" > /var/www/html/index.nginx-debian.html
sudo systemctl restart nginx
