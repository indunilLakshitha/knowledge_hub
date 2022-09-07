echo "Building App"
cd ./sharegift-web/
npm run build:live
echo "Sending App"
sudo sh ../sendFilesLive.sh
