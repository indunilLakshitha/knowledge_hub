


echo "Stating to SEND Files . . ."
scp  -i ../devops/keys/share-gift-live.pem -r ../sharegift-web/build/* ubuntu@ec2-18-223-99-186.us-east-2.compute.amazonaws.com:/var/www/share-gift_fe
echo "File Transferred . . ."
