include make_env

TAG ?= latest

IMAGE_NAME = boris/pwgen-web

.PHONY: build login push

build:
	docker build -t $(IMAGE_NAME):$(TAG) -f Dockerfile .
	docker tag $(IMAGE_NAME):$(TAG) $(IMAGE_NAME):latest

push:
	docker push $(IMAGE_NAME):$(TAG)
	docker push $(IMAGE_NAME):latest

deploy:
	ssh moby ~/deploy/pwgen-web.sh

