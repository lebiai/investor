---
name: investor-init
version: 1.2.0
description: "投资人技能套件一键初始化"
---

# 初始化

## 触发词

- "初始化" / "安装" / "配置"

## 说明

逐项执行以下检查清单。**每项先确认是否已完成，已完成则跳过。**

## 清单

### □ 1. 检测环境
确认以下信息，记录下来供后续使用：
- 当前工作目录（这就是项目根目录）
- `~/.codex/skills/` 是否存在、里面有什么
- Python 3 是否可用
- pip 是否可用

### □ 2. 安装 markitdown（微软文件转 MD 工具）
`pip show markitdown`（https://github.com/microsoft/markitdown）
- 已安装 → 跳过
- 未安装 → `pip install markitdown[pdf,pptx,docx,xlsx]`

### □ 3. 注册 agent-reach（互联网搜索路由器）
检查 `~/.codex/skills/agent-reach/SKILL.md` 是否存在：
- 存在 → 跳过
- 不存在 → 从 GitHub 克隆 `Panniantong/Agent-Reach`，把 `agent_reach/skill/` 放到 `~/.codex/skills/agent-reach/`
- GitHub 不通 → 跳过

### □ 4. 注册 11 个投资人技能
对以下每个技能，检查 `~/.codex/skills/[技能名]` 是否存在：
- 存在 → 跳过
- 不存在 → 从项目 `skills/[技能名]` 创建软链接到 `~/.codex/skills/[技能名]`

`workbench`, `sector-analysis`, `research-digest`, `template-prod`, `content-prod`, `deal-sourcing`, `watch`, `deal-review`, `portfolio-tracker`, `meeting-notes`, `contact-crm`

### □ 5. 安装 Office 依赖
检查 Python 能否同时 import `docx`、`pptx`、`openpyxl`：
- 全都能 → 跳过
- 有缺失 → pip 安装缺失部分

### □ 6. 创建数据目录
`data/portfolio/`、`data/meetings/`、`data/contacts/`、`outputs/`

### □ 7. 输出初始化结果

```
工具: markitdown [ok/fail]
技能: agent-reach [ok/fail] | 投资人 [N/12]
```

## 约束

- **先检查，后执行**
- **GitHub 不通不阻塞**
- **单步失败不影响整体**
