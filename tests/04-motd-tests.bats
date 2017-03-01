#!/usr/bin/env bats

load test_helper

@test "MOTD has been changed" {
    run vagrant_ssh 'cat /etc/motd | grep "You can setup the system with the command: setup-alpine"'
    [ "$status" -eq 1 ]
}
