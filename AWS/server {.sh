server {
        listen 80;

        root /var/www/sharewell-api/public;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.php;

        server_name _;


        access_log /var/log/nginx/api-access.log combined;
        error_log /var/log/nginx/api-error_log warn;
        charset utf-8;
        gzip on;
             gzip_types text/css application/javascript text/javascript application/x-javascript  image/svg+xml text/plain text/xsd text/xsl text/xml image/x-icon;

        location / {
                try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php {
                include fastcgi.conf;
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                fastcgi_pass unix:/run/php-fpm/www.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}

api.share-wellbeing.com www.api.share-wellbeing.com