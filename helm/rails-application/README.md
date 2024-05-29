Start:
	helm install rails-application . --values values.yaml
Stop:
	helm delete rails-application
