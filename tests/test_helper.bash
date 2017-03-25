HOST_NAME=alpine-edge
BASE_USER=alpine

DOCKER_VERSION=17.03.0
DOCKER_COMPOSE_VERSION=1.11.2
DOCKER_MACHINE_VERSION=0.10.0

vagrant_ssh() {
    vagrant ssh -c "${*}" -- -n -T
}
