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

## Project documentation

You will find the project documendation at [https://RomainCtl.github.io/RecoFinement/](https://RomainCtl.github.io/RecoFinement/)


## Project submodules

* A User-Interface (Angular): [https://github.com/RomainCtl/RecoFinement-ui](https://github.com/RomainCtl/RecoFinement-ui)
* An API (Python and Flask): [https://github.com/RomainCtl/RecoFinement-api](https://github.com/RomainCtl/RecoFinement-api)
* All Datas (use of Git LFS): [https://github.com/RomainCtl/RecoFinement-Datasets](https://github.com/RomainCtl/RecoFinement-Datasets)
* Recommendation engine: *Coming soon*


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