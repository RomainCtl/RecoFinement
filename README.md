# RecoFinement

## Product principle

RecoFinement is a project that should allow everyone to benefit from personalized recommendations of different multimedia contents. Many services use the principle of recommendations, whether it is the technological core of some (Netflix) or an incentive mechanism for consumption (Amazon). The advertising revenues generated by recommendation systems are substantial, which can leave a certain bias (by choosing a biased quality metric). Far from such considerations, we choose quality recommendations based solely on their relevance and user feedback.

We would like to be able to offer recommendations on various contents, in particular :
* music
* videos (films, series)
* books
* games
* applications


## Requirements

In order to be able to make changes to the application, you must have the necessary tools to run the application. The following command lines will install all the tools you need:
```bash
# Python 3.8 & pip
apt install python3.8 python3-pip

# To auto-create pull request from command line
python3 -m pip install pipenv git-pull-request
```

> *If you have more than one version of Python installed on your machine, the `python3` command may execute a different version.,* \
*See : [https://jcutrer.com/linux/upgrade-python37-ubuntu1810](https://jcutrer.com/linux/upgrade-python37-ubuntu1810) (taking into account the desired version)*

You also need to install a PostgreSQL database (config in `.env` file, see: [RecoFinement-api](https://github.com/RomainCtl/RecoFinement-api))

In order to be able to run project with docker, you must have:
```bash
# Docker & docker-compose
apt install docker.io docker-compose
```

### Windows User

> How to use docker comfortably on windows

If you work on windows, I advise you to follow the instructions in this repo: [https://github.com/RomainCtl/vagrant_docker](https://github.com/RomainCtl/vagrant_docker)

## Project documentation

You will find the project documendation at [https://RomainCtl.github.io/RecoFinement/](https://RomainCtl.github.io/RecoFinement/)


## Project submodules

* A User-Interface (Angular): [https://github.com/RomainCtl/RecoFinement-ui](https://github.com/RomainCtl/RecoFinement-ui)
* An API (Python and Flask): [https://github.com/RomainCtl/RecoFinement-api](https://github.com/RomainCtl/RecoFinement-api)
* All Datas (use of Git LFS): [https://github.com/RomainCtl/RecoFinement-Datasets](https://github.com/RomainCtl/RecoFinement-Datasets)
* Recommendation engine: [https://github.com/RomainCtl/RecoFinement-engine](https://github.com/RomainCtl/RecoFinement-engine)


## Usage

This project has a static website build with [mkdocs](https://www.mkdocs.org/) to provide project documentation.

To launch documentation locally:
```bash
# Download all python dependencies locally
make install

# Start the documentation locally
make doc-serve
```

You can access your application by going to the address http://127.0.0.1:8000/

You can also build static documentation (dest folder: `./site/`):
```bash
# Build static documentation
make doc-build
```

Display Makefile help (display all available targets):
```bash
make
# or
make help
```

## Services

To launch services (api and front app), please refear to their `README.md`.

### With docker

*Usually Docker uses the default __172.17.0.1/16__ subnet for container networking.*

> If you use our recommendation from [here](###-windows-user), you may write __"DOCKER_IP=192.168.56.10"__ into `.env` file.

```bash
# Build docker image from source (all services)
make build

# Start the container (all services)
make start

# Display logs from the running container (all services)
make logs

# Stop the container (all services)
make stop

# Destroy the container (all services)
make rm
```

You can also do each action for one service using:
```bash
# Internal services starting tasks

## (Re)start 'api' service only (also available: 'api-[build|logs|sh|stop|rm])
make api

## (Re)start 'postgresql' service only (also available: 'postgresql-[build|logs|sh|stop|rm])
make postgresql

## (Re)start 'front' service only (also available: 'front-[build|logs|sh|stop|rm])
make front

## (Re)start 'nginx' service only (also available: 'nginx-[build|logs|sh|stop|rm])
make nginx
```

## Contribution

Contributions are managed using github's Pull Request (PR). After cloning the `master` branch of the project, use the following commands to create a new branch with its associated `Pull Request`:

```bash
# Create a feature branch and its PR
make git-branch feat="Adds a nice feature"

# Create a bug fix branch and its PR
make git-branch fix="Fix a bug"

# Create a documentation|support branch and its PR
make git-branch doc="Adds a nice documentation or support"
```