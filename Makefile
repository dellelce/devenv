# My Personal "Interactive" Environments

ALL :=

# Generate help message from text embedded in makefiles in mk directory
help:
	@for mk in mk/*.mk; do awk -f mk/help.awk $$mk; done

include mk/*.mk

all: $(ALL)
