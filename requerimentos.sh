dnf update
dnf install -y oraclelinux-developer-release-el8
dnf install -y terraform
terraform -install-autocomplete
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
dnf install -y git
