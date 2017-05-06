HOST_NAME=alpine-edge
BASE_USER=alpine

DOCKER_VERSION=17.04.0
DOCKER_COMPOSE_VERSION=1.13.0
DOCKER_MACHINE_VERSION=0.11.0

vagrant_ssh() {
    vagrant ssh -c "${*}" -- -n -T
}
