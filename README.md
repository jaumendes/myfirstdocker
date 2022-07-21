# myfirstdocker
yum install docker

### CREATE THE DOCKER IMAGE 
docker build -t myfirstdocker .

### RUN THE DOCKER IMAGE 
docker run myfirstdocker

# Delete images & containers

docker image rm $(docker images -a -q)

docker rm $(docker ps -a -q)

# Logs
docker logs [container name]
