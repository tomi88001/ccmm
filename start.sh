#!/bin/bash

git pull  # 更新代码

# 指定虚拟环境目录
VENV_DIR="venv"

# 如果虚拟环境不存在，则创建
if [ ! -d "$VENV_DIR" ]; then
    echo "虚拟环境不存在，正在创建..."
    python3 -m venv "$VENV_DIR"
    echo "虚拟环境创建完成！"
fi

# 激活虚拟环境
source "$VENV_DIR/bin/activate"

# 安装依赖
pip3 install -r requirements.txt

# 任务列表（可以添加多个任务）
# 
declare -A TASKS
TASKS["task1"]="python3 start.py GET https://api.dovmarkets.com 6 200 proxy.txt 100 60"
TASKS["task2"]="python3 start.py GET https://api.gtcfxvip.cc 6 200 proxy.txt 100 60"
TASKS["task3"]="python3 start.py POST https://api.axciones.com 6 200 proxy.txt 100 60"

# 遍历任务并启动
for task in "${!TASKS[@]}"; do
    CMD="${TASKS[$task]}"
    
    # 检查是否已经运行
    if pgrep -f "$CMD" > /dev/null; then
        echo "$task 已经在运行，不需要重复启动。"
    else
        nohup $CMD > "logs/${task}.log" 2>&1 &
        echo $! > "pids/${task}.pid"
        echo "$task 启动成功，日志：logs/${task}.log"
    fi
done

echo "所有任务已启动！"
