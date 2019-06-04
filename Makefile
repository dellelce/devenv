# My Environment

PORT  = 8034
PUB   = $(PORT):$(PORT)
NAME  = devenv

# why don't you like strace?
EARGS = --cap-add=SYS_PTRACE
VOL   = ${PWD}/vol:/app/$(NAME)/vol

build: Dockerfile
	@docker build -t $(NAME) .

# yeah --rm, I always forget that other otherwise they stay ther
run:
	@docker run --name $(NAME) --rm $(EARGS) -e PORT=$(PORT) -v $(VOL) -p $(PUB) -it $(NAME)  bash

exec:
	@docker exec -it $(NAME)  bash

kill:
	@docker kill $(NAME)

pull:
	@for image in $$(awk '$$1 ~ /FROM/ {  print $$2 } ' Dockerfile ); do docker pull $$image; done

all: build run
