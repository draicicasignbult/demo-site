#!/bin/bash
# 这是一个用于快速推送到 GitHub Pages 的 Shell 脚本

echo "=== 开始部署简历项目到 GitHub ==="

# 1. 初始化 git (如果还没初始化)
if [ ! -d ".git" ]; then
    git init
    echo "已初始化 Git 仓库。"
fi

# 2. 提示用户输入仓库地址
read -p "请输入您的 GitHub 仓库地址 (例如: https://github.com/您的用户名/resume.git): " repo_url

if [ -n "$repo_url" ]; then
    # 检查是否已添加 origin
    git remote -v | grep -w origin > /dev/null
    if [ $? -ne 0 ]; then
        git remote add origin $repo_url
    else
        git remote set-url origin $repo_url
    fi
fi

# 3. 添加并提交文件
git add index.html deploy.sh
git commit -m "部署: 更新个人简历 (单文件版)"

# 4. 推送到 main 分支
git branch -M main
echo "正在推送..."
git push -u origin main

echo "=== 推送完成！==="
echo "请进入 GitHub 仓库，在 Settings -> Pages 中选择 main 分支，几分钟后您的在线简历即可访问！"
