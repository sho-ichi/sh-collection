#!/bin/bash

source ./repeat_test.conf

if [ $REBOOT_ENABLE -eq 1 ]; then
    # ファイル転送, 非再起動試験時事前実行
    bash ./sftp_upper_test_file.sh
    result=$?

    while :
    do
        if [ "$result" = "0" ]; then 
            echo "sftp success"
            break
        elif [ "$result" = "7" ]; then
            echo "sftp timeout"
        else
            :
            echo "other scp error:$result"
        fi
    done
fi


if [ $REBOOT_ENABLE -eq 1 ]; then

    date=`date "+%Y_%m_%d_%H_%M"`

    # 5秒置きにping、最大10分間待機
    bash ./ping10min.sh
    result=$?

    if [ "$result" = "0" ]; then 
        echo "ping success"
    elif [ "$result" = "5" ]; then
        echo "ping timeout"
        exit $result
    else
        :
        echo "other ping error:$result"
        exit $result
    fi
fi

# 成功回数 += 1, 非再起動試験時ループ実行
bash ./count_num_of_test.sh
