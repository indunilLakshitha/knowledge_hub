fallocate -l 4G /swapfile
fallocate -l 3G /swapfile
chmod 600 /swapfile
mkswap  /swapfile
swapon /swapfile
swapon  --show
free -h


htop for usage
