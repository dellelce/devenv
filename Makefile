# My Personal Environments

help:
	@echo default is help: work in progress

build_generic:
	@cd generic; make build

run_generic:
	@cd generic; make run

exec_generic:
	@cd generic; make exec

clean_generic:
	@cd generic; make clean

#jdk11
build_jdk11:
	@cd jdk11; make build

run_jdk11:
	@cd jdk11; make run

exec_jdk11:
	@cd jdk11; make exec

clean_jdk11:
	@cd jdk11; make clean

#jdk8
build_jdk8:
	@cd jdk8; make build

run_jdk8:
	@cd jdk8; make run

exec_jdk8:
	@cd jdk8; make exec

clean_jdk8:
	@cd jdk8; make clean

#typescript
build_typescript:
	@cd typescript; make build

run_typescript:
	@cd typescript; make run

exec_typescript:
	@cd typescript; make exec

clean_typescript:
	@cd typescript; make clean

clean: clean_jdk11 clean_generic clean_typescript

build_all: build_jdk11 build_generic build_generic build_typescript
