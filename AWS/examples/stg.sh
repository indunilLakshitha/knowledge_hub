#!/bin/bash

# exit when any command fails
set -e

repo=git@bitbucket.org:css-git-user/bizeyes.git
path=/var/www/html/bizeyes
date=`date +"%Y%m%d%H%M%S"`
release=$path/releases/$date
branch=${1:-develop}

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

php $release/artisan config:clear --quiet
php $release/artisan view:clear --quiet
php $release/artisan cache:clear --quiet
php $release/artisan config:cache --quiet
php $release/artisan storage:link
echo "Cache cleared"

cd $release
yarn install  && yarn prod
echo "Frontend build success"

ln -nfs $release $path/current
echo "Deployment ($date) finished"

echo "Reload services: php-fpm"
sudo systemctl restart php-fpm

echo "Reload services: nginx"
sudo systemctl restart nginx

php $release/artisan config:clear
# (ls /var/www/app-2/current/app/Package/BugFix/TemplateProcessorExtended.php && cp /var/www/app-2/current/app/Package/BugFix/TemplateProcessorExtended.php /var/www/app-2/current/vendor/phpoffice/phpword/src/PhpWord/TemplateProcessorExtended.php) || echo no

cd $path/releases
find . -maxdepth 1 -name "20*" | sort | head -n -1 | xargs rm -Rf
echo "Cleaned up old deployments"
