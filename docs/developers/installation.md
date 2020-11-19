!!! important
    We have planned several installation methods for this project, it is nevertheless recommended to use a __linux environment__.

!!! important
    It is recommended to have at least __20 GB of free space__ on your machine (The database takes up a little more than 11 GB).

## Production environment

In a production environment, all you need is a docker.

We advise you to use this environment in the following cases:

* To deploy the application on a server
* To test the application locally (in your computer)
* To contribute to the project
* To test services independently of the full application

## Development environment

In a development environment, there will be several dependencies to install.

We advise you to use this environment in the following cases:

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
    !!! warning
        This guide may not work on your environment, if this is the case, please refer to the official sites of the outbuildings.

        This guide is only intended to help you with the installation, but not with the configuration of the dependencies.

    In order to be able to make changes to the application or  to access the database via an interface, you must have the necessary tools to run the application.

    1. `make`
    2. `git` & `git lfs` (Large File Storage)
    3. `python`>=3.8, `pip` and `pipenv`
    4. `npm`
    5. `postgresql`>=10
    6. `java`>=11

    === "Linux (Debian)"
        `make` is normally installed by default.

        Install `git` and `git-lfs`:
        ```bash
        apt install git git-lfs
        git lfs install
        ```

        Python 3.8, pip & pipenv
        ```
        apt install python3.8 python3-pip
        python3 -m pip install pipenv
        ```

        !!! tip
            If you have more than one version of Python installed on your machine, the `python3` command may execute a different version,

            See : [https://jcutrer.com/linux/upgrade-python37-ubuntu1810](https://jcutrer.com/linux/upgrade-python37-ubuntu1810) (taking into account the desired version).

        Npm
        ```
        apt install nodejs
        ```

        PostgreSQL
        ```
        apt install postgresql postgresql-client
        ```

        Java
        ```
        apt install openjdk-11-jre
        ```

    === "Windows"
        !!! important
            __We advise you to install:__

            1. [Choco](https://chocolatey.org/docs/installation), software management for windows
            2. [Cmder](https://cmder.net/), it is a command line tool, it allows to replace advantageously cmd provided by default by Windows.

        Make
        ```
        choco install -y make
        ```

        Download `git` from [here](https://git-scm.com/download/win) and follow the instruction.

        Download `git lfs` from [here](https://github.com/git-lfs/git-lfs/releases/download/v2.12.1/git-lfs-windows-v2.12.1.exe) and:
        ```
        git lfs install
        ```

        Python3.8 [https://www.python.org/downloads/windows/](https://www.python.org/downloads/windows/), do not forget to tick the box "add to path".

        Npm, included with NodeJS [https://nodejs.org/en/download/](https://nodejs.org/en/download/)

        PostgreSQL [https://www.postgresql.org/download/](https://www.postgresql.org/download/)

        Java [https://www.oracle.com/java/technologies/javase-jdk11-downloads.html](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)

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

        Python 3.8
        [https://www.python.org/downloads/mac-osx/](https://www.python.org/downloads/mac-osx/)

        Npm, included with NodeJS [https://nodejs.org/en/download/](https://nodejs.org/en/download/)

        PostgreSQL [https://www.postgresql.org/download/](https://www.postgresql.org/download/)

        Java [https://www.oracle.com/java/technologies/javase-jdk11-downloads.html](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)k install adoptopenjdk11

## Clone project

We use a micro-services architecture (*[more information in this section](../architecture)*). We have a "master project" which has all services as sub-modules.

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

## Environment variables

In order to run correctly, the project needs to recover its configuration.

!!! tip
    If you need to generate some random string, you can use this command:
    ```bash
    python3 -c "import random; print(''.join(random.choice('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!%*+-:;@_') for _ in range(30)))"
    ```

### API

To do so, just copy the .env.default file:
```
cd services/api
cp .env.default .env
```
Then replace the values, and in particular the variables for the connection to the database.

=== "With docker"
    Generate some random string for `DB_USER_LOGIN`, `DB_USER_PASSWORD`, `ENGINE_APIKEY` and `SECRET_KEY`

=== "Without docker"
    You need to create `recofinement` database, when you created this one, you must have entered a user who owns this database. `DB_USER_LOGIN` and `DB_USER_PASSWORD` variables are its identifiers.

    Generate some random string for `SECRET_KEY` and `ENGINE_APIKEY`.

!!! warning
    This api uses some external services.

    1. Mailjet (more information [here](../external_services/mailjet))

        This services is used to send mail to users.
        You need to have a mailjet account and to recuperate the __public api key__ and the __private api key__.

    2. Spotify (more information [here](../external_services/spotify))

        Recofinement application allow the user to link his/her account to his/her spotify account (*for musics data*).
        To do this, you need to have a spotify developers account and to recuperate the __client id__ and __client secret__.

    3. TMDB (more information [here](../external_services/tmdb))

        Recofinement application allow the user to link his/her account to his/her tmdb account (*for movies and series data*).
        To do this, you need to have a tmdb developers account and to recuperate the __client token__.

    4. Google Books (more information [here](../external_services/gbooks))

        Recofinement application allow the user to link his/her account to his/her google account (*for books data*).

    You will find more information on their respective pages.

    Anyway, you can use __Recofinement__ without these features, users will simply not be able to receive email nor to link their account to the services mentioned.

### Engine

First, just copy the .env.default file:
```
cd services/reco_engine
cp .env.default .env
```
Then replace the values.

You only need to set `DB_USER_LOGIN`, `DB_USER_PASSWORD`, `FLASK_SECRET` and `API_TOKEN` variables.

`FLASK_SECRET` must be a random string (can also use the command above).

`DB_USER_LOGIN` and `DB_USER_PASSWORD` are the same as those used for the __api__.

`API_TOKEN` corresponds to the variable `ENGINE_APIKEY` in the __api__.

## Import datas

!!! info
    The database schema is created with the api (with an ORM)

!!! danger
    Depending on the performance of the machine you are using, this operation may take some time (__several hours__).

=== "With docker"
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
    1. Make sure that the database service is running (*with a `recofinement` database created*).
    2. Let's create the database schema:
    ```bash
    cd services/api
    make init
    make db-update
    cd  ../..
    ```
    3. Edit the importation script:
    ```bash
    cd datas
    # Replace "<pwd>" by the current absolute path (important!)
    sed -i "s#FROM '#FROM '<pwd>#g" script.sql
    ```
    4. Execute this script on your database

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
    __UI Servive:__

    1. Install dependencies
    ```
    make init
    ```
    2. Serve locally the development build (with hot-reloads)
    ```bash
    make serve
    # or
    ng serve
    ```

    __API Service:__

    1. Install dependencies
    ```
    make init
    ```
    2. Update database to the last migration (or initialize it if it does not exist)
    ```
    make db-update
    ```
    3. Serve locally the development build
    ```
    make serve
    ```

    __Engine Servive:__

    1. Install dependencies
    ```
    make init
    ```
    2. Serve locally the development build
    ```bash
    make serve
    ```


!!! tip
    If you want to know more about the available orders and how you can contribute to the project, we invite you to look at the 'README.md' files of each repositories.

    You can access it by clicking on the github button at the top right of this site.
