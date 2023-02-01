# Sane defaults
SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
# Default params
# environment ?= "dev"

# ---------------------- COMMANDS ---------------------------

.PHONY: dev kind monitor kong setup
dev: kind # Kick-off local dev environment & start coding! 💻
ifeq (,$(wildcard /tmp/kong/dev))
	@echo "Creating kind k8s cluster."
	@kind create cluster --image kindest/node:v1.24.7 --name kong
	@touch /tmp/kong/dev
endif

cluster: # Install kind
ifeq (,$(wildcard /tmp/kong-cluster))
	@echo "installing kind"
	@curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
	@chmod +x ./kind
	@sudo mv ./kind /usr/local/bin/kind
	@echo "Creating kind k8s cluster."
	@kind create cluster --image kindest/node:v1.24.7 --name kong
	@touch /tmp/kong-cluster
endif

monitor: # Installing Prometheus and Grafana
ifeq (,$(wildcard /tmp/kong-monitor))
	@helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	@helm repo add grafana https://grafana.github.io/helm-charts
	@helm install prometheus prometheus-community/prometheus --namespace monitoring --create-namespace --values prometheus.yaml --version 14.6.0
	# @helm upgrade --install grafana grafana/grafana --namespace monitoring --values grafana.yaml --version 6.16.2 --set grafana.rbac.pspEnabled=false
	@helm install grafana grafana/grafana --namespace monitoring --values grafana.yaml --version 6.16.2
	@touch /tmp/kong-monitor
endif

kong: # Installing and Configuring Kong Gateway
ifeq (,$(wildcard /tmp/kong-kong))
	@helm repo add kong https://charts.konghq.com
	@helm install mykong kong/kong --namespace kong --create-namespace  --values kong.yaml --set ingressController.installCRDs=false --version 2.3.0
	@kubectl apply -f prometheus-kong-plugin.yaml
	@touch /tmp/kong-kong
endif

deployhttp: # Deploy http service
ifeq (,$(wildcard /tmp/kong-deployhttp))
	@kubectl apply -f services.yaml
	@kubectl apply -f ingress.yaml
	@touch /tmp/kong-deployhttp
endif

runservices: # Run prometheus, grafana, kong services using port-forward
	@bash run_services.sh

stopservices: # Stop all those services by killing kubectl
	@ps aux | grep -i port-forward
	@killall kubectl
	@ps aux | grep -i port-forward

sendtraffic: # Send HTTP traffic
	@bash send_traffic.sh

setup: cluster monitor kong deployhttp # Setup kind, prometheus, grafana, kong and http service
ifeq (,$(wildcard /tmp/kong-setup))
	@touch /tmp/kong-setup
endif

destroy: cluster monitor kong deployhttp # Setup kind, prometheus, grafana, kong and http service
	@rm /tmp/kong-*
	@kind delete cluster -n kong

# SVN_INFO := $(shell git status 2> /dev/null; echo $$?)
# test1:
# var := $(shell kind create cluster --image kindest/node:v1.24.7 --name kong)
# ifneq ($(.SHELLSTATUS),0)
#   $(error shell command failed! output was $(var))
# endif
# SVN_INFO := $(shell ls -lh > /dev/null; echo $$?)
# ifeq ($(SVN_INFO),0)
# 	@echo $$SVN_INFO
#   $(error "Not an SVN repo...")
# endif


purge: check-confirm # Clean up all local dev artifacts (node_modules, etc.)
	@echo "Purging.."
	@sleep 1
	@echo "Done."

pr: # Create a GitHub Pull Request via https://cli.github.com/
	@gh pr create

script: # Run .sh script and pass parameters
	@./script.sh $(args)

push: arg-target check-dotenv
	@echo "Deploying to $(target).."
	@sleep 1
	@echo "Done. Successfully deployed to $(target)!"

db.init: # Initialize DB for development
	@echo "DB initialized."

db.migrate: env-MYSQL_HOST # Run DB migrations
	@echo "DB migrated."

deploy: arg-target check-dotenv # E.g. make deploy target=production
	@echo "Deploying to $(target).."
	@sleep 1
	@echo "Done. Successfully deployed to $(target)!"

