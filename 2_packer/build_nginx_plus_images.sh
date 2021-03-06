

cat certs/davidluke.nginxdemo.net.crt.pem certs/davidluke.nginxdemo.net.issuer.pem >certs/davidluke.nginxdemo.net.fullchain.pem


echo "Deploying docker registry"

#sudo  docker run -d -p 5000:5000  --name registry  -v /certs:/certs  -e REGISTRY_HTTP_TLS_CERTIFICATE=certs/crt.pem  -e REGISTRY_HTTP_TLS_KEY=certs/key.pem  registry:2



#docker run -d   --restart=always   --name registry   -v "$(pwd)"/certs:/certs   -e REGISTRY_HTTP_ADDR=0.0.0.0:443 -e REGISTRY_HTTP_TLS_CERTIFICATE=certs/domain.crt   -e REGISTRY_HTTP_TLS_KEY=certs/domain.key  -p 443:443  registry:2

#sudo docker run -d   --restart=always   --name registryX   -v "$(pwd)"/certs:/certs   -e REGISTRY_HTTP_ADDR=0.0.0.0:443 -e REGISTRY_HTTP_TLS_CERTIFICATE=certs/cert.pem   -e REGISTRY_HTTP_TLS_KEY=certs/key.pem  -p 443:443  registry:2


sudo docker run -d   --restart=always   --name registryY   -v "$(pwd)"/certs:/certs   -e REGISTRY_HTTP_ADDR=0.0.0.0:443 -e REGISTRY_HTTP_TLS_CERTIFICATE=certs/davidluke.nginxdemo.net.fullchain.pem   -e REGISTRY_HTTP_TLS_KEY=certs/davidluke.nginxdemo.net.key.pem  -p 443:443  registry:2



echo "The running docker processes are....."

sudo docker ps

# Now we will build an NGINX PLUS docker image

cp certs/nginx-repo.* .

sudo docker build --no-cache -t nginxplus .

NPLUS_IMAGE=`sudo docker images nginxplus |grep nginxplus|awk '{print $3}'`
echo $NPLUS_IMAGE

# We now have our NGINX PLUS IMAGE... Let's push it to our local secure registry

#sudo sh -c 'echo "127.0.0.1 dockerregistry.davidluke.nginxdemo.net">>/etc/hosts'

sudo docker tag $NPLUS_IMAGE dockerregistry.davidluke.nginxdemo.net/nginxplus
sudo docker push dockerregistry.davidluke.nginxdemo.net/nginxplus


