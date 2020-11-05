# ========================================================
# makefile
# ========================================================
default: help	# default target


# ========================================================
# Variables
# ========================================================

PYTHON = ""

# https://stackoverflow.com/questions/714100/os-detecting-makefile/12099167#12099167
ifeq ($(OS),Windows_NT)
	PYTHON := python
else
	PYTHON := python3
endif

ENVIRONMENT = local
DOCKER_IP := 172.17.0.1 #192.168.56.10

# --------------------------------------------------------
# Define project docker image

# ----
API_SERVICE_NAME := api
API_SERVICE_SHELL := sh
# ----
ENGINE_SERVICE_NAME := engine
ENGINE_SERVICE_SHELL := sh
# ----
POSTGRESQL_SERVICE_NAME := db
POSTGRESQL_SERVICE_SHELL := sh
# ----
FRONT_SERVICE_NAME := ui
FRONT_SERVICE_SHELL := sh
# ----
REVERSE_PROXY_SERVICE_NAME := nginx
REVERSE_PROXY_SERVICE_SHELL := sh
# ----

# --------------------------------------------------------
# Commands

PIPENV = ${PYTHON} -m pipenv
PYTHON_ENV = ${PIPENV} run ${PYTHON}

# -----------------------------------------------------------------------------
# include env

-include .env
-include ./services/api/.env
export

# ========================================================
# Targets
# ========================================================

# --------------------------------------------------------
# Utilities tasks (not documented in help)
# --------------------------------------------------------

pipenv: # installs pipenv if necessary
	${PYTHON} -m pip install pipenv

# --------------------------------------------------------
##@ Project tasks
# --------------------------------------------------------

init: ## Imports git submodule (to do only if outside a master project)
	git submodule sync && git submodule update --init --remote

update: ## Update all gitmodules to last commit
	git  submodule update --remote

install: pipenv ## Run 'pipenv install'
	${PIPENV} install

doc-serve: ## Serve locally documentation
	$(PYTHON_ENV) -m mkdocs serve

doc-build: ## Build mkdocs
	$(PYTHON_ENV) -m mkdocs build --clean


build: ## Build docker image from source
	docker-compose build

start: build ## Start the container
	docker-compose up -d

logs: ## Display logs from the running container
	docker-compose logs -f

stop: ## Stop the container
	docker-compose stop

rm: stop ## Destroy the container
	docker-compose down

