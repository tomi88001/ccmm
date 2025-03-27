#!/bin/bash

# 读取进程 ID
if [ -f "atk2.pid" ]; then
    PID=$(cat atk2.pid)
    echo "Stopping script with PID: $PID"
    
    # 终止进程
    kill "$PID"
    
    # 删除 PID 文件
    rm -f atk2.pid

    echo "Script stopped."
else
    echo "No PID file found. Script may not be running."
fi
