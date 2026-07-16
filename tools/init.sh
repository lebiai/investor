#!/usr/bin/env bash
# VERSION: 1.4.0

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CODEX_SKILLS_DIR="${CODEX_SKILLS_DIR:-$HOME/.codex/skills}"

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║     🚀 投资人技能套件 — 一键初始化               ║"
echo "╚══════════════════════════════════════════════════╝"
echo "  项目目录: $PROJECT_DIR"
echo ""

STEP=0
TOTAL=7

STEP=$((STEP + 1))
echo "┌─ [$(date +%H:%M:%S)] Step $STEP/$TOTAL: 检测环境 ────────┐"
command -v python3 &>/dev/null && echo "  ✅ Python3 $(python3 --version 2>&1)"
command -v pip3 &>/dev/null && echo "  ✅ pip3"
echo ""

STEP=$((STEP + 1))
echo "┌─ [$(date +%H:%M:%S)] Step $STEP/$TOTAL: 安装 markitdown ──┐"
if python3 -c "import markitdown" 2>/dev/null; then
    echo "  ✅ markitdown $(python3 -c "import importlib.metadata; print(importlib.metadata.version('markitdown'))")"
else
    pip3 install markitdown[pdf,pptx,docx,xlsx] -q && echo "  ✅ markitdown" || echo "  ⚠️  失败"
fi
echo ""

STEP=$((STEP + 1))
echo "┌─ [$(date +%H:%M:%S)] Step $STEP/$TOTAL: 注册 agent-reach ──┐"
AGENT_REACH_DIR="$CODEX_SKILLS_DIR/agent-reach"
if [ -f "$AGENT_REACH_DIR/SKILL.md" ]; then
    echo "  ✅ agent-reach 已注册"
else
    if [ -d "$PROJECT_DIR/../Agent-Reach" ]; then
        mkdir -p "$CODEX_SKILLS_DIR"
        cp -r "$PROJECT_DIR/../Agent-Reach/skill"/* "$AGENT_REACH_DIR/" && echo "  ✅ agent-reach"
    else
        echo "  ⚠️  未找到（可手动: git clone https://github.com/Panniantong/Agent-Reach.git）"
    fi
fi
echo ""

STEP=$((STEP + 1))
echo "┌─ [$(date +%H:%M:%S)] Step $STEP/$TOTAL: 注册投资人技能 ─────┐"
SKILL_LIST="init workbench sector-analysis research-digest template-prod content-prod deal-sourcing watch deal-review portfolio-tracker meeting-notes contact-crm"
COUNT=0
for skill in $SKILL_LIST; do
    TARGET="$CODEX_SKILLS_DIR/$skill"
    SRC="$PROJECT_DIR/skills/$skill"
    if [ -L "$TARGET" ] || [ -d "$TARGET" ]; then
        echo "  ✅ $skill"; COUNT=$((COUNT + 1))
    elif [ -d "$SRC" ]; then
        ln -sf "$SRC" "$TARGET" && echo "  🔗 $skill"; COUNT=$((COUNT + 1))
    fi
done
echo "  📊 $COUNT/12"
echo ""

STEP=$((STEP + 1))
echo "┌─ [$(date +%H:%M:%S)] Step $STEP/$TOTAL: Office 依赖 ──┐"
python3 -c "import docx" 2>/dev/null && echo "  ✅ python-docx" || { pip3 install python-docx -q && echo "  ✅ python-docx"; }
python3 -c "import pptx" 2>/dev/null && echo "  ✅ python-pptx" || { pip3 install python-pptx -q && echo "  ✅ python-pptx"; }
python3 -c "import openpyxl" 2>/dev/null && echo "  ✅ openpyxl" || { pip3 install openpyxl -q && echo "  ✅ openpyxl"; }
echo ""

STEP=$((STEP + 1))
echo "┌─ [$(date +%H:%M:%S)] Step $STEP/$TOTAL: 创建目录 ──────┐"
mkdir -p "$PROJECT_DIR/data/portfolio" "$PROJECT_DIR/data/meetings" "$PROJECT_DIR/data/contacts" "$PROJECT_DIR/outputs"
echo "  ✅ data/ portfolio/ meetings/ contacts/ outputs/"
echo ""

STEP=$((STEP + 1))
echo "┌─ [$(date +%H:%M:%S)] Step $STEP/$TOTAL: 验证 ─────────────┐"
MARKITDOWN_OK="❌"; python3 -c "import markitdown" 2>/dev/null && MARKITDOWN_OK="✅"
AGENT_REACH_OK="❌"; [ -f "$AGENT_REACH_DIR/SKILL.md" ] && AGENT_REACH_OK="✅"
SKILL_COUNT=0
for s in $SKILL_LIST; do
    [ -L "$CODEX_SKILLS_DIR/$s" ] || [ -d "$CODEX_SKILLS_DIR/$s" ] && SKILL_COUNT=$((SKILL_COUNT + 1))
done
echo "  markitdown: $MARKITDOWN_OK | agent-reach: $AGENT_REACH_OK | 投资人: $SKILL_COUNT/12"
echo ""

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║     ✅  初始化完成！                             ║"
echo "╚══════════════════════════════════════════════════╝"
