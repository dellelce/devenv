#jdk11

ALL += build_jdk11

build_jdk11:
	@cd jdk11; make build

run_jdk11:
	@cd jdk11; make run

exec_jdk11:
	@cd jdk11; make exec

clean_jdk11:
	@cd jdk11; make clean


# $HELP$
# build_jdk11         build jdk11 container
# run_jdk11           run container (interactive mode)
# exec_jdk11          attaching to running "jdk11 container"
# clean_jdk11         run target "clean"
