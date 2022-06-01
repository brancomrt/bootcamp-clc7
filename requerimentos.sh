sudo dnf update -y
sudo dnf install oraclelinux-developer-release-el8 -y
sudo dnf install terraform -y
terraform -install-autocomplete
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo dnf install git -y
