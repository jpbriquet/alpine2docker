# Alpine2docker Vagrant Box


<img src="https://hyzxph.media.zestyio.com/blog-vagrant-list.svg" alt="Logo" width="70px;"/>
+<img src="https://alpinelinux.org/alpinelinux-logo.svg" alt="Logo" width="200px;"/>
+<img src="https://upload.wikimedia.org/wikipedia/commons/7/79/Docker_%28container_engine%29_logo.png" alt="Logo" width="200px;"/>

This repository contains the scripts necessary to create a Vagrant box for Docker development on [Alpine Linux OS](https://alpinelinux.org/).

This box is a good choice, if you work solely with Docker tools and if you would like to use a Vagrant workflow.

Please note that Alpine2Docker is currently designed for development only.
Using it for any kind of production workloads is highly discouraged.

This box will be updated as soon as possible when a new Docker engine is released.


## Usage

The box is available on [Hashicorp's Atlas](https://atlas.hashicorp.com/jpbriquet/boxes/alpine2docker)

To use it, just open a console and type :
```
$ vagrant init jpbriquet/alpine2docker
$ vagrant up
```


## What's in the box ?

### VM
* 2 vCPUs
* 4 GB memory
* 1 GB swap enabled
* Default to NAT network
* Audio and USB off

### Guest OS
* Alpine Linux 3.5/Edge (edge repositories enabled)
* Kernel 4.9.26-0-hardened x86_64 Linux
* LVM root filesystem for any filesystem growing allocation
* Administrative user *alpine* (password is the same)
* OpenSSH server
* Bash, curl, sudo
* VirtualBox additions

### Docker Tools
* **Docker Engine 17.04.0**
* **Docker Compose 1.13.0** to define and run multi-container Docker applications
* **Docker Machine 0.11.0** to provision hosts on cloud providers
* **Docker Bash Completion** to quickly type docker commands
* **Vim with Docker syntax** to edit Dockerfile with style


## Synced folder
Several options are possible to share files between the host and the vagrant box.
* Shared Folder (default). The Vagrantfile root directory content is mounted under /vagrant.
  It relies on native VirtualBox additions (vboxsf) which are cross-platform, convenient and reliable.
* nfs and smbfs, rsync are other alternative that have not been yet tested with this box. Ask for this feature with a github issue if you need it.

## Building the Box

Box has been created with Packer tool and can be builded as follow.

### Requirements

* [Make for build orchestration](http://www.gnu.org/software/make/)
* [Packer as vagrant base box builder](http://www.packer.io) (at least version 0.12.2)
* [Vagrant](http://vagrantup.com) (at least version 1.9.1)
* [VirtualBox](http://www.virtualbox.org) (at least version 5.1.14)
* [bats for testing](https://github.com/sstephenson/bats)

### Building the box

The following make command launch the box build process and tests.

```
make all
```

It is also possible to call make targets independently:

* `make box`: Only run the packer build
* `make clean-box`: Remove any packer final or intermediate artifacts
* `make prepare-test`: Copy the latest built box to the test environment
* `make test`: Run the test suite using vagrant
* `make clean-test`: Clean any test artifacts or VM
* `make clean`: Clean everything

### Extension point

If you want to tune the behavior to fit your needs,
but want to reuse all the build process, here is the workflow
for VM customization:

* Add this repository as a
[git submodule](https://git-scm.com/docs/git-submodule)
of your repository
* Put in the `customize` folder the content you want to be uploaded to the VM
  - You can overwrite existing content: it is for demo purpose
  - The content will be uploaded inside /var/customize
  - If there is a script `run.sh`, it will be run during box build time
* Build the VM with the previous instructions


## User Feedback

### Issues

If you have any problems with or questions about this box, please contact us through a [GitHub issue](https://github.com/jpbriquet/alpine2docker/issues).

### Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/jpbriquet/alpine2docker/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.


## Thanks

Many thanks to [DDuportal](https://github.com/dduportal) for its work on boot2docker and alpine2docker Vagrant Boxes.
