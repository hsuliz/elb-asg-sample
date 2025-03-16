clean:
	@rm -rf out/

install:
	@cd src && \
	go install .

build: clean
	@cd src && \
 	go build -ldflags="-X 'main.Version=1.2.3'" -o ../out/myserver

build-image: build
	@docker build --platform linux/amd64 -t hsuliz/elb-asg-sample:latest .

push-image: build-image
	@docker push --platform linux/amd64 hsuliz/elb-asg-sample:latest
