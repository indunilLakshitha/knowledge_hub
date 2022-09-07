location /api {
                alias /var/www/educast/educast-api/public;
                try_files $uri $uri/ @api;

                location ~ \.php$ {
                        include snippets/fastcgi-php.conf;
                        fastcgi_param SCRIPT_FILENAME $request_filename;
                        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
                }
        }

        location @api {
                rewrite /api/(.*)$ /api/index.php?/$1 last;
        }
}