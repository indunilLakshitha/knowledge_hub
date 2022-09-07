echo "Stating to SEND Files . . ."
scp -i ../devops/keys/share-gift.pem  -r ../sharegift-web/build/* ubuntu@ec2-18-222-233-164.us-east-2.compute.amazonaws.com:/var/www/sharegift/share-gift_fe/
echo "File Transferred . . ."
