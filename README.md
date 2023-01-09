
## 1. Introduction
This is Logstash project

- Datasync from any Database to elasticSearch using Logstash
## 2. Pre-requirement

- Ubuntu 20.04.4 LTS
- docker(19.xx)
- docker-compose(1.28.xx)


### 3. How do I use it ? ###

#### Starting logstash 

Starting logstash input jdbc

```bash
docker-compose -f mysql-demo.yml up
```

Stoping 

```bash
docker-compose down 
```

#### Customize configuration

Customize configuration for logstash

- modify file `mysql_pipelines.conf` in docker container

```yml

```
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
    stdout { codec => json_lines }
}
```

Environtment example

- LOGSTASH_JDBC_DRIVER_JAR_LOCATION: 
    - for MySQL 5.7+ Database: `/usr/share/logstash/logstash-core/lib/jars/mysql-connector-java.jar`
    - for PostgreSQL 9.6+ Database: `/usr/share/logstash-core/lib/jars/logstash/postgresql.jar`
- LOGSTASH_JDBC_DRIVER: `com.mysql.jdbc.Driver`
- LOGSTASH_JDBC_URL: `jdbc:mysql://[host]:[port]/[database-name]`
- LOGSTASH_JDBC_USERNAME: `database_user`
- LOGSTASH_JDBC_PASSWORD: `database_user_password`



