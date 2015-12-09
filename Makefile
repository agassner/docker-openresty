DOCKER_IMAGE=agassner/docker-openresty

rm:
	docker rm -f $$(docker ps -a | grep ${DOCKER_IMAGE} | awk '{print $$1}')

build:
	docker build -t ${DOCKER_IMAGE} .

run: build
	docker run -d -p 8080:80 ${DOCKER_IMAGE}