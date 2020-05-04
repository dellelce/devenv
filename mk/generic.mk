# generic
build_generic:
	@cd generic; make build

run_generic:
	@cd generic; make run

exec_generic:
	@cd generic; make exec

clean_generic:
	@cd generic; make clean

kill_generic:
	@cd generic; make kill

# $HELP$
# build_generic       build generic container
# run_generic         run container (interactive mode)
# exec_generic        attaching to running "generic container"
# kill_generic        kill "generic" container
# clean_generic       run target "clean"
