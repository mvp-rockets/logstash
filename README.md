
## 1. Introduction
This is Logstash project

- Datasync from any Database to elasticSearch using Logstash
## 2. Pre-requirement

- Ubuntu 20.04.4 LTS
- docker(19.xx)
- docker-compose(1.28.xx)
- Java Database connectivity(JDBC) http://www.java2s.com/Code/Jar/m/Downloadmysqlconnectorjava85123jar.htm


### 3. How do I use it ? ###

#### Starting logstash 

Starting logstash

```bash
docker-compose -f mysql-demo.yml up
```

Stoping 

```bash
docker-compose -f mysql-demo.yml down 
```

#### Customize configuration

Customize configuration for logstash

- modify file `mysql_pipelines.conf` in docker container

```yml
input {
    jdbc {
        jdbc_connection_string => "${LOGSTASH_JDBC_URL}"
        jdbc_user => "${LOGSTASH_JDBC_USERNAME}"
        jdbc_password => "${LOGSTASH_JDBC_PASSWORD}"
        jdbc_driver_library => "/usr/share/logstash/logstash-core/lib/jars/mysql-connector-java8-5.1.23.jar"
        jdbc_driver_class => "com.mysql.jdbc.Driver"
        schedule => "* * * * *"
        use_column_value => true
        tracking_column => "unix_ts_in_secs"
        tracking_column_type => "numeric"
        statement => "SELECT *, UNIX_TIMESTAMP(updated_at) AS unix_ts_in_secs FROM users WHERE (UNIX_TIMESTAMP(updated_at) > :sql_last_value AND updated_at < NOW()) ORDER BY id ASC"
    }
}
output {
    stdout {
    codec => rubydebug {
      metadata => true # This makes the logs to appear in console
      }
    }
}
```

Environtment example

- LOGSTASH_JDBC_DRIVER_JAR_LOCATION: 
    - for MySQL 5.7+ Database: `/usr/share/logstash/logstash-core/lib/jars/mysql-connector-java.jar`
- LOGSTASH_JDBC_DRIVER: `com.mysql.jdbc.Driver`
- LOGSTASH_JDBC_URL: `jdbc:mysql://[host]:[port]/[database-name]`
- LOGSTASH_JDBC_USERNAME: `database_user`
- LOGSTASH_JDBC_PASSWORD: `database_user_password`


Filter plugin example
- Refer the following link https://www.javacodegeeks.com/2017/10/aggregate-index-data-elasticsearch-using-logstash-jdbc.html


Customize configuration for logstash AWS-SQS

```yml
input pluigin same as above
only output plugin key,values will be different for aws-sqs
output{
    stdout {
    codec => rubydebug {
      metadata => true # This makes the logs to appear in console
    }
}
    sqs {
        queue => "${LOGSTASH_SQS_NAME}"
        region => "${LOGSTASH_AWS_REGION}"
        access_key_id => "${LOGSTASH_AWS_ACCESS_KEY}"
        secret_access_key => "${LOGSTASH_AWS_SECRET_ACCESS_KEY}"
    }
}
the values will be supplied from the mysql-sqs-demo.yml file
```
