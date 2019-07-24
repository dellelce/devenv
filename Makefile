# My Environment

PORT  = 8034
PUB   = $(PORT):$(PORT)
NAME  = devenv

VOL   = ${PWD}/vol:/app/$(NAME)/vol

# Setup gopath - Initially the same path is used inside and outside the container
GOPATH  = /root/tmp/gopath
GO      = -e GOPATH="$(GOPATH)" -v $(GOPATH):$(GOPATH)

# mount current directory as /work
# Instead of reading directly PWD we use another variable to allow
# to use a directory different from where the makefile is.
WORK    = -v $$wd:/work

# always enable strace, you never know when you need it
EARGS   = --cap-add=SYS_PTRACE $(WORK) $(GO)

#default taget is help
help:
	@echo targets: build, run, exec, pull, all(=build+run)

build: Dockerfile
	@docker build -t $(NAME) .

# yeah --rm, I always forget that other otherwise they stay there
run:
	@docker run --name $(NAME) --rm $(EARGS) -e PORT=$(PORT) -v $(VOL) -p $(PUB) -it $(NAME)

exec:
	@docker exec -it $(NAME)

kill:
	@docker kill $(NAME)

pull:
	@for image in $$(awk '$$1 ~ /FROM/ {  print $$2 } ' Dockerfile ); do docker pull $$image; done

all: build run