logs:
	tail -f *.log

# ----------------- COMMON CHECKS  --------------------------

env-MYSQL_HOST: # [CHECK] Checks for env variable
	@if test -z ${MYSQL_HOST}; then echo -e "${ERR}Missing ENV VAR: MYSQL_HOST. Use 'ENV_VAR=value make <cmd>'${NC}"; exit 1; fi

arg-target: # [CHECK] Checks if param is present: make key=value
	@if [ "$(target)" = "" ]; then echo -e "${ERR}Missing param: target. Use 'make <cmd> arg=value'${NC}"; exit 1; fi

check-confirm: # Simple y/N confirmation
	@echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ] || (echo "Aborted!" && exit 1)

check-dotenv: # [CHECK] Checks if .env file is present
	@if [ ! -f ".env" ]; then echo -e "${ERR}Missing .env file. Run 'cp .env.example .env'${NC}"; exit 1; fi

check-node-modules: # [CHECK] Checks if /node_modules are present
	@if [ ! -d "node_modules" ]; then echo -e "${ERR}Missing /node_modules. Run npm / yarn install.${NC}"; exit 1; fi

check-env-vars: # [CHECK] Checks if env vars are present
	@if test -z ${AWS_ACCESS_KEY_ID}; then echo -e "${ERR}Missing env var: AWS_ACCESS_KEY_ID${NC}"; exit 1; fi
	@if test -z ${AWS_SECRET_ACCESS_KEY}; then echo -e "${ERR}Missing env var: AWS_SECRET_ACCESS_KEY${NC}"; exit 1; fi

# -----------------------------------------------------------
# CAUTION: If you have a file with the same name as make
# command, you need to add it to .PHONY below, otherwise it
# won't work. E.g. `make run` wouldn't work if you have
# `run` file in pwd.
.PHONY: help

# -----------------------------------------------------------
# -----       (Makefile helpers and decoration)      --------
# -----------------------------------------------------------

.DEFAULT_GOAL := help
# check https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
NC = \033[0m
ERR = \033[31;1m
TAB := '%-20s' # Increase if you have long commands

# tput colors
red := $(shell tput setaf 1)
green := $(shell tput setaf 2)
yellow := $(shell tput setaf 3)
blue := $(shell tput setaf 4)
cyan := $(shell tput setaf 6)
cyan80 := $(shell tput setaf 86)
grey500 := $(shell tput setaf 244)
grey300 := $(shell tput setaf 240)
bold := $(shell tput bold)
underline := $(shell tput smul)
reset := $(shell tput sgr0)

help:
	@printf '\n'
	@printf '    $(underline)$(grey500)Available make commands:$(reset)\n\n'
	@# Print non-check commands with comments
	@grep -E '^([a-zA-Z0-9_-]+\.?)+:.+#.+$$' $(MAKEFILE_LIST) \
		| grep -v '^check-' \
		| grep -v '^env-' \
		| grep -v '^arg-' \
		| sed 's/:.*#/: #/g' \
		| awk 'BEGIN {FS = "[: ]+#[ ]+"}; \
		{printf " $(grey300)   make $(reset)$(cyan80)$(bold)$(TAB) $(reset)$(grey300)# %s$(reset)\n", \
			$$1, $$2}'
	@grep -E '^([a-zA-Z0-9_-]+\.?)+:( +\w+-\w+)*$$' $(MAKEFILE_LIST) \
		| grep -v help \
		| awk 'BEGIN {FS = ":"}; \
		{printf " $(grey300)   make $(reset)$(cyan80)$(bold)$(TAB)$(reset)\n", \
			$$1}'
	@echo -e "\n    $(underline)$(grey500)Helper/Checks$(reset)\n"
	@grep -E '^([a-zA-Z0-9_-]+\.?)+:.+#.+$$' $(MAKEFILE_LIST) \
		| grep -E '^(check|arg|env)-' \
		| awk 'BEGIN {FS = "[: ]+#[ ]+"}; \
		{printf " $(grey300)   make $(reset)$(grey500)$(TAB) $(reset)$(grey300)# %s$(reset)\n", \
			$$1, $$2}'
	@echo -e ""
