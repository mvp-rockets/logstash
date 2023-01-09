
## 1. Introduction
This is Logstash project

- Datasync from any Database to elasticSearch using Logstash
## 2. Pre-requirement

- Ubuntu 20.04.4 LTS
- docker(19.xx)
- docker-compose(1.28.xx)


### 3. How do I get set up? ###

- Clone the project by clicking this link [git@bitbucket.org:venkatsai1234/logstash.git][id]

### 4. How to start the project? ###
 
- Datasync from mysql to elasticSearch(change the mysql-demo.yml to postgres.yml or yourDatabase.yml to sync your data to elasticSearch)
- docker-compose -f mysql-demo.yml up

### 5. Where do I see my data?  

- localhost:5601 kibana port


### 6. Authors/maintainers/contributors 

- Venkat Sai (venkatasai.k@napses.com)
- Yashjeet Luthra (yash@napses.com)
