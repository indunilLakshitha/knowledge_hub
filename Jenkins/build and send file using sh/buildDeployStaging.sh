echo "Building App"
cd ./sharegift-web/
npm run build:production
echo "Sending App"
sudo sh ../sendFiles.sh
