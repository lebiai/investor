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
- ✅ 安装 `markitdown` skill（微软文件转 MD）
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
├── versions/               ← 版本归档（每版完整快照，只增不删）
│   └── v1.0.0/             ← 初始版本
├── scripts/
│   ├── init.sh             ← 一键初始化
│   └── archive.sh          ← 版本归档（更新前运行）
├── knowledge-base/         ← 共享知识库（自动累积）
├── investor-*/             ← 5 个 skill（当前最新版本）
├── docs/                   ← 设计文档 + 实施计划
├── outputs/                ← 内容产出物
├── README.md               ← 本文件
└── CHANGELOG.md            ← 版本变更记录
```

## 版本管理规范

**原则：** 每个 SKILL.md 只保留当前最新执行方案，不包含旧版流程、新旧对比、迭代记录。

**更新流程：**
```bash
# 1. 归档当前版本
bash scripts/archive.sh v1.1.0

# 2. 直接修改 SKILL.md（覆盖式，不写旧版内容）
# 3. 在 CHANGELOG.md 加一行记录
```

**查看历史：** 所有旧版本完整保留在 `versions/` 目录下。

## 知识库浏览

```bash
cd knowledge-base && npx docsify serve .
```

浏览器打开 http://localhost:3000

## 迁移

```bash
tar czf 投资人.tar.gz 投资人/
```

投资人解压后打开项目，说 **"初始化"** 即完成全部配置。
