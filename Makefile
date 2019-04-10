# My Environment

PORT  = 8034
PUB   = $(PORT):$(PORT)
NAME  = devenv

# why don't you like strace?
EARGS = --cap-add=SYS_PTRACE
VOL   = ./vol:/app/$(NAME)/vol

build: Dockerfile
	@docker build -t $(NAME) .

# yeah --rm, I always forget that other otherwise they stay ther
run:
	@docker run --name $(NAME) --rm $(EARGS) -e PORT=$(PORT) -it $(NAME)  bash

all: build run
