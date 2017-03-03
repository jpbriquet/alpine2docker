#!/usr/bin/env bats

load test_helper

@test "Customize folder exist and default user can write inside" {
    run vagrant_ssh '[ -d /var/customize ] && touch /var/customize/test'
    [ "$status" -eq 0 ]
}
