#!/usr/bin/env bash
# VERSION: 2.0.1
# ============================================================
# 技能版本归档脚本 — 只归档 skills/ 下的组件。
# 用法: bash tools/archive.sh <技能名>
#
# 示例:
#   bash tools/archive.sh sector-analysis
#   bash tools/archive.sh deal-review
# ============================================================

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [ $# -lt 1 ]; then
    echo "用法: bash tools/archive.sh <技能名>"
    echo ""
    echo "技能名:"
    echo "  sector-analysis / research-digest / template-prod / content-prod /"
    echo "  deal-sourcing / watch / workbench / deal-review / portfolio-tracker / meeting-notes / contact-crm"
    echo ""
    echo "示例:"
    echo "  bash tools/archive.sh sector-analysis"
    exit 1
fi

COMP_NAME="$1"
SRC_DIR="$PROJECT_DIR/skills/$COMP_NAME"

if [ ! -d "$SRC_DIR" ]; then
    echo "❌ skills/$COMP_NAME 不存在"
    echo "可用技能:"
    ls -d "$PROJECT_DIR/skills/"*/ | sed 's/.*skills\///' | sed 's/\///'
    exit 1
fi

# 读取当前版本号
VERSION=$(rg '^version: ' "$SRC_DIR/SKILL.md" 2>/dev/null | sed 's/^version: *//' || echo "")
if [ -z "$VERSION" ]; then
    echo "❌ $COMP_NAME/SKILL.md 中未找到 version 字段"
    echo "   请在 YAML 头部添加 version: x.y.z"
    exit 1
fi

ARCHIVE_DIR="$PROJECT_DIR/archive/skills/$COMP_NAME/v$VERSION"

if [ -d "$ARCHIVE_DIR" ]; then
    echo "⚠️  版本 v$VERSION 已存在: $ARCHIVE_DIR"
    echo "   是否覆盖？(y/N)"
    read -r CONFIRM
    if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
        echo "  已取消"
        exit 0
    fi
    rm -rf "$ARCHIVE_DIR"
fi

mkdir -p "$ARCHIVE_DIR"
cp -r "$SRC_DIR/"* "$ARCHIVE_DIR/"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ skills/$COMP_NAME v$VERSION 已归档"
echo "   $ARCHIVE_DIR"
echo "现在可以安全地修改了。修改后勿忘在 version 字段升版本。"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
