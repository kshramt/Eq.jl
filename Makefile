# Configurations
.SUFFIXES:
.DELETE_ON_ERROR:
.ONESHELL:
.SECONDARY:
export SHELL := /bin/bash
export SHELLOPTS := pipefail:errexit:nounset:noclobber

JULIA := julia


sha256 = $(1:%=%.sha256)
unsha256 = $(1:%.sha256=%)


# Tasks
.PHONY: all check
all: ;
check: test/runtests.jl.tested


test/runtests.jl.tested: $(call sha256,src/Eq.jl)


%.tested: %.sha256
	$(JULIA) $<
	touch $@


%.tested: %.sha256
	$(JULIA) $(call unsha256,$<)
	touch $@


%.sha256: %.sha256.new
	cmp -s $< $@ || cat $< >| $@


%.sha256.new: %
	sha256sum $< >| $@
