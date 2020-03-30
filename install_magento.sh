
#!/bin/bash
sudo yum -y update
echo "Install Docker engine"
sudo yum install docker -y
sudo usermod -a -G docker jenkins
sudo service docker start
docker run -dt -p 80:80 anupkkd/magento2:latest