#!/bin/bash

# exit when any command fails
set -e

repo=git@bitbucket.org:hinodelabo/costories_api.git
path=/var/www/app
date=`date +"%Y%m%d%H%M%S"`
release=$path/releases/$date
branch=master

cd $path
echo "Deployment $date started"
git clone $repo --branch=$branch --depth=1 -q $release
echo "Repository cloned"

cd $path
rm -rf $release/storage
ln -s $path/share/storage $release/storage
echo "Storage directories set up"
ln -s $path/share/.env $release/.env
echo "Environment file set up"

echo "Installing composer dependencies...."
cd $release
composer install --no-interaction --prefer-dist --optimize-autoloader

php $release/artisan view:clear --quiet
php $release/artisan cache:clear --quiet
php $release/artisan config:cache --quiet
echo "Cache cleared"

ln -nfs $release $path/current

echo "Deployment ($date) finished"

echo "Reload services: php-fpm"
sudo systemctl reload php-fpm

echo "Reload services: nginx"
sudo systemctl reload nginx

cd $path/releases
find . -maxdepth 1 -name "20*" | sort | head -n -1 | xargs rm -Rf
echo "Cleaned up old deployments"