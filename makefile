build:
	@cd src && go build -o ../out/myserver

install:
	@cd src && \
	go install .

clean:
	rm -rf out/