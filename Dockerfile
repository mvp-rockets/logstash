FROM docker.elastic.co/logstash/logstash:8.5.3

RUN /usr/share/logstash/bin/logstash-plugin install logstash-filter-aggregate
RUN /usr/share/logstash/bin/logstash-plugin install logstash-filter-mutate
RUN /usr/share/logstash/bin/logstash-plugin install logstash-output-opensearch
RUN /usr/share/logstash/bin/logstash-plugin install logstash-integration-aws



COPY --chown=logstash:root  ./libs/mysql-connector-java8-5.1.23.jar /usr/share/logstash/logstash-core/lib/jars/mysql-connector-java8-5.1.23.jar
COPY --chown=logstash:root  ./libs/postgresql-42.2.5.jar /usr/share/logstash/logstash-core/lib/jars/postgresql-42.2.5.jar
