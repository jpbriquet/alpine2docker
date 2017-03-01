HOST_NAME=alpine-edge
BASE_USER=alpine

DOCKER_VERSION=1.13.1
DOCKER_COMPOSE_VERSION=1.11.1
DOCKER_MACHINE_VERSION=0.9.0

vagrant_ssh() {
    vagrant ssh -c "${*}" -- -n -T
}
