HOST_NAME=alpine-edge
BASE_USER=alpine

DOCKER_VERSION=17.12.0
DOCKER_COMPOSE_VERSION=1.19.0
DOCKER_MACHINE_VERSION=0.13.0

vagrant_ssh() {
    vagrant ssh -c "${*}" -- -n -T
}
