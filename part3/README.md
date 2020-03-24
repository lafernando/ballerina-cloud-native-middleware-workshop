docker run -p 9090:9090 -v /home/laf/dev/ballerina-cloud-native-middleware-workshop/part3/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus

docker run -p 3000:3000 grafana/grafana

docker run -p 5775:5775/udp -p6831:6831/udp -p6832:6832/udp -p5778:5778 -p16686:16686 -p14268:14268 jaegertracing/all-in-one:latest

https://grafana.com/dashboards/5841

http://localhost:3000/

http://localhost:16686/

ballerina run ../part2/geo_service.bal --b7a.observability.enabled=true
