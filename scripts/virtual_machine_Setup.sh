# Setup Docker and update system
sudo apt-get update
sudo apt-get upgrade -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo systemctl status docker

# Add cloud user to docker group
sudo usermod -aG docker cloud
newgrp docker

# Start configuration of self-hosted machine
    ## Self-hosted.sh 
    
## Add circleci to sudo group
sudo usermod -aG docker circleci
newgrp docker

# Setup Google Cloud
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-409.0.0-linux-x86_64.tar.gz
tar -xf google-cloud-cli-409.0.0-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh --path-update true


