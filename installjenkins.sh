sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo dnf install java-17-amazon-corretto -y
sudo yum install java-17-amazon-corretto -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
sudo yum install docker -y
sudo yum install git -y
sudo groupadd docker
sudo usermod -aG docker $USER
sudo usermod -aG jenkins $USER
sudo chmod 666 /var/run/docker.sock
sudo systemctl restart docker
sudo systemctl restart jenkins
