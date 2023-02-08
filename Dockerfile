FROM docker.elastic.co/logstash/logstash:8.5.3

RUN /usr/share/logstash/bin/logstash-plugin install logstash-filter-aggregate
RUN /usr/share/logstash/bin/logstash-plugin install logstash-filter-mutate
RUN /usr/share/logstash/bin/logstash-plugin install logstash-output-opensearch
RUN /usr/share/logstash/bin/logstash-plugin install logstash-integration-aws
RUN /usr/share/logstash/bin/logstash-plugin install logstash-input-dead_letter_queue





COPY --chown=logstash:root  ./libs/mysql-connector-java8-5.1.23.jar /usr/share/logstash/logstash-core/lib/jars/mysql-connector-java8-5.1.23.jar
COPY --chown=logstash:root  ./libs/postgresql-42.2.5.jar /usr/share/logstash/logstash-core/lib/jars/postgresql-42.2.5.jar
# RUN mkdir -p /usr/share/logstash/data/dead_letter_queue \
  # && chown logstash:root /usr/share/logstash/data/dead_letter_queue

 