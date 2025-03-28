#!/bin/bash

# 读取进程 ID
if [ -f "atk2.pid" ]; then
    PID=$(cat atk2.pid)
    echo "Stopping script with PID: $PID"
    
    # 终止进程
    kill "$PID"
    
    # 等待进程完全退出（最多 5 秒）
    for i in {1..5}; do
        if ps -p "$PID" > /dev/null 2>&1; then
            echo "Waiting for process to exit..."
            sleep 1
        else
            break
        fi
    done

    # 强制终止（如果仍然存活）
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "Process still running, force killing..."
        kill -9 "$PID"
    fi

    # 确保进程已终止后删除 PID 文件
    if ! ps -p "$PID" > /dev/null 2>&1; then
        rm -f atk2.pid
        echo "Script stopped and PID file removed."
    else
        echo "Failed to stop the script!"
    fi
else
    echo "No PID file found. Script may not be running."
fi
