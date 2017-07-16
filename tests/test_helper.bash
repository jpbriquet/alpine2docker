HOST_NAME=alpine-edge
BASE_USER=alpine

DOCKER_VERSION=17.05.0
DOCKER_COMPOSE_VERSION=1.14.0
DOCKER_MACHINE_VERSION=0.12.2

vagrant_ssh() {
    vagrant ssh -c "${*}" -- -n -T
}
