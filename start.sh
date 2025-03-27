#!/bin/bash

# 设置虚拟环境目录
VENV_DIR="venv"

# 设置 Python 运行的脚本
PYTHON_SCRIPT="atk2.py"

# 进入虚拟环境
source "$VENV_DIR/bin/activate"

# 启动 Python 脚本，并将输出重定向到日志文件，后台运行
nohup python "$PYTHON_SCRIPT" > atk2.log 2>&1 &

# 获取进程 ID (PID)
echo $! > atk2.pid

# 退出虚拟环境（防止影响其他操作）
deactivate

echo "Script started with PID: $(cat atk2.pid)"
