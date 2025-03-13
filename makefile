build:
	@cd src && go build -o ../out/myserver

install:
	@cd src && \
	go install .

clean:
	rm -rf out/

build-image:
	@docker build --platform linux/amd64 -t hsuliz/elb-asg-sample:latest .

push-image:
	@docker push --platform linux/amd64 hsuliz/elb-asg-sample:latest
