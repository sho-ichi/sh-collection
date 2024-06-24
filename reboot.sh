#!/bin/bash

source ./repeat_test.conf

expect -c "
set timeout 2400
spawn ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o HostKeyAlgorithms=+ssh-rsa $USER_NAME@$IP_ADDRESS
expect \"password: \"
send \"${PASS}\n\"

expect \"#\"
send \"ls -l\n\"

expect \"Result\"
send \"sudo reboot\n\"


expect {
    \"The system is going down for system halt NOW!\" {
        exit 0
    }
    timeout {
        exit 11
    }
}
"
