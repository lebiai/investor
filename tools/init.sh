#!/usr/bin/env bash
# ============================================================
# 投资人技能套件 — 一键初始化脚本
# 首次部署至 Codex 环境时运行，完成全部技能注册和依赖安装。
# 用法: bash ../tools/init.sh
# ============================================================

set -euo pipefail

# ── 路径 ──────────────────────────────────────────────
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CODEX_SKILLS_DIR="${CODEX_SKILLS_DIR:-$HOME/.codex/skills}"
export PATH="$HOME/.cargo/bin:/usr/local/bin:/opt/homebrew/bin:$PATH"

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║     🚀 投资人技能套件 — 一键初始化               ║"
echo "╚══════════════════════════════════════════════════╝"
echo "  项目目录: $PROJECT_DIR"
echo "  Skills  : $CODEX_SKILLS_DIR"
echo ""

# ── Step 1: uv ────────────────────────────────────────
echo "┌─ [1/8] 安装 uv (MarkItDown 运行时) ─────────────┐"
if command -v uv &>/dev/null; then
    echo "  ✅ uv 已安装 ($(uv --version))"
else
    echo "  下载安装中..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo "  ✅ uv 安装完成"
fi
echo ""

# ── Step 2: markitdown skill ──────────────────────────
echo "┌─ [2/8] 安装 markitdown (微软文件转 MD) ─────────┐"
MARKITDOWN_DIR="$CODEX_SKILLS_DIR/markitdown"
if [ -f "$MARKITDOWN_DIR/SKILL.md" ]; then
    echo "  ✅ markitdown 已安装"
else
    echo "  克隆仓库..."
    TMP_REPO=$(mktemp -d)
    git clone --depth 1 https://github.com/dbzabhilash/markitdown-skill-to-save-tokens.git "$TMP_REPO"
    mkdir -p "$CODEX_SKILLS_DIR"
    cp -r "$TMP_REPO"/markitdown "$MARKITDOWN_DIR"
    rm -rf "$TMP_REPO"
    echo "  ✅ markitdown 安装完成"
fi
echo ""

# ── Step 3: agent-reach skill ─────────────────────────
echo "┌─ [3/8] 安装 agent-reach (互联网搜索) ───────────┐"
AGENT_REACH_DIR="$CODEX_SKILLS_DIR/agent-reach"
if [ -f "$AGENT_REACH_DIR/SKILL.md" ]; then
    echo "  ✅ agent-reach 已安装"
else
    echo "  克隆仓库..."
    TMP_REPO=$(mktemp -d)
    git clone --depth 1 https://github.com/Panniantong/Agent-Reach.git "$TMP_REPO"
    mkdir -p "$CODEX_SKILLS_DIR"
    cp -r "$TMP_REPO/agent_reach/skill"/* "$AGENT_REACH_DIR/"
    rm -rf "$TMP_REPO"
    echo "  ✅ agent-reach 安装完成"
    echo "  ⚠️  首次使用 agent-reach 时，可让 AI 运行其安装流程"
fi
echo ""

# ── Step 3: 注册 5 个投资人技能 ────────────────────────
echo "┌─ [4/8] 注册投资人技能 ──────────────────────────┐"
SKILL_LIST="workbench sector-analysis research-digest template-prod content-prod deal-sourcing"
for skill in $SKILL_LIST; do
    TARGET="$CODEX_SKILLS_DIR/$skill"
    if [ -L "$TARGET" ] || [ -d "$TARGET" ]; then
        echo "  ✅ $skill"
    else
        ln -sf "$PROJECT_DIR/$skill" "$TARGET"
        echo "  🔗 $skill → 已注册"
    fi
done
echo ""

# ── Step 4: 预下载 MarkItDown 依赖 ─────────────────────
echo "┌─ [5/8] 预下载 MarkItDown 依赖 ──────────────────┐"
echo "  首次下载约 30 秒，后续即时..."
uvx --python 3.12 --from "markitdown[all]" markitdown --help >/dev/null 2>&1 || true
echo "  ✅ MarkItDown 就绪"
echo ""

# ── Step 5: docsify ────────────────────────────────────
echo "┌─ [6/8] 安装 Office 文件生成依赖 ────────────────┐"
if python3 -c "import docx" 2>/dev/null && python3 -c "import pptx" 2>/dev/null && python3 -c "import openpyxl" 2>/dev/null; then
    echo "  ✅ python-docx / python-pptx / openpyxl 已安装"
else
    echo "  安装中..."
    pip3 install python-docx python-pptx openpyxl -q
    echo "  ✅ Office 文件生成依赖安装完成"
fi
echo ""

echo "┌─ [7/8] 安装 docsify (知识库浏览) ───────────────┐"
if command -v docsify &>/dev/null; then
    echo "  ✅ docsify 已安装"
else
    echo "  安装中..."
    npm install -g docsify-cli
    echo "  ✅ docsify 安装完成"
fi
echo ""

# ── Step 6: 创建 outputs/ ──────────────────────────────
echo "┌─ [8/8] 创建产出目录 ────────────────────────────┐"
mkdir -p "$PROJECT_DIR/outputs"
echo "  ✅ $PROJECT_DIR/outputs/"
echo ""

# ── 完成 ──────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║     ✅  初始化完成！                             ║"
echo "╠══════════════════════════════════════════════════╣"
echo "║                                                  ║"
echo "║  现在新建 Codex 会话即可使用：                    ║"
echo "║                                                  ║"
echo "║  • "开工"             打开功能菜单              ║"
echo "║  • "分析一下[赛道]"    赛道深度分析 + 公司扫描  ║"
echo "║  • "帮我整理这个"      文件→MD→知识库自动沉淀    ║"
echo "║  • "用[模板]生成"      按模板生成Word/PPT/Excel ║"
echo "║  • "帮我写一篇..."     知识库驱动内容生产       ║"
echo "║  • "帮我扫描[领域]"    项目 sourcing 扫描      ║"
echo "║                                                  ║"
echo "║  知识库浏览（可选）：                            ║"
echo "║    cd $PROJECT_DIR/data                          ║"
echo "║    npx docsify serve .                           ║"
echo "║    浏览器打开 http://localhost:3000              ║"
echo "║                                                  ║"
echo "╚══════════════════════════════════════════════════╝"
echo "╚══════════════════════════════════════════════════╝"
