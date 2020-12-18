# Debezium-demo project

This project shows a little impression of what Debezium is capable of. The purpose of the demo is to show how willhaben jobs data can be extracted by using Debezium.

---

## Pre requisits

For using that demo it is necessary to have the following things pre setup:
1. you need to have docker-compose installed
2. if you want to see the kafka messages in a convenient way it is also preferred you have kafka installed on your machine
3. if you like to have a proper console output you should also install [jq](https://stedolan.github.io/jq/)
---

## How to start the demo

Just start the docker-compose file and all necessary containers will boot up :

```bash
docker-compose up
```

## Interact with Kafka Connect instance with the helperfiles

In the connect-helper folder you can find some useful shells to quickly interact with the kafka-connect instance.
* get-connectors: get a list of all connectors
* get-connector-details _connector-name_ : get the currently uploaded detail configuration of a connector 
* get-connector-status _connector-name_ : get the status of a connector
* upload-connector _file-to-upload_: uploads a file to the kafka-connect
* delete-connector _connector-name_: deletes a connection by using the connector name also listed with get_connectors

---

## Upload a Connector configuration

The default way to upload a connector configuration is to use [curl](https://curl.se/).

```shell
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @your-file.json
```

For a simple test you can use one of the configuration files that are in the example directory.

### Using the helper shell

If you want to use the project's shell commands you can upload a configuration by doing

```shell
connect-helper/upload-connector <your_file>
```

You can check the success of the upload using the browser and go to 

```
http://localhost:8083/connectors
```

and see if the connector is in the list.

---

## Consume Kafka messages

### Within the docker container
You need another terminal to start consuming kafka messages. With the following command you get into the Docker container:

```bash
docker exec -it docker_kafka_1 bash
```

In the interactive shell of the docker container, you should now start to consume kafka messages by using the following:

```bash
bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
    --topic _thetopic_
```

Only you have to select for yourself is the topic which consists of **databasename.schema.table**

### Using installed kafka
You can also use your locally installed kafka to see the messages running through the broker. A preferred way, also for readability is the following:

```shell
kafka-console-consumer.sh --bootstrap-server localhost:9092  --from-beginning --property print.key=true --topic <topic_name> | jq
```