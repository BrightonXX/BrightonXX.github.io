#!/bin/bash
# 并行工作冲突检测脚本

# 切换到脚本所在目录
cd "$(dirname "$0")"

echo "🔍 检查并行工作冲突..."
echo ""

# 1. 检查Git状态
echo "📁 Git状态："
if [ -d .git ]; then
    git status --short
else
    echo "   ℹ️  不是Git仓库"
fi
echo ""

# 2. 检查是否有未提交的更改
if [ -d .git ]; then
    if [ -n "$(git status --porcelain)" ]; then
        echo "⚠️  警告：有未提交的更改"
        echo "   如果其他session也在工作，可能冲突！"
    else
        echo "✅ 工作区干净"
    fi
fi
echo ""

# 3. 检查最近修改的文件（5分钟内）
echo "📝 最近修改的文件："
find . -type f -mmin -5 ! -path "./.git/*" ! -path "./public/*" ! -path "./resources/*" | head -10
echo ""

# 4. 检查Hugo是否在运行
if pgrep -f "hugo server" > /dev/null; then
    echo "✅ Hugo server 正在运行"
else
    echo "ℹ️  Hugo server 未运行"
fi
echo ""

# 5. 建议
echo "💡 并行工作建议："
echo "   • 不同session修改不同文件"
echo "   • 只有1个session负责git操作"
echo "   • 定期git pull同步更改"
echo ""
