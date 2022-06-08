# Digital Product - BootCamp 
2021 - MBA CLC & DevOps_07

Este projeto tem como objetivo provisionar uma instância EC2 (servidor de monitoramento de infraestrutura) em nuvem pública AWS, que rodará os serviços do Zabbix Server Mysql, Zabbix Web Nginx, Zabbix Agent, MySQL Database em container docker. Também será provisionada uma instância EC2 rodando o serviço Web Nginx em systemd, simulando um "host" que será monitorado. 


Ferramentas que deverão estar instaladas necessárias para criação do ambiente:

- Virtualbox
- Vagrant 
- Git Bash

Criação da máquina virtual via vagrant que conterá instalados o aws cli e terraform. Será o workspace de trabalho.

- Abrir um terminal shell (Git Bash)
- No home do usuário, efeutar o clone do repositório Git https://github.com/brancomrt/bootcamp-clc7.git e executar o comando de instalação da máquina virtual.
```
$ cd ~
$ git clone https://github.com/brancomrt/bootcamp-clc7.git 
$ cd bootcamp-clc7
$ vagrant up
```

- Após o término da criação e carregamento da máquina virtual, logar na máquina e configurar as credenciais do ambiente Learner LAB da cloud AWS no arquivo /home/vagrant/.aws/credentials.

```
$ vagrant ssh
$ aws configure 
$ vim /home/vagrant/.aws/credentials
```

Criação das instâncias EC2 em cloud via terraform:

  - Abrir a console da AWS e verificar que não existe as instâncias Zabbix-Server e Web-Server sendo executadas.

  - Logar na máquina virtual (Workspace bootcamp-clc7):
  ```
	$ cd ~
	$ cd bootcamp-clc7
	$ vagrant ssh
  ```
  - Executar o comando de inicialização do terraform, do plano execuçãO do terraform e de criação da infraestrutura.	
	
	[vagrant@bootcamp-workspace ~]$ cd /vagrant
	[vagrant@bootcamp-workspace ~]$ terraform init
	[vagrant@bootcamp-workspace ~]$ terraform plan
	[vagrant@bootcamp-workspace ~]$ terraform apply
	
- Aguardar a conclusão de criação da infraestrutura em cloud e logo após, verificar na console da AWS se as intâncias foram criadas e estão em execução com "Status check 2/2 checks passed".

Verificar na instância EC2 se os containers do zabbix-server, zabbix-agent, mysql, zabbix-web-nginx estão em execução:

- Fazer o download da chave PEM no ambiente de cloud Learner LAB.

- Copiar para a pasta de workspace bootcamp-clc7.

- Logar na máquina virtual (Workspace bootcamp-clc7):

```
$ cd ~
$ cd bootcamp-clc7
$ vagrant ssh
[vagrant@bootcamp-workspace ~]$ cd /vagrant
[vagrant@bootcamp-workspace ~]$ mv labsuser.pem /home/vagrant/.ssh
[vagrant@bootcamp-workspace ~]$ chmod 600 /home/vagrant/.ssh/labsuser.plan
[vagrant@bootcamp-workspace ~]$ ssh -i ~/.ssh/labsuser.pem ec2-user@[IP_ELASTICO_INSTANCIA_ZABBIX_SERVER]
[ec2-user@zabbix-server-host ~]$ docker ps -a
```

- Verificar que os containers estão em execução.

- Através do IP elástico de cada instância, acessar através do navegador a interface gráfica:

[IP_ELASTICO]:8080  --> Zabbix Server
[IP_ELASTICO]:80    --> Web Server Nginx

Destruição da infraestrutura na AWS:

- Logar na máquina virtual (Workspace bootcamp-clc7):

```
$ cd ~
$ cd bootcamp-clc7
$ vagrant ssh
```

- Executar o comando de inicialização de destruição da infraestrutura:

```
[vagrant@bootcamp-workspace ~]$ cd /vagrant
[vagrant@bootcamp-workspace ~]$ terraform destroy
```
- Aguardar o término da execução.


Recriação da infraestrutura AWS:

- Logar na máquina virtual (Workspace bootcamp-clc7):

```
$ cd ~
$ cd bootcamp-clc7
$ vagrant ssh
```

- Executar o comando de inicialização de destruição da infraestrutura:

```	
[vagrant@bootcamp-workspace ~]$ cd /vagrant
[vagrant@bootcamp-workspace ~]$ terraform apply
```

- Aguardar o término da execução.
