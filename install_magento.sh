
#!/bin/bash
sudo yum -y update
echo "Install Docker engine"
sudo yum install docker -y
sudo usermod -a -G docker jenkins
sudo service docker start
sudo docker network create magento
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/anupkd/magento-aws/master/docker-compose.yml -o /tmp/docker-compose.yml
sudo curl -L https://raw.githubusercontent.com/anupkd/magento-aws/master/varnish/default.vcl -o /tmp/default.vcl
sudo /usr/local/bin/docker-compose -f /tmp/docker-compose.yml up -d
sudo docker run --name apache2 -dt  --network magento -p 8080:80 anupkkd/magento2:latest
sudo docker run --name varnish -dt --network magento -p 80:80 -v /tmp/default.vcl:/etc/varnish/default.vcl:ro --tmpfs /usr/local/var/varnish:exec  varnish


