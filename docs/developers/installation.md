!!! important
    We have planned several installation methods for this project, it is nevertheless recommended to use a linux environment.

## Production environment

In a production environment, all you need is a docker.

We advise you to use this [guide](./withdocker) in the following cases:

* To deploy the application on a server
* To test the application locally (in your computer)
* To contribute to the project
* To test services independently of the full application

## Development environment

In a development environment, there will be several dependencies to install.

We advise you to use this [guide](./withoutdocker) in the following cases:

* To contribute to the project with hot reloading
* If you want to access the database via an interface
* If you are on Windows and you don't want to use our solution: [https://github.com/RomainCtl/vagrant_docker](https://github.com/RomainCtl/vagrant_docker) *(more information in the guide)*

## Requirements

=== "Production environment"
    In order to be able to deploy, test or make changes to the application, you must have the necessary tools to run the application.

    1. `make`
    2. `git` & `git lfs` (Large File Storage)
    3. `docker` & `docker-compose`

    and that's all!

    === "Linux (Debian)"
        `make` is normally installed by default.

        Install `git` and `git-lfs`:
        ```bash
        apt install git git-lfs
        git lfs install
        ```

        You can install `docker` simply with:
        ```bash
        apt install docker.io docker-compose
        ```

    === "Windows"
        Download `git` from [here](https://git-scm.com/download/win) and follow the instruction.

        Download `git lfs` from [here](https://github.com/git-lfs/git-lfs/releases/download/v2.12.1/git-lfs-windows-v2.12.1.exe) and:
        ```
        git lfs install
        ```

        If you work on windows, I advise you to follow the instructions in this repository: [https://github.com/RomainCtl/vagrant_docker](https://github.com/RomainCtl/vagrant_docker)

        So, each time you will use docker, you may start the vm (`make vm-up`).

        !!! note
            An Oracle VM Virtualbox will start and you will see it, you do not need to log on to it.
            The author of this repository chose to leave the VM window open so as not to forget to switch it off before turning off the computer.

        !!! tip
            To use docker, do not forget to define the environment variables as the following: `./setenv-docker.bat`.

    === "Mac"
        For `make`, you will have to install the "Developer Tools" that are provided as optional packages in OS X installation disks.

        `git` is normaly installed by default, try:
        ```
        git --version
        ```
        on  your terminal, if it is not already installed, it will ask you to do so.

        Install `git-lfs`:
        ```
        brew install git-lfs
        git lfs install
        ```

        Docker Compose is installed as part of [Docker for Mac](https://docs.docker.com/docker-for-mac/install/). So you only have to install Docker for MAC.

=== "Development environment"
    In order to be able to make changes to the application or  to access the database via an interface, you must have the necessary tools to run the application.

    1. `make`
    2. `git` & `git lfs` (Large File Storage)
    3. *coming soon*

## Clone project

We use a micro-services architecture (*[more information in this section](../../architecture)*). We have a "master project" which has all services as sub-modules.

Clone the "master project" and follow these command:
```bash
git clone https://github.com/RomainCtl/RecoFinement.git
```
Imports git submodule (services)
```
make init
```
Import our datas (may take some time depending on your internet connection)
```
cd ./datas
git lfs pull
cd ..
```

## Import datas

=== "With docker"
    !!! info
        The database schema is created with the api (with an ORM)

    1. Build docker image for the database and the api
    ```
    make db-build api-build
    ```
    2. Start databse and api container
    ```
    make db api
    ```

    3. Import datas
    ```
    make import-data
    ```

    ??? tip "If you want to see logs"
        ```
        make logs
        ```

=== "Without docker"
    *coming soon*

## Usage

=== "With docker"
    *Usually Docker uses the default __172.17.0.1/16__ subnet for container networking.*

    ???+ warning "If you use __Windows__"
        You may write the following line into `.env` file (This is the ip used to access the docker hub).
        ```
        DOCKER_IP=192.168.56.10
        ```

    1. Build docker image from source (all services)
    ```
    make build
    ```
    2. Start the container (all services)
    ```
    make start
    ```
    3. Display logs from the running container (all services)
    ```
    make logs
    ```
    4. Stop the container (all services)
    ```
    make stop
    ```
    5. Destroy the container (all services)
    ```
    make rm
    ```

    You can also do each action for one service using:
    ```bash
    ## (Re)start 'api' service only (also available: 'api-[build|logs|sh|stop|rm])
    make api

    ## (Re)start 'engine' service only (also available: 'engine-[build|logs|sh|stop|rm])
    make engine

    ## (Re)start 'cron' service only (also available: 'cron-[build|logs|sh|stop|rm])
    make cron

    ## (Re)start 'db' service only (also available: 'db-[build|logs|sh|stop|rm])
    make db

    ## (Re)start 'front' service only (also available: 'front-[build|logs|sh|stop|rm])
    make front

    ## (Re)start 'nginx' service only (also available: 'nginx-[build|logs|sh|stop|rm])
    make nginx
    ```

=== "Without docker"
    *coming soon*
