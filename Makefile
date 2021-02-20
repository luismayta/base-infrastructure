#
# See ./docs/contributing.md
#

OS := $(shell uname)

.PHONY: help
.DEFAULT_GOAL := help

TEAM := luismayta
REPOSITORY_DOMAIN:=github.com
REPOSITORY_OWNER:=${TEAM}
AWS_VAULT ?= ${TEAM}
KEYBASE_OWNER ?= ${TEAM}
KEYBASE_PATH_TEAM_NAME ?=private
PROJECT := infrastructure
PROJECT_PORT := 3000

AWS_PROFILE_NAME ?=

TERRAFORM_VERSION=0.14.5

# Configuration.
SHELL ?=/bin/bash
ROOT_DIR=$(shell pwd)
MESSAGE:=🍺️
MESSAGE_HAPPY?:="Done! ${MESSAGE}, Now Happy Hacking"
SOURCE_DIR=$(ROOT_DIR)
PROVISION_DIR:=$(ROOT_DIR)/provision

terragrunt:=terragrunt

include provision/make/*.mk

help:
	@echo '${MESSAGE} Makefile for ${PROJECT}'
	@echo ''
	@echo 'Usage:'
	@echo '    setup                     install requirements'
	@echo ''
	@make terragrunt.help


setup:
	@echo "=====> install packages..."
	@cp -rf provision/git/hooks/prepare-commit-msg .git/hooks/
	make yarn.setup
	@echo ${MESSAGE_HAPPY}
