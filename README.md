# dockerBuild

## Description

Pulls repo containing code + Dockerfile + requirements.txt and builds & starts a docker container.

Exposes specified port.

## Usage

Usage: ./deploy.sh projectName expose-port git-repo

Example: ./deploy.sh test123 5000 git@github.com:xxx/xxx.git

## Config

#### Dockerfile.example
This one is never used.

"Dockerfile.example" should go into project as "Dockerfile" modified accordingly.

## Requirements
A project containing:

* some code.
* Dockerfile
* requirements.txt
