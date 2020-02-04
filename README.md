docker-xcsoar-buildenv
======================

A Docker based build environment for [XCSoar](https://github.com/XCSoar/XCSoar).


Description
-----------

If you are using macOS or Windows and want to do some quick changes to
[XCSoar](https://github.com/XCSoar/XCSoar) without investing into the the build
toolchain on your machine this Docker based dev setup for
[XCSoar](https://github.com/XCSoar/XCSoar) might be for you.

The Linux based development toolchain for
[XCSoar](https://github.com/XCSoar/XCSoar) is well supported and generally
working well. By using a Docker based setup in macOS or Windows we can benefit
from this situation.


Usage
-----

Note: the Docker image is currently only tested on macOS because I have no need
for a Windows environment at the moment. If somebody tests this on Windows and
finds issues please drop an issue or PR.

### Requirements

- [Docker for Mac](https://docs.docker.com/docker-for-mac/) (macOS) or 
[Docker for Windows](https://docs.docker.com/docker-for-windows/) (Windows)
- An X11 server on your host system
  - macOS: [XQuartz](https://www.xquartz.org/)
- socat - Multipurpose relay (SOcket CAT)

#### Installation instructions on macOS using Homebrew

1. Install [Docker for Mac](https://docs.docker.com/docker-for-mac/)
1. Install the remaining dependencies using Homebrew
    ```shell script
    brew install socat
    brew cask install xquartz
    ```

Please ensure to restart your Mac after you have installed XQuartz, it is needed
for its environment to work correctly.

### Usage on macOS

1. To forward X11 network traffic out of Docker to the X servers UNIX socket run
`socat` on the host machine in a separate terminal (it will block):
    ```shell script
    socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
    ```
 
1. Now you can work inside the directory of the XCSoar source, e.g. 
compiling it:
    ```shell script
    docker run -it --rm -w /src -v $PWD:/src:delegated sandrinr/docker-xcsoar-buildenv make OPENGL=n ENABLE_SDL=y
    ```
   The `-w /src -v $PWD:/src:delegated` is important for the image to work and
   have access to your XCSoar source.

1. Once you have a compiled project you can run XCSoar. If you have an X11
server installed and the `socat` command from above running, then XCSoar should
show up on your host machine.
    ```shell script
    docker run -it --rm -w /src -v $PWD:/src:delegated sandrinr/docker-xcsoar-buildenv output/UNIX/bin/xcsoar
    ```


Possible Future Work
--------------------

Should this image show traction we could extend it in many ways. Possible ideas:

- Improve the compilation speed by using some trickery with rsync and cache
Docker volumes or some other network storage system, such as NFS.

- Add support to crossbuild XCSoar to all the different supported platforms.

- Add support for similar projects, such as LK8000.


Notes and Caveats
-----------------

- XCSoar would normally use hardware rendering in the standard Linux platform.
However, this is not supported through networked X11 connections. Therefore we
need to use software rendering using the `OPENGL=n ENABLE_SDL=y` flags to 
`make`. This results in a more sluggish user experience than what would be
expected using hardware rendering.

- Compiling XCSoar using the approach above takes considerably more time (about
2x). There would be ways to speed it up. At the moment the approach is simple.
If this method gains traction then I might invest in some performance
improvements.

- It should be clear that the experience using this method to build and use
XCSoar is inferior to using it on the host platform directly. This method is
intended to do some quick tests or changes to XCSoar. If you are planning to do
some major work then it might be worth investing into a working toolchain on
your host system.


Contributing
------------

Contributions are always welcome in the form of issues or PRs.
