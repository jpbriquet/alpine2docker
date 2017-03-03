#!/usr/bin/env bats

load test_helper

@test "VirtualBox kernel modules should be loaded" {
    run vagrant_ssh 'sudo lsmod | grep vbox | wc -l'
    [ "$status" -eq 0 ]
    [ "$output" -eq 5 ]
}

@test "VirtualBox shared folder should be mounted" {
    run vagrant_ssh 'mount | grep vagrant'
    [ "$status" -eq 0 ]
    [ "$output" = "vagrant on /vagrant type vboxsf (rw,nodev,relatime)" ]
}
