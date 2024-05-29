# aws cli must be install for create-repo
REPO_NAME := 637423538949.dkr.ecr.eu-central-1.amazonaws.com
VERSION := latest
REGION := eu-central-1

COMPONENTS := rails-app content-api worker postgres

build-images:
	for component in $(COMPONENTS); do \
		( cd $${component}; docker build -t $(REPO_NAME)/$${component} . ); \
	done

tag-images:
	for component in $(COMPONENTS); do \
		docker tag $(REPO_NAME)/$${component} $(REPO_NAME)/$${component}:$(VERSION); \
	done

create-repo:
	for component in $(COMPONENTS); do \
		aws ecr create-repository --repository-name $${component} --region $(REGION); \
	done

push-images:
	for component in $(COMPONENTS); do \
		docker push $(REPO_NAME)/$${component}; \
	done

build-tag-and-push:
	make build-images
#	make tag-images
#	create-repo
	make push-images
