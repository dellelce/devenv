# My Environment

PORT  = 5050
PUB   = $(PORT):$(PORT)
NAME  = devenv
EARGS = --cap-add=SYS_PTRACE

build: Dockerfile
	@docker build -t $(NAME) .

run:
	@docker run --name $(NAME) --rm $(EARGS) $(NAME) 

all: build run
