#!/usr/bin/env bats

load test_helper

@test "SSH can connect on the machine" {
    run vagrant_ssh 'echo OK'
    [ "$status" -eq 0 ]
    [ "$output" = "OK" ]
}

@test "SSH does not allow root login" {
    run vagrant_ssh 'grep PermitRootLogin /etc/ssh/sshd_config \
    | grep yes | wc -l'
    [ "$status" -eq 0 ]
    [ "$output" -eq 0 ]
}

@test "SSH does not use DNS resolution (faster vagrant ssh)" {
    run vagrant_ssh 'grep "UseDNS no" /etc/ssh/sshd_config | wc -l'
    [ "$status" -eq 0 ]
    [ "$output" -eq 1 ]
}
