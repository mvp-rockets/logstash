FROM docker.elastic.co/logstash/logstash:8.5.3

RUN /usr/share/logstash/bin/logstash-plugin install logstash-filter-aggregate
RUN /usr/share/logstash/bin/logstash-plugin install logstash-filter-mutate
RUN /usr/share/logstash/bin/logstash-plugin install logstash-output-opensearch
RUN /usr/share/logstash/bin/logstash-plugin install logstash-integration-aws
RUN /usr/share/logstash/bin/logstash-plugin install logstash-filter-javascript