import-data: ## Import './datas' into docker DB service (execute once !)
	docker exec $(POSTGRESQL_SERVICE_NAME) rm -rf /tmp/datas/*
	docker cp $(realpath ./datas/) $(POSTGRESQL_SERVICE_NAME):/tmp/
	docker exec $(POSTGRESQL_SERVICE_NAME) sed -i "s#FROM '#FROM '/tmp/datas/#g" tmp/datas/script.sql
	docker exec -i $(POSTGRESQL_SERVICE_NAME) psql -h 127.0.0.1 -p $(DB_PORT) -d $(DB_NAME) -U $(DB_USER_LOGIN) -f /tmp/datas/script.sql

# --------------------------------------------------------
##@ Internal services starting tasks
# --------------------------------------------------------

api: api-rm ## (Re)start 'api' service only (also available: 'api-[build|logs|sh|stop|rm])
	docker-compose up -d $(API_SERVICE_NAME)
api-build:; docker-compose build $(API_SERVICE_NAME)
api-logs:; docker-compose logs -f $(API_SERVICE_NAME)
api-sh:; docker-compose exec $(API_SERVICE_NAME) $(API_SERVICE_SHELL)
api-stop:; docker-compose stop $(API_SERVICE_NAME)
api-rm: api-stop; docker-compose rm -f $(API_SERVICE_NAME)


engine: engine-rm ## (Re)start 'engine' service only (also available: 'engine-[build|logs|sh|stop|rm])
	docker-compose up -d $(ENGINE_SERVICE_NAME)
engine-build:; docker-compose build $(ENGINE_SERVICE_NAME)
engine-logs:; docker-compose logs -f $(ENGINE_SERVICE_NAME)
engine-sh:; docker-compose exec $(ENGINE_SERVICE_NAME) $(ENGINE_SERVICE_SHELL)
engine-stop:; docker-compose stop $(ENGINE_SERVICE_NAME)
engine-rm: engine-stop; docker-compose rm -f $(ENGINE_SERVICE_NAME)


db: db-rm ## (Re)start 'db' service only (also available: 'db-[build|logs|sh|stop|rm])
	docker-compose up -d $(POSTGRESQL_SERVICE_NAME)
db-build:; docker-compose build $(POSTGRESQL_SERVICE_NAME)
db-logs:; docker-compose logs -f $(POSTGRESQL_SERVICE_NAME)
db-sh:; docker-compose exec $(POSTGRESQL_SERVICE_NAME) $(POSTGRESQL_SERVICE_SHELL)
db-stop:; docker-compose stop $(POSTGRESQL_SERVICE_NAME)
db-rm: db-stop; docker-compose rm -f $(POSTGRESQL_SERVICE_NAME)


front: front-rm ## (Re)start 'front' service only (also available: 'front-[build|logs|sh|stop|rm])
	docker-compose up -d $(FRONT_SERVICE_NAME)
front-build:; docker-compose build $(FRONT_SERVICE_NAME)
front-logs:; docker-compose logs -f $(FRONT_SERVICE_NAME)
front-sh:; docker-compose exec $(FRONT_SERVICE_NAME) $(FRONT_SERVICE_SHELL)
front-stop:; docker-compose stop $(FRONT_SERVICE_NAME)
front-rm: front-stop; docker-compose rm -f $(FRONT_SERVICE_NAME)


nginx: nginx-rm ## (Re)start 'nginx' service only (also available: 'nginx-[build|logs|sh|stop|rm])
	docker-compose up -d $(REVERSE_PROXY_SERVICE_NAME)
nginx-build:; docker-compose build $(REVERSE_PROXY_SERVICE_NAME)
nginx-logs:; docker-compose logs -f $(REVERSE_PROXY_SERVICE_NAME)
nginx-sh:; docker-compose exec $(REVERSE_PROXY_SERVICE_NAME) $(REVERSE_PROXY_SERVICE_SHELL)
nginx-stop:; docker-compose stop $(REVERSE_PROXY_SERVICE_NAME)
nginx-rm: nginx-stop; docker-compose rm -f $(REVERSE_PROXY_SERVICE_NAME)


# --------------------------------------------------------
##@ Commons Git tasks
# --------------------------------------------------------

# ---------------------


GIT_BRANCH_MAIN := master # Main branch of the project

GIT_LIST_BRANCH_WITHOUT_REMOTE = git branch -vv |  grep -v "*" | grep ": gone]" | cut -c 3- | awk '{print $$1}'
GIT_DEL_BRANCH_WITHOUT_REMOTE = [ -z "$$(${GIT_LIST_BRANCH_WITHOUT_REMOTE})" ] \
									&& echo "No branch to delete." \
									|| $(GIT_LIST_BRANCH_WITHOUT_REMOTE) | xargs git branch -D
GIT_LIST_CURRENT_BRANCHES = git submodule status | awk '{print $$2 ss}'
GIT_LIST_SUBMODULES = git submodule | awk '{print $2}'

GIT_NEW_BRANCH_NAME := bash -c 'read -p "New branch name: " name; echo $${name//[ |-]/_}'

SPACE = ${null} ${null}

# ---------------------
# Define all required var to create new branch
# arguments:
#	- $1 = Branch title given by command line ("Add new feature for doing something")
#	- $2 = Branch type name (ex: feature, hotfix, doc)
define git-new-setvars
	$(eval NEW_BRANCH_TYPE = $2)
	$(eval NEW_BRANCH_TITLE_PREFIX = $(NEW_BRANCH_TYPE))
	$(eval NEW_BRANCH_TITLE = [$(NEW_BRANCH_TITLE_PREFIX)] $(strip $(1)))
	$(eval NEW_BRANCH_NAME = $(NEW_BRANCH_TYPE)/$(strip $(1)))

	@# format branch name correctly
	$(eval NEW_BRANCH_NAME = $(subst ${SPACE},_,$(NEW_BRANCH_NAME)))
	$(eval NEW_BRANCH_NAME = $(subst -,_,$(NEW_BRANCH_NAME)))
	$(eval NEW_BRANCH_NAME = $(subst ',_,$(NEW_BRANCH_NAME)))
	$(eval NEW_BRANCH_NAME = $(shell echo $(NEW_BRANCH_NAME) | tr '[:upper:]' '[:lower:]'))
endef

# ---------------------
git-prune: ## Delete all unused branch (remote ref and local)
	$(eval MODULES = $(shell git submodule | awk '{print $$2}' ) )
	$(eval CURRENT_PATH = $(shell pwd))
	@for mod in $(MODULES) ./; do 				\
		echo "-------------------------"; 		\
		echo "Enter in git repo '$$mod' .."; 	\
		cd $(CURRENT_PATH)/$$mod; 				\
		git fetch --all; 						\
		git remote prune origin; 				\
		$(GIT_DEL_BRANCH_WITHOUT_REMOTE); 		\
	done

# ---------------------
git-branch: ## create new branch [feat|fix|doc|devops] (ex: make git-new feat="add new feature")
	$(if $(feat), $(call git-new-setvars,$(feat),feature))
	$(if $(fix), $(call git-new-setvars,$(fix),bugfix))
	$(if $(doc), $(call git-new-setvars,$(doc),doc))
	$(if $(devops), $(call git-new-setvars,$(devops),devops))

	$(if $(NEW_BRANCH_NAME), , $(error Require at least one argument: [feat|fix|doc|devops]. Ex: #> make git-new feat="Add a new feature"))
	$(info Building new branch $(NEW_BRANCH_NAME) ...)
	git checkout $(GIT_BRANCH_MAIN)
	git pull --rebase
	git checkout -b $(NEW_BRANCH_NAME)
	git pull-request --fork never -k -m " " -C " " --title "$(NEW_BRANCH_TITLE)" --branch-prefix "" -R

# ---------------------
git-master: ## Back to main branch and reset to main branch
	git checkout $(GIT_BRANCH_MAIN)
	git reset --hard origin/$(GIT_BRANCH_MAIN)
	git pull --rebase

# ---------------------
git-config: ## Configure git for working with submodule and define some usefull alias
	git config --global alias.adog "log --all --decorate --oneline --graph"
	git config --global alias.lg1 "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
	git config --global alias.lg2 "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
	git config --global alias.lg !"git lg2"
	git config --global alias.last !"git lg -15"
	git config --global url."https://github.com/".insteadOf git@github.com:
	git config --global url."https://".insteadOf git://
	git config --global color.diff "auto"
	git config --global color.status "auto"
	git config --global color.branch "auto"
	git config --global diff.submodule "log"
	git config --global pull.rebase true


# --------------------------------------------------------
##@ Commons basics tasks
# --------------------------------------------------------

# source: https://stackoverflow.com/questions/2214575/passing-arguments-to-make-run
bash: ## Open a new bash session
	bash

# source: https://suva.sh/posts/well-documented-makefiles/
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<task>\033[0m\n"} /^[0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
