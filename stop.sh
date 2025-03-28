#!/bin/bash

# 打印当前所有的 python3 start.py 进程
echo "当前运行中的 python3 start.py 进程："
ps aux | grep 'python3 start.py' | grep -v grep

# 查找所有运行中的 python3 start.py 进程并强制终止它们
for pid in $(ps aux | grep 'python3 start.py' | grep -v grep | awk '{print $2}'); do
    echo "Force stopping process with PID: $pid"
    
    # 强制终止进程
    kill -9 "$pid"
    
    # 打印已停止进程的信息
    if ! ps -p "$pid" > /dev/null; then
        echo "Process $pid 已被强制停止"
    else
        echo "Failed to stop process $pid"
    fi
done

# 再次打印当前是否仍有相关进程
echo "当前运行中的 python3 start.py 进程："
ps aux | grep 'python3 start.py' | grep -v grep
