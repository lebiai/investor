#!/usr/bin/env bash
# ============================================================
# 版本归档脚本
# 在每次更新 Skill 前运行，将当前版本完整归档到 archive/。
# 用法: bash ../tools/archive.sh v1.1.0
# ============================================================

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [ $# -lt 1 ]; then
    echo "用法: bash ../tools/archive.sh <版本号>"
    echo "示例: bash ../tools/archive.sh v1.1.0"
    exit 1
fi

VERSION="$1"
ARCHIVE_DIR="$PROJECT_DIR/archive/$VERSION"

if [ -d "$ARCHIVE_DIR" ]; then
    echo "❌ 版本 $VERSION 已存在: $ARCHIVE_DIR"
    exit 1
fi

echo "📦 归档版本 $VERSION ..."

mkdir -p "$ARCHIVE_DIR"

# 归档 5 个 skill
for dir in workbench sector-analysis research-digest content-prod deal-sourcing; do
    if [ -d "$PROJECT_DIR/$dir" ]; then
        cp -r "$PROJECT_DIR/$dir" "$ARCHIVE_DIR/$dir"
        echo "  ✅ $dir"
    fi
done

# 归档 data 骨架
if [ -d "$PROJECT_DIR/data" ]; then
    cp -r "$PROJECT_DIR/data" "$ARCHIVE_DIR/data"
    echo "  ✅ data"
fi

# 归档 scripts
if [ -d "$PROJECT_DIR/tools" ]; then
    cp -r "$PROJECT_DIR/tools" "$ARCHIVE_DIR/tools"
    echo "  ✅ tools"
fi

# 归档 docs
if [ -d "$PROJECT_DIR/docs" ]; then
    cp -r "$PROJECT_DIR/docs" "$ARCHIVE_DIR/docs"
    echo "  ✅ docs"
fi

# 归档根文档
cp "$PROJECT_DIR/README.md" "$ARCHIVE_DIR/README.md"
cp "$PROJECT_DIR/CHANGELOG.md" "$ARCHIVE_DIR/CHANGELOG.md"
echo "  ✅ README / CHANGELOG"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ 版本 $VERSION 已归档到:"
echo "   $ARCHIVE_DIR"
echo ""
echo "现在可以安全地更新 Skill 了。"
echo "更新后别忘了在 CHANGELOG.md 添加记录。"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━"
