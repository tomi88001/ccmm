#!/bin/bash

echo "Stopping all atk2.py processes..."

# 找到所有 atk2.py 进程
PIDS=$(pgrep -f "python3 atk2.py")

if [ -n "$PIDS" ]; then
    echo "Found processes: $PIDS"

    # 先尝试普通 kill
    kill $PIDS
    sleep 2  # 等待 2 秒，看看进程是否退出

    # 检查是否还有存活进程
    PIDS=$(pgrep -f "python3 atk2.py")
    if [ -n "$PIDS" ]; then
        echo "Processes still running, force killing..."
        kill -9 $PIDS
    fi

    echo "All atk2.py processes stopped."
else
    echo "No atk2.py process found."
fi

# 确保清理 PID 文件（如果存在）
rm -f atk2.pid
