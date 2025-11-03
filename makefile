name = inception

all:
 @docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
 @docker-compose -f ./srcs/docker-compose.yml down

down-v:
 @docker-compose -f ./srcs/docker-compose.yml down -v

clean:
 @docker stop $(docker ps -qa)
 @2ocker rm $(docker ps -qa)
 @docker rmi -f $(docker images -qa)
 @docker volume rm $(docker volume ls -q)
 @docker network rm $(docker network ls -q) 2>/dev/null

.PHONY : all down down-v