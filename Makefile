
DOCKER_IMAGE_NAME=area51/rpi-java
DOCKER_IMAGE_TAG=8

build:
	docker build -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .
	docker tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) $(DOCKER_IMAGE_NAME):latest

push:
	docker push $(DOCKER_IMAGE_NAME)

clean:
	docker rmi $(DOCKER_IMAGE_NAME):latest $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

