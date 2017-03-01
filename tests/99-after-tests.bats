#!/usr/bin/env bats

@test "Machine can be restarted" {
    run vagrant reload
    [ "$status" -eq 0 ]
}

@test "Machine can be stopped" {
    run vagrant halt
    [ "$status" -eq 0 ]
}

@test "Machine can be destroyed" {
    run vagrant destroy -f
    [ "$status" -eq 0 ]
}
