server {
        listen 80;

        root /var/www/educast-live/educast-fe/build/;
        index index.html ;

        server_name educast.jp;

        location / {
                root /var/www/educast-live/educast-fe/build/;
                index index.html;
                try_files $uri $uri/ /index.html;
        }
        location ~ /\.ht {
                deny all;
        }

}
server {
        listen 80;

        root /var/www/educast-live/educast-fe/build/;
        index index.html ;

        server_name educast.jp;

        location / {
                root /var/www/educast-live/educast-fe/build/;
                index index.html;
                try_files $uri $uri/ /index.html;
        }
        location ~ /\.ht {
                deny all;
        }

}
