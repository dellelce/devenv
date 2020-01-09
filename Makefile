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

build_jdk11:
	@cd jdk11; make build

run_jdk11:
	@cd jdk11; make run

exec_jdk11:
	@cd jdk11; make exec

clean_jdk11:
	@cd jdk11; make clean

clean: clean_jdk11 clean_generic

build_all: build_jdk11 build_generic
