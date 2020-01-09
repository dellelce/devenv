# My Personal Environments

help:
	@echo default is help: work in progress

build_generic:
	@cd generic; make build --no-print-directory

run_generic:
	@cd generic; make run --no-print-directory

exec_generic:
	@cd generic; make exec --no-print-directory

clean_generic:
	@cd generic; make clean --no-print-directory

build_jdk11:
	@cd jdk11; make build --no-print-directory

run_jdk11:
	@cd jdk11; make run --no-print-directory

exec_jdk11:
	@cd jdk11; make exec --no-print-directory

clean_jdk11:
	@cd jdk11; make clean --no-print-directory

clean: clean_jdk11 clean_generic
