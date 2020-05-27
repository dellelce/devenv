# lua

ALL += build_lua

build_lua:
	@cd lua; make build

run_lua:
	@cd lua; make run

exec_lua:
	@cd lua; make exec

clean_lua:
	@cd lua; make clean

kill_lua:
	@cd lua; make kill

# $HELP$
# build_lua           build lua container
# run_lua             run container (interactive mode)
# exec_lua            attaching to running "lua container"
# kill_lua            kill "lua" container
# clean_lua           run target "clean"
