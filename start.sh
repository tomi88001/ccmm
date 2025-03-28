#!/bin/bash
git pull
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
# source "venv/bin/activate"
# python3 atk2.py
# 安装依赖（确保 requests 和 pysocks 存在）
pip3 install --upgrade pip
pip3 install requests pysocks

# 运行 Python 脚本，并后台执行
PYTHON_SCRIPT="atk2.py"
sh stop.sh
if [ "$1" == "back" ]; then
    if [ ! -d "$PYTHON_SCRIPT" ]; then
        nohup python3 "$PYTHON_SCRIPT" > output.log 2>&1 &
        tail -f output.log
    fi
else
    python3 "$PYTHON_SCRIPT"
fi



echo "脚本已启动，日志保存在 output.log"
