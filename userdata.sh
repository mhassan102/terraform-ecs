#!/bin/bash

echo ECS_CLUSTER='${ecs_cluster_name}' > /etc/ecs/ecs.config
service docker stop
service docker start
docker start ecs-agent
