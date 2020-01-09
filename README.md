# My Development Environment

Base images to be used as starting point for other images or good for standalone use.

All activities are wrapped in a makefile, example:

``` bash
$ make <target>
```
where possible "targets" are described below.

## generic image (python, javascript, go)

with my custom uWSGI & Python 3 (see [mkit](https://github.com/dellelce/mkit))
builds on top of Alpine

Targets for the "generic" image:


| Target         | Description                       |
|----------------|-----------------------------------|
| run_generic    | Run the image (shell prompt)      |
| build_generic  | Builds the image                  |
| kill_jdk11     | Kills the currently running image |

## jdk11 image

Targets for the "jdk11" image:

| Target          | Description                       |
|-----------------|-----------------------------------|
| run_jdk11       | Run the image (shell prompt)      |
| build_jdk11     | Builds the image                  |
| kill_jdk11      | Kills the currently running image |
