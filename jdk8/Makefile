# My Personal "Java 8" Environment

PORT  = 8033
PUB   = $(PORT):$(PORT)
NAME  = jdk8env

VOL   = -v ${DEVENV}/vol:/app/$(NAME)/vol -v $(HOME)/.ssh:/root/.ssh

# mount current directory as /work
# Instead of reading directly PWD we use another variable to allow
# to use a directory different from where the makefile is.
WORK    = -v $$wd:/work

# always enable strace, you never know when you need it
EARGS   = --cap-add=SYS_PTRACE $(WORK)

#default taget is help
help:
	@echo "targets: build, run, exec, pull, all(=build+run)"

build: Dockerfile
	@docker build --no-cache -t $(NAME) .

# yeah --rm, I always forget that otherwise the instance persists..
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
