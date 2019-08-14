### To create a docker image
1) Create a file with name `Dockerfile` : case sensitive
2) Run command `docker build . -t <TAG-NAME-FOR-IMAGE>`
	Example -  `docker build . -t test`
---
### To know list of docker images
```
docker image ls
```
---
### To run a Docker
```
docker run <IMAGE-NAME>
```
----
### To know list of containers running with ID
```
docker ps
```
---
### To stop a docker container running and image
```
docker stop <CONTAINER-NAME>
```
---
### To get IP Address of the docker container
```
docker inspect <containerNameOrId> | grep '"IPAddress"' | head -n 1
```
---
### To access docker port from local machine and outside machines
```
docker run -p <HOST-PORT>:<DOCKER-PORT> <IMAGE-NAME>
```
---
### Removing Docker Images

#### Remove one or more specific images

Use the `docker images` command with the `-a` flag to locate the ID of the images you want to remove. This will show you every image, including intermediate image layers. When you've located the images you want to delete, you can pass their ID or tag to `docker rmi`:

##### List:

```
docker images -a
```

##### Remove:

```
docker rmi Image Image

```
---
### Remove all images

All the Docker images on a system can be listed by adding `-a` to the `docker images` command. Once you're sure you want to delete them all, you can add the `-q` flag to pass the Image ID to `docker rmi`:

##### List:

```
docker images -a
```

##### Remove:

```
docker rmi $(docker images -a -q)
```
---
### Removing Containers

##### Remove one or more specific containers

Use the `docker ps` command with the `-a` flag to locate the name or ID of the containers you want to remove:

##### List:

```
docker ps -a
```

##### Remove:
```
docker rm ID_or_Name ID_or_Name
```
---
### Entering Linux based container docker image

`docker exec -it container_name bash`

---
### Know Java version
`docker exec container_name java -version`

---
## How to write Dockerfile

#### FROM

Usage:

-   `FROM <image>`
-   `FROM <image>:<tag>`
-   `FROM <image>@<digest>`

Information:

-   `FROM` must be the first non-comment instruction in the Dockerfile.
-   `FROM` can appear multiple times within a single Dockerfile in order to create multiple images. Simply make a note of the last image ID output by the commit before each new `FROM` command.
-   The `tag` or `digest` values are optional. If you omit either of them, the builder assumes a `latest` by default. The builder returns an error if it cannot match the `tag` value.

