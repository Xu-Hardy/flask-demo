#!/bin/bash

set -e

# ==== 配置区域 ====
IMAGE_NAME="cloudsmithy/flask-demo"  # ← 修改为你的 Docker Hub 镜像名
PLATFORMS="linux/amd64,linux/arm64"   # 支持多架构
# ==================

# 获取 TAG，优先使用 Git tag，其次 fallback 为时间戳
TAG=$(git describe --tags --abbrev=0 2>/dev/null || date +%Y%m%d)

echo "🔖 使用镜像 tag：$TAG"
echo "📦 构建镜像：$IMAGE_NAME:$TAG"

# 登录 Docker Hub（可选，如果已登录则会跳过）
docker login -u cloudsmithy
# 启用 buildx（确保 buildx 构建器已存在）
docker buildx create --name multiarch --use 2>/dev/null || true
docker buildx inspect --bootstrap

# 构建并推送镜像
docker buildx build --platform $PLATFORMS \
  -t "$IMAGE_NAME:$TAG" \
  -t "$IMAGE_NAME:latest" \
  --push .
