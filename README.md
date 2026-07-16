# 投资人 AI 技能套件

> **完整交付物** — 整个项目目录直接给投资人，无需拆解或筛选。

## 这是什么

为投资人打造的全套 Codex 实操技能体系。纯对话驱动，开箱即用。

## 目录结构

```
投资人/
├── README.md                           ← 本文件（项目说明）
├── CHANGELOG.md                        ← 修改记录
├── docs/                               ← 设计文档 + 实施计划
│   ├── 2026-07-16-investor-skills-design.md
│   └── plans/
│       └── 2026-07-16-investor-skills-plan.md
│
├── knowledge-base/                     ← 共享知识库（自动累积，越用越深）
│   ├── README.md
│   ├── index.md                        ← 全局索引
│   ├── file-index.md                   ← 文件索引
│   ├── companies/                      ← 公司档案
│   ├── sectors/                        ← 赛道档案
│   └── files/                          ← 原始文件 + MD 转换件
│
├── investor-workbench/                 ← 总入口
├── investor-sector-analysis/           ← 赛道分析
├── investor-research-digest/           ← 信息管理
├── investor-content-prod/              ← 内容产出
└── investor-deal-sourcing/             ← 项目扫描
```

## 包含技能

| 技能 | 触发词 | 用途 |
|------|--------|------|
| `investor-workbench` | "开工" / "投资助手" | 总入口菜单 |
| `investor-sector-analysis` | "分析一下[赛道]" / "帮我看看[领域]" | 赛道深度分析 + 公司扫描 |
| `investor-research-digest` | "帮我整理这个" | 文件 → MD → 知识库自动沉淀 |
| `investor-content-prod` | "帮我写一篇关于[话题]的..." | 知识库驱动的内容生产 |
| `investor-deal-sourcing` | "帮我扫描[领域]的项目" | 项目 sourcing 扫描 |

## 快速开始

1. 将整个 `投资人/` 目录放入投资人 Codex 环境的 skills 路径下（如 `~/.codex/skills/`）
2. 在 Codex 对话中输入 **"开工"** 即可看到完整功能菜单
3. 如需浏览知识库，终端运行：
   ```bash
   cd knowledge-base && npx docsify serve .
   ```
   浏览器打开 http://localhost:3000

## 外部依赖

| 依赖 | 用途 | 安装方式 |
|------|------|---------|
| docsify | 知识库浏览 | `npm install -g docsify-cli` |
| 微软文件转 MD API | 文件格式转换 | 配置 API key |

## 迁移

```bash
# 直接打包整个目录，交付给投资人
cd /path/to/
tar czf 投资人.tar.gz 投资人/
```

投资人解压后放置到其 Codex skills 目录即可使用，无需额外配置。
