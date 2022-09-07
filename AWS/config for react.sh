server {
        listen 80;

        root /var/www/educast-fe/build/;
        index index.html ;

        server_name _;

        location / {
                root /var/www/educast-fe/build/;
                index index.html;
                try_files $uri $uri/ /index.html;
        }
        location ~ /\.ht {
                deny all;
        }

}
server {
        listen 80;

        root /var/www/html/educast-fe/build/;
        index index.html ;

        server_name stg-educast-ceylonsoft.jp;

        location / {
                root /var/www/html/educast-fe/build/;
                index index.html;
                try_files $uri $uri/ /index.html;
        }
        location ~ /\.ht {
                deny all;
        }

}
