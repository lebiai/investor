# 投资人 AI 技能套件

> **完整交付物** — 整个项目目录直接交付投资人，无需拆解或筛选。

## 这是什么

为投资人打造的全套 Codex 实操技能体系。纯对话驱动，开箱即用。

## 快速开始

### 1. 部署

将整个 `投资人/` 目录放入 Codex 环境（如 `~/Documents/`），在 Codex 中打开此目录。

### 2. 初始化

进入项目会话，说 **"初始化"**，一键完成：
- ✅ 安装 `uv`（MarkItDown 运行时）
- ✅ 安装 `markitdown` skill（微软文件转 MD，支持 PDF/Word/PPT/Excel/图片/音频/YouTube）
- ✅ 注册 5 个投资人技能
- ✅ 预下载 MarkItDown 依赖
- ✅ 安装 `docsify`（知识库浏览）
- ✅ 创建 `outputs/` 产出目录

### 3. 使用

初始化完成后，**新建会话**，说 **"开工"** 即可看到完整功能菜单。

## 技能一览

| 技能 | 触发词 | 用途 |
|------|--------|------|
| `investor-workbench` | "开工" / "初始化" | 总入口 + 初始化 |
| `investor-sector-analysis` | "分析一下[赛道]" | 赛道分析（六维+机构+公司扫描+辩论） |
| `investor-research-digest` | "帮我整理这个" | 文件→MD→知识库自动沉淀 |
| `investor-content-prod` | "帮我写一篇[话题]" | 知识库驱动内容生产 |
| `investor-deal-sourcing` | "帮我扫描[领域]" | 项目 sourcing |
| `markitdown` | 自动调用 | 微软文件转 MD（依赖） |

## 目录结构

```
投资人/
├── scripts/
│   └── init.sh            ← 一键初始化脚本（"初始化"触发）
├── knowledge-base/         ← 共享知识库（自动累积）
├── investor-workbench/     ← 总入口 skill
├── investor-sector-analysis/  ← 赛道分析 skill
├── investor-research-digest/  ← 信息管理 skill
├── investor-content-prod/     ← 内容产出 skill
├── investor-deal-sourcing/    ← 项目扫描 skill
├── docs/                   ← 设计文档 + 实施计划
├── outputs/                ← 内容产出物
├── README.md               ← 本文件
└── CHANGELOG.md            ← 修改记录
```

## 知识库浏览

```bash
cd knowledge-base && npx docsify serve .
```

浏览器打开 http://localhost:3000

## 迁移

```bash
# 打包整个目录交付给投资人
cd /path/to/
tar czf 投资人.tar.gz 投资人/
```

投资人解压后打开项目，说 **"初始化"** 即完成全部配置。
