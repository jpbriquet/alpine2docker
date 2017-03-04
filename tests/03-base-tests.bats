#!/usr/bin/env bats

load test_helper

@test "Hostname is ${HOST_NAME}" {
    run vagrant_ssh 'hostname'
    [ "$status" -eq 0 ]
    [ "$output" = "${HOST_NAME}" ]
}

@test "Default user of the VM is ${BASE_USER}" {
    run vagrant_ssh 'whoami'
    [ "$status" -eq 0 ]
    [ "$output" = "${BASE_USER}" ]
}

@test "Default shell of default user ${BASE_USER} is bash" {
    run vagrant_ssh 'echo ${SHELL}'
    [ "$status" -eq 0 ]
    [ "$output" = "/bin/bash" ]
}

@test "Effective shell of default user ${BASE_USER} is bash" {
    run vagrant_ssh 'echo ${0}'
    [ "$status" -eq 0 ]
    [ "$output" = "bash" ]
}

@test "Registered nameservers are Google's DNS servers" {
    run vagrant_ssh 'fgrep "nameserver 8.8." /etc/resolv.conf | wc -l'
    [ "$status" -eq 0 ]
    [ "$output" -eq 2 ]
}

@test "NTPD sync at start" {
    run vagrant_ssh 'cat /etc/conf.d/ntpd'
    [ "$status" -eq 0 ]
    [ "$output" -eq 'NTPD_OPTS="-s"' ]
}

@test "Swap is enabled" {
    run vagrant_ssh 'free -m | grep Swap | awk "{print \$2}"'
    [ "$status" -eq 0 ]
    [ "$output" -ge 0 ]
}

@test "Shutdown command exist" {
    run vagrant_ssh 'which shutdown'
    [ "$status" -eq 0 ]
    [ "$output" = "/sbin/shutdown" ]
}

@test "Root filesystem located on a LVM volume" {
    run vagrant_ssh 'sudo df -h | grep "/dev/vg0/lv_root" \
      | grep "/$" | wc -l'
    [ "$status" -eq 0 ]
    [ "$output" -eq 1 ]
}
