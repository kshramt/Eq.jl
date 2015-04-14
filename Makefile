# Configurations
.SUFFIXES:
.DELETE_ON_ERROR:
.ONESHELL:
.SECONDARY:
export SHELL := /bin/bash
export SHELLOPTS := pipefail:errexit:nounset:noclobber

JULIA := julia

# Tasks
.PHONY: all check
all: ;
check: test/runtests.jl.tested

%.tested: %
	$(JULIA) $<
	touch $@

# Files

# Rules
