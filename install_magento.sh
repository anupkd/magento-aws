
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
sudo docker-compose -f /tmp/docker-compose.yml -d
sudo docker run -dt --network magento -p 80:80 anupkkd/magento2:latest