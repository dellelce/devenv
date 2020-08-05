# My Personal "Generic" Environment

PORT  = 8035
PUB   = $(PORT):$(PORT)
NAME  = devenv
WDIR  = $${wd:-$(PWD)}

VOL   = -v ${DEVENV}/vol:/app/$(NAME)/vol -v $(HOME)/.ssh:/root/.ssh

# Setup gopath - Initially the same path is used inside and outside the container
GOPATH  = $$HOME/tmp/gopath
GO      = -e GOPATH="$(GOPATH)" -v $(GOPATH):$(GOPATH)

# mount current directory as /work
WORK    = -v $(WDIR):/work

# always enable strace, you never know when you need it
EARGS   = --cap-add=SYS_PTRACE $(WORK) $(GO)

#default target is help
help:
	@echo "targets: build, run, exec, pull, all(=build+run)"

build: Dockerfile
	@docker build --no-cache -t $(NAME) .

run:
	@docker run --name $(NAME) --rm $(EARGS) -e PORT=$(PORT) $(VOL) -p $(PUB) -it $(NAME)

exec:
	@docker exec -it $(NAME) /bin/bash

kill:
	@docker kill $(NAME)

pull:
	@for image in $$(awk '$$1 ~ /FROM/ {  print $$2 } ' Dockerfile ); do docker pull $$image; done

clean:
	@docker rmi $(NAME)

all: build run