[Reference](https://docs.docker.com/engine/reference/builder/#from) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#from)

---------------

#### MAINTAINER

Usage:

-   `MAINTAINER <name>`

The `MAINTAINER` instruction allows you to set the Author field of the generated images.

[Reference](https://docs.docker.com/engine/reference/builder/#maintainer)

------------------------

#### RUN

Usage:

-   `RUN <command>` (shell form, the command is run in a shell, which by default is `/bin/sh -c` on Linux or `cmd /S /C` on Windows)
-   `RUN ["<executable>", "<param1>", "<param2>"]` (exec form)

Information:

-   The exec form makes it possible to avoid shell string munging, and to `RUN` commands using a base image that does not contain the specified shell executable.
-   The default shell for the shell form can be changed using the `SHELL` command.
-   Normal shell processing does not occur when using the exec form. For example, `RUN ["echo", "$HOME"]` will not do variable substitution on `$HOME`.

[Reference](https://docs.docker.com/engine/reference/builder/#run) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#run)

---------------------

#### CMD

Usage:

-   `CMD ["<executable>","<param1>","<param2>"]` (exec form, this is the preferred form)
-   `CMD ["<param1>","<param2>"]` (as default parameters to ENTRYPOINT)
-   `CMD <command> <param1> <param2>` (shell form)

Information:

-   The main purpose of a `CMD` is to provide defaults for an executing container. These defaults can include an executable, or they can omit the executable, in which case you must specify an `ENTRYPOINT` instruction as well.
-   There can only be one `CMD` instruction in a Dockerfile. If you list more than one `CMD` then only the last `CMD` will take effect.
-   If `CMD` is used to provide default arguments for the `ENTRYPOINT` instruction, both the `CMD` and `ENTRYPOINT` instructions should be specified with the JSON array format.
-   If the user specifies arguments to `docker run` then they will override the default specified in `CMD`.
-   Normal shell processing does not occur when using the exec form. For example, `CMD ["echo", "$HOME"]` will not do variable substitution on `$HOME`.

[Reference](https://docs.docker.com/engine/reference/builder/#cmd) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#cmd)

-----------------

#### LABEL

Usage:

-   `LABEL <key>=<value> [<key>=<value> ...]`

Information:

-   The `LABEL` instruction adds metadata to an image.
-   To include spaces within a `LABEL` value, use quotes and backslashes as you would in command-line parsing.
-   Labels are additive including `LABEL`s in `FROM` images.
-   If Docker encounters a label/key that already exists, the new value overrides any previous labels with identical keys.
-   To view an image’s labels, use the `docker inspect` command. They will be under the `"Labels"` JSON attribute.

[Reference](https://docs.docker.com/engine/reference/builder/#label) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#label)

--------------

####  EXPOSE

Usage:

-   `EXPOSE <port> [<port> ...]`

Information:

-   Informs Docker that the container listens on the specified network port(s) at runtime.
-   `EXPOSE` does not make the ports of the container accessible to the host.

[Reference](https://docs.docker.com/engine/reference/builder/#expose) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#expose)

------------

#### ENV

Usage:

-   `ENV <key> <value>`
-   `ENV <key>=<value> [<key>=<value> ...]`

Information:

-   The `ENV` instruction sets the environment variable `<key>` to the value `<value>`.
-   The value will be in the environment of all “descendant” Dockerfile commands and can be replaced inline as well.
-   The environment variables set using `ENV` will persist when a container is run from the resulting image.
-   The first form will set a single variable to a value with the entire string after the first space being treated as the `<value>` - including characters such as spaces and quotes.

[Reference](https://docs.docker.com/engine/reference/builder/#env) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#env)

----------------

#### ADD

Usage:

-   `ADD <src> [<src> ...] <dest>`
-   `ADD ["<src>", ... "<dest>"]` (this form is required for paths containing whitespace)

Information:

-   Copies new files, directories, or remote file URLs from `<src>` and adds them to the filesystem of the image at the path `<dest>`.
-   `<src>` may contain wildcards and matching will be done using Go’s filepath.Match rules.
-   If `<src>` is a file or directory, then they must be relative to the source directory that is being built (the context of the build).
-   `<dest>` is an absolute path, or a path relative to `WORKDIR`.
-   If `<dest>` doesn’t exist, it is created along with all missing directories in its path.

[Reference](https://docs.docker.com/engine/reference/builder/#add) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#add-or-copy)

----------------

#### COPY

Usage:

-   `COPY <src> [<src> ...] <dest>`
-   `COPY ["<src>", ... "<dest>"]` (this form is required for paths containing whitespace)

Information:

-   Copies new files or directories from `<src>` and adds them to the filesystem of the image at the path `<dest>`.
-   `<src>` may contain wildcards and matching will be done using Go’s filepath.Match rules.
-   `<src>` must be relative to the source directory that is being built (the context of the build).
-   `<dest>` is an absolute path, or a path relative to `WORKDIR`.
-   If `<dest>` doesn’t exist, it is created along with all missing directories in its path.

[Reference](https://docs.docker.com/engine/reference/builder/#copy) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#add-or-copy)

-------------

#### ENTRYPOINT

Usage:

-   `ENTRYPOINT ["<executable>", "<param1>", "<param2>"]` (exec form, preferred)
-   `ENTRYPOINT <command> <param1> <param2>` (shell form)

Information:

-   Allows you to configure a container that will run as an executable.
-   Command line arguments to `docker run <image>` will be appended after all elements in an exec form `ENTRYPOINT` and will override all elements specified using `CMD`.
-   The shell form prevents any `CMD` or run command line arguments from being used, but the `ENTRYPOINT` will start via the shell. This means the executable will not be PID 1 nor will it receive UNIX signals. Prepend `exec` to get around this drawback.
-   Only the last `ENTRYPOINT` instruction in the Dockerfile will have an effect.

[Reference](https://docs.docker.com/engine/reference/builder/#entrypoint) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#entrypoint)

------------

#### VOLUME

Usage:

-   `VOLUME ["<path>", ...]`
-   `VOLUME <path> [<path> ...]`

Creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers.

[Reference](https://docs.docker.com/engine/reference/builder/#volume) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#volume)

USER

Usage:

-   `USER <username | UID>`

The `USER` instruction sets the user name or UID to use when running the image and for any `RUN`, `CMD` and `ENTRYPOINT` instructions that follow it in the Dockerfile.

[Reference](https://docs.docker.com/engine/reference/builder/#user) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#user)

-----------------

####  WORKDIR

Usage:

-   `WORKDIR </path/to/workdir>`

Information:

-   Sets the working directory for any `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, and `ADD` instructions that follow it.
-   It can be used multiple times in the one Dockerfile. If a relative path is provided, it will be relative to the path of the previous `WORKDIR` instruction.

[Reference](https://docs.docker.com/engine/reference/builder/#workdir) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#workdir)

------------

####  ARG

Usage:

-   `ARG <name>[=<default value>]`

Information:

-   Defines a variable that users can pass at build-time to the builder with the `docker build` command using the `--build-arg <varname>=<value>` flag.
-   Multiple variables may be defined by specifying `ARG` multiple times.
-   It is not recommended to use build-time variables for passing secrets like github keys, user credentials, etc. Build-time variable values are visible to any user of the image with the docker history command.
-   Environment variables defined using the `ENV` instruction always override an `ARG` instruction of the same name.
-   Docker has a set of predefined `ARG` variables that you can use without a corresponding ARG instruction in the Dockerfile.
    -   `HTTP_PROXY` and `http_proxy`
    -   `HTTPS_PROXY` and `https_proxy`
    -   `FTP_PROXY` and `ftp_proxy`
    -   `NO_PROXY` and `no_proxy`

[Reference](https://docs.docker.com/engine/reference/builder/#arg)

-------------------

####  ONBUILD

Usage:

-   `ONBUILD <Dockerfile INSTRUCTION>`

Information:

-   Adds to the image a trigger instruction to be executed at a later time, when the image is used as the base for another build. The trigger will be executed in the context of the downstream build, as if it had been inserted immediately after the `FROM` instruction in the downstream Dockerfile.
-   Any build instruction can be registered as a trigger.
-   Triggers are inherited by the "child" build only. In other words, they are not inherited by "grand-children" builds.
-   The `ONBUILD` instruction may not trigger `FROM`, `MAINTAINER`, or `ONBUILD` instructions.

[Reference](https://docs.docker.com/engine/reference/builder/#onbuild) - [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#onbuild)

--------------

####  STOPSIGNAL

Usage:

-   `STOPSIGNAL <signal>`

The `STOPSIGNAL` instruction sets the system call signal that will be sent to the container to exit. This signal can be a valid unsigned number that matches a position in the kernel’s syscall table, for instance `9`, or a signal name in the format SIGNAME, for instance `SIGKILL`.

[Reference](https://docs.docker.com/engine/reference/builder/#stopsignal)

-----------

####  HEALTHCHECK

Usage:

-   `HEALTHCHECK [<options>] CMD <command>` (check container health by running a command inside the container)
-   `HEALTHCHECK NONE` (disable any healthcheck inherited from the base image)

Information:

-   Tells Docker how to test a container to check that it is still working
-   Whenever a health check passes, it becomes `healthy`. After a certain number of consecutive failures, it becomes `unhealthy`.
-   The `<options>` that can appear are...
    -   `--interval=<duration>` (default: 30s)
    -   `--timeout=<duration>` (default: 30s)
    -   `--retries=<number>` (default: 3)
-   The health check will first run `interval` seconds after the container is started, and then again `interval` seconds after each previous check completes. If a single run of the check takes longer than `timeout` seconds then the check is considered to have failed. It takes `retries` consecutive failures of the health check for the container to be considered `unhealthy`.
-   There can only be one `HEALTHCHECK` instruction in a Dockerfile. If you list more than one then only the last `HEALTHCHECK` will take effect.
-   `<command>` can be either a shell command or an exec JSON array.
-   The command's exit status indicates the health status of the container.
    -   `0`: success - the container is healthy and ready for use
    -   `1`: unhealthy - the container is not working correctly
    -   `2`: reserved - do not use this exit code
-   The first 4096 bytes of stdout and stderr from the `<command>` are stored and can be queried with `docker inspect`.
-   When the health status of a container changes, a `health_status` event is generated with the new status.

[Reference](https://docs.docker.com/engine/reference/builder/#healthcheck)

--------------------

####  SHELL

Usage:

-   `SHELL ["<executable>", "<param1>", "<param2>"]`

Information:

-   Allows the default shell used for the shell form of commands to be overridden.
-   Each `SHELL` instruction overrides all previous `SHELL` instructions, and affects all subsequent instructions.
-   Allows an alternate shell be used such as `zsh`, `csh`, `tcsh`, `powershell`, and others.

[Reference](https://docs.docker.com/engine/reference/builder/#shell)

## References

* [Tutorial Point](https://www.tutorialspoint.com/docker/docker_images) is used to learn docker
* [Stackedit](https://stackedit.io) is used for creating markdown documentation
