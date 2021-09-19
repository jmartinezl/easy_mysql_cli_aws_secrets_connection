# Easy mysql cli connection using aws secrets manager

An easy bash script to connect to mysql using a aws secrets manager; it work for any red hat distro but it can be easily be adapted to any distro

In order to get this script working please verify the next:

##prerequisites:

* The EC2 instance has a role with the SecretsManagerReadWrite managed policy (you can attach your custom policy it only need to have the getSecretValue permission)
* Install mysql cli
  - `yum install mysql`
* Install JQ
  - `yum install jq`


## instructions:

* place your directory where the script is
* get the name of the secret 
* give the script permission to be executed
  - `chmod +x mysql-secret.sh`
* run the script
  - `./mysql-secret.sh name-of-the-secret`
* it will connect you to your rds instance mysql/aurora cluster


## TODO

* Adapt the script for any linux flavour 
* Create a cloudformation with the packages, policy, script, and everything is needed just to run and connect to the instance
