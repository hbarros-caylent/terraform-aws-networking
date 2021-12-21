#!/bin/bash
sleep 30
sudo apt update
sudo apt install nginx -y
sudo echo 'server { listen ${tamr_unify_port} default_server; root /var/www/html; index index.nginx-debian.html; server_name _; location / { try_files $uri $uri/ =404;}}' > /etc/nginx/sites-enabled/default
sudo chmod 777 /var/www/html/index.nginx-debian.html
sudo echo "<h1>This is a test site</h1><h2> Please uninstall nginx before starting tamr</h2>" > /var/www/html/index.nginx-debian.html
sudo systemctl restart nginx
