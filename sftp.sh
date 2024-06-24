#!/bin/bash

source ./repeat_test.conf

expect -c "
set timeout 300
spawn sftp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o HostKeyAlgorithms=+ssh-rsa $USER_NAME@$IP_ADDRESS
expect \"password: \"
send \"${PASS}\n\"

expect \"sftp>\"
send \"put ./test.txt\n\"

expect \"sftp>\"
send \"bye\r\"
"
