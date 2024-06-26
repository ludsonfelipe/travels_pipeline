# Docker
start:
	docker compose --env-file ./.env up --build

# Connect
send_debezium_connector:
	curl -i -X POST -H "Accept: application/json" -H "Content-Type: application/json" localhost:8083/connectors/ -d @./connectors/pg_debezium.json
send_s3_connector:
	curl -i -X POST -H "Accept: application/json" -H "Content-Type: application/json" localhost:8083/connectors/ -d @./connectors/s3_kafka.json
delete_connector:
	curl -X DELETE localhost:8083/connectors/$(conn)
create_connectors: send_debezium_connector send_s3_connector

# Postgres
connect_postgres:
	docker exec -it relational_db psql -h relational_db -U postgres -d travels_db

# Kafka
list_topics:
	docker exec -it kafka bash bin/kafka-topics.sh --list --bootstrap-server kafka:9092
read_topic:
	docker exec -it kafka bash bin/kafka-console-consumer.sh --topic $(topic) --from-beginning --bootstrap-server kafka:9092

# Minio
minio_console:
	docker exec -it minio bash
minio_raw_layer:
	docker exec -it minio bash -c "mc rm --force --dangerous data/raw; mc mb data/raw"
minio_lakehouse_layer:
	docker exec -it minio bash -c "mc rm --force --dangerous data/lakehouse; mc mb data/lakehouse"
minio_layers: minio_raw_layer minio_lakehouse_layer

# Spark
spark_console:
	docker exec -it spark bash