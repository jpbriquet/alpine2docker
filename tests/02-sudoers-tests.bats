#!/usr/bin/env bats

load test_helper

@test "Password less sudoers is set" {
    run vagrant_ssh 'sudo whoami'
    [ "$status" -eq 0 ]
    [ "$output" = "root" ]
}
