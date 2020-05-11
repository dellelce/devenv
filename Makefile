# My Personal "Interactive" Environments

ALL :=

help:
	@for mk in mk/*.mk; do awk -f mk/help.awk $$mk; done

include mk/*.mk

all: $(ALL)
