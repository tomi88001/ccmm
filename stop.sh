#!/bin/bash

# 任务列表（与 start.sh 保持一致）
declare -A TASKS
TASKS["task1"]="python3 start.py GET https://example1.com 5 100 proxy.txt 100 60"
TASKS["task2"]="python3 start.py GET https://example2.com 5 200 proxy.txt 150 120"
TASKS["task3"]="python3 start.py POST https://example3.com 5 300 proxy.txt 200 180"

# 遍历任务并终止
for task in "${!TASKS[@]}"; do
    if [ -f "pids/${task}.pid" ]; then
        PID=$(cat "pids/${task}.pid")
        echo "Stopping $task (PID: $PID)..."
        
        # 终止进程
        kill "$PID"
        
        # 删除 PID 文件
        rm -f "pids/${task}.pid"

        echo "$task 已停止"
    else
        echo "$task 未运行"
    fi
done
