#!/usr/bin/env bats

load test_helper

@test "The default user ${BASE_USER} is in the docker group" {
    run vagrant_ssh 'groups'
    [ "$status" -eq 0 ]
    [ "$output" = "${BASE_USER} wheel docker" ]
}

@test "Docker Engine is started and respond correctly without sudo" {
    run vagrant_ssh 'docker info'
    [ "$status" -eq 0 ]
}

@test "Docker Client is in version ${DOCKER_VERSION}" {
    run vagrant_ssh 'docker -v'
    [ "$status" -eq 0 ]
    [ $(expr "$output" : "Docker version ${DOCKER_VERSION}") -ne 0 ]
}

@test "Docker Compose is in version ${DOCKER_COMPOSE_VERSION}" {
    run vagrant_ssh 'docker-compose -v'
    [ "$status" -eq 0 ]
    [ $(expr "$output" : "docker-compose version ${DOCKER_COMPOSE_VERSION}") -ne 0 ]
}

@test "Docker Machine is in version ${DOCKER_MACHINE_VERSION}" {
    run vagrant_ssh 'docker-machine -v'
    [ "$status" -eq 0 ]
    [ $(expr "$output" : "docker-machine version ${DOCKER_MACHINE_VERSION}") -ne 0 ]
}

@test "VIM editor is available" {
    run vagrant_ssh 'which vim'
    [ "$status" -eq 0 ]
    [ "$output" = "/usr/bin/vim" ]
}

@test "Docker VIM syntax is installed" {
    run vagrant_ssh "[ -f /usr/share/vim/vimfiles/syntax/dockerfile.vim ]"
    [ "$status" -eq 0 ]
}


# Try to run popular Docker images

@test "Docker can run hello-world" {
    run vagrant_ssh 'docker run -i --rm hello-world 2>&1 | grep "Hello from Docker!"'
    [ "$status" -eq 0 ]
}

@test "Docker can run nginx" {
    run vagrant_ssh "docker run -i --rm nginx nginx -v 2>&1 | grep 'nginx version'"
    [ "$status" -eq 0 ]
}

@test "Docker can run Redis" {
    run vagrant_ssh "docker run --name redis -d --rm redis && sleep 5 && docker logs redis | grep 'Running in standalone mode'"
    [ "$status" -eq 0 ]
}

@test "Docker can run Postgres" {
    run vagrant_ssh "docker run --name postgres -d --rm postgres && sleep 5 && docker logs postgres | grep 'PostgreSQL init process complete'"
    [ "$status" -eq 0 ]
}

@test "Docker can run JS apps" {
    run vagrant_ssh "docker run -i --rm node node -p 'let a=1; a===1' 2>&1 | grep 'true'"
    [ "$status" -eq 0 ]
}

@test "Docker can run JVM apps" {
    run vagrant_ssh "docker run --name jenkins -d --rm jenkins && sleep 20 && docker logs jenkins 2>&1 | grep 'INFO: Jenkins is fully up and running'"
    [ "$status" -eq 0 ]
}

@test "Docker can stop and remove containers" {
    run vagrant_ssh 'docker stop redis postgres jenkins'
    run vagrant_ssh 'docker ps -a | wc -l'
    [ "$status" -eq 0 ]
    [ "$output" -eq 1 ]
}
