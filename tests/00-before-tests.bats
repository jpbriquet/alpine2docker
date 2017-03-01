#!/usr/bin/env bats

@test "Machine can be started" {
    run vagrant up
    [ "$status" -eq 0 ]
}
