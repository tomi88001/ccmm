#!/bin/bash

# 任务的 Shell 脚本路径（修改为你的 `start.sh` 真实路径）
SCRIPT_PATH="/root/ccmm/start.sh"
SCRIPT_ARGS="back"

# 定时任务内容（确保 crontab 能正确解析参数）
CRON_JOB="0 */2 * * * /bin/bash -c '$SCRIPT_PATH $SCRIPT_ARGS'"

# 检查 crontab 是否安装
if ! command -v crontab &>/dev/null; then
    echo "crontab 未安装，正在安装..."
    
    if [ -f /etc/debian_version ]; then
        sudo apt update && sudo apt install -y cron
        sudo systemctl enable cron && sudo systemctl start cron
    else
        echo "未知的 Linux 发行版，请手动安装 crontab！"
        exit 1
    fi
    
    echo "crontab 安装完成！"
fi

# 先删除已有的相同任务（避免重复添加）
(crontab -l 2>/dev/null | grep -v "$SCRIPT_PATH" || true) | crontab -

# 重新添加定时任务
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

echo "定时任务已更新，每 2 小时执行一次: $SCRIPT_PATH $SCRIPT_ARGS"
