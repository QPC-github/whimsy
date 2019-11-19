Docker execution instructions
=============================

This is experimental at this point.

These steps will enable you to run a full Whimsy system inside a
container on your development machine.  You can edit files inside
your favorite IDE on your host machine.

Prerequisites
-------------

You will need Docker, git, and subversion.  And approximately 30Gb of
disk space (over 20Gb of which will be to have a copy of iclas, cclas,
and grants for the secretary workbench; perhaps in the future these
could be made optional).

Direct link to [docker for
macOS](https://download.docker.com/mac/stable/Docker.dmg) (this avoids the
need to login to Docker Hub).

A development class machine and a high speed internet connection would
be in order.  Some things appear to perform well, other things perform
noticeably slower than a native (non-container) installation of whimsy.

Installation instructions
-------------------------

* Create an empty directory.  Note: while you _can_ use an existing clone of
  Whimsy (and in particular, you _may_ be able to use the `/srv` directories
  defined by the [macOS](MACOSX.md) instructions), be aware of the following:
    * Files in the parent directory of the Whimsy clone may be created,
      overwritten, or deleted by this process.
    * Should the `svn` and `git` directories in this directory contain
      checkouts/clones made by the host operating system, it is imperative that
      the [file system
      format](https://www.visualsvn.com/support/topic/00135/#FilesystemFormat)
      of the repository manager format used by the host machine matches the
      format used by the container.  Currently macOS Catalina/Xcode provides
      svn 1.10.4 and the Dockerfile downloads the latest 1.10 version
      (currently 1.10.6).
* `cd` into that directory
* `git clone git@github.com:apache/whimsy.git` (or alternately
  `git clone https://github.com/apache/whimsy.git`)
* `cd whimsy`
* Start Docker if necessary
* `rake docker:update`
* `rake docker:up`
* visit `http://localhost:1999/` in your favorite browser

Note: the `rake docker:udpate` step will take a long time as it will need to
download and install all of the Ubuntu packages, Ruby gems, build and
install Passenger, checkout numerous svn repositories and two git
repositories.  The good news is that this can be entirely unattended as
there will be no prompts required during this process.

This should be enough to get the board agenda tool to launch.  It is not
known yet what functions work and what functions do not.

Known not to work (ToDos)
-------------------------

* Board agenda web socket (used to communicate updates from the server to
  browsers)
* Automatic restarting of passenger based tools when source code changes are
  made.

Uninstallation procedures
-------------------------

* Remove the entire directory created as step 1 of the installation
  instructions.
* `docker image prune -f`
* `docker container prune -f`
