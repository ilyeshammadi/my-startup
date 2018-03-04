IMAGE ?= docker.io/ilyeshammadi/my-startup
TAG ?= latest

build:
	docker build -t ${IMAGE}:${TAG} .
	docker tag ${IMAGE}:${TAG} ${IMAGE}:latest
.PHONY: build

run:
	docker run -p 9000:3000 ${IMAGE}:${TAG}
.PHONY: run

push:
	docker push ${IMAGE}:${TAG}
	docker push ${IMAGE}:latest
.PHONY: push

k8s_deploy:
	helm template --name my-startup deployment/helm/my-startup --set image.tag=${TAG} | kubectl apply -f -
.PHONY: k8s_deploy

k8s_stop:
	helm template --name my-startup deployment/helm/my-startup --set image.tag=${TAG} | kubectl delete -f -
.PHONY: k8s_stop

k8s_restart: k8s_stop k8s_deploy
.PHONY: k8s_restart