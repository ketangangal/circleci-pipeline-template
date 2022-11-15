# Download the launch agent binary and verify the checksum
mkdir configurations
cd configurations
curl https://raw.githubusercontent.com/CircleCI-Public/runner-installation-files/main/download-launch-agent.sh > download-launch-agent.sh
export platform=linux/amd64 && sh ./download-launch-agent.sh

# Create the circleci user & working directory
id -u circleci &>/dev/null || sudo adduser --disabled-password --gecos GECOS circleci

sudo mkdir -p /var/opt/circleci
sudo chmod 0750 /var/opt/circleci
sudo chown -R circleci /var/opt/circleci /opt/circleci/circleci-launch-agent

# Create a CircleCI runner configuration
sudo mkdir -p /etc/opt/circleci
sudo touch /etc/opt/circleci/launch-agent-config.yaml

# Add API in the file and change permissions
    # api:
    #   auth_token: AUTH_TOKEN

    # runner:
    #   name: RUNNER_NAME
    #   working_directory: /var/opt/circleci/workdir
    #   cleanup_working_directory: true

sudo chown circleci: /etc/opt/circleci/launch-agent-config.yaml
sudo chmod 600 /etc/opt/circleci/launch-agent-config.yaml

# Enable the systemd unit
sudo touch /usr/lib/systemd/system/circleci.service
    # Put Content in the circleci.service
    # [Unit]
    # Description=CircleCI Runner
    # After=network.target
    # [Service]
    # ExecStart=/opt/circleci/circleci-launch-agent --config /etc/opt/circleci/launch-agent-config.yaml
    # Restart=always
    # User=circleci
    # NotifyAccess=exec
    # TimeoutStopSec=18300
    # [Install]
    # WantedBy = multi-user.target
sudo chown root: /usr/lib/systemd/system/circleci.service
sudo chmod 644 /usr/lib/systemd/system/circleci.service

# Start CircleCI
sudo systemctl enable circleci.service
sudo systemctl start circleci.service