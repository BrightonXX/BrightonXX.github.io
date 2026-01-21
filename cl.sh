#!/bin/bash
# Claude Session Manager - 自动选择或继续会话

# 检查是否有参数
if [ "$1" = "-n" ] || [ "$1" = "--new" ]; then
    # 强制开新会话
    claude --session-id $(uuidgen)
elif [ "$1" = "-l" ] || [ "$1" = "--list" ]; then
    # 列出所有会话
    echo "Available sessions:"
    claude --resume ""
else
    # 默认：打开交互式选择器
    claude --resume
fi
