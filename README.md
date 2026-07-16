# 投资人 AI 技能套件

> **完整交付物** — 整个项目目录直接交付投资人，无需拆解或筛选。

## 快速开始

### 1. 部署

将整个 `投资人/` 目录放入 Codex 环境，在 Codex 中打开此目录。

### 2. 初始化

进入项目会话，说 **"初始化"**，一键完成全部配置。

### 3. 使用

初始化完成后，**新建会话**，说 **"开工"** 即可看到完整功能菜单。

## 项目结构

```
投资人/
├── skills/                  ← 技能层（7 个 Codex Skill）
│   ├── workbench/           ← 总入口 + 初始化
│   ├── sector-analysis/     ← 赛道分析
│   ├── research-digest/     ← 信息管理
│   ├── template-prod/       ← 模板生成
│   ├── content-prod/        ← 内容产出
│   ├── deal-sourcing/       ← 项目扫描
│   ├── watch/               ← 盯盘跟踪
│   └── deal-review/         ← 项目审阅
│
├── data/                    ← 数据层（自动累积）
├── tools/                   ← 工具层（init/archive）
├── docs/                    ← 文档层
├── archive/                 ← 归档层（历史版本）
├── outputs/                 ← 产出层（生成的文件）
│
├── AGENTS.md                ← 全局规则
├── README.md
└── CHANGELOG.md
```

## 技能一览

| 技能 | 触发词 | 用途 |
|------|--------|------|
| `workbench` | "开工" / "初始化" | 总入口 + 一键初始化 |
| `research-digest` | "帮我整理这个文件/链接" | ① 内容梳理 |
| `sector-analysis` | "分析一下[赛道]" | ② 赛道分析（六维+机构+公司扫描+辩论） |
| `deal-review` | "帮我看这个BP" / "审阅这个项目" | ③ BP审阅，多角色辩论 + 尽调路线图 |
| `deal-sourcing` | "帮我扫描[领域]的项目" | ④ 项目 sourcing |
| `portfolio-tracker` | "我的投资组合" / "[公司]最近怎么样" | ⑤ 投后管理看板 |
| `watch` | "关注[赛道]" / "[赛道]有什么新动态" | ⑥ 盯盘跟踪 + 每日简报 |
| `content-prod` | "帮我写一篇[话题]的[体裁]" | ⑦ 文章报告 + IC备忘录 |
| `template-prod` | "用[模板名]生成" / "把这个模板化" | ⑧ 文档模板生成 |
| `meeting-notes` | "帮我记一下今天的会" | ⑨ 会议纪要引擎 |
| `contact-crm` | "帮我记一下[姓名]" / "查一下[姓名]" | ⑩ 人脉管理 |
| `personal-growth` | "周报" / "记录一下..." | ⑪ 个人洞察积累 |


## 用户指南

> 详细使用说明见 `docs/USER-GUIDE.md` — 每个能力的触发方式、用好它的关键。
## 版本规范

- 每个 SKILL.md 只保留当前最新执行方案
- 更新前运行 `bash tools/archive.sh vX.Y.Z` 归档
- 历史版本保留在 `archive/` 目录下

## 知识库浏览

```bash
cd data && npx docsify serve .
```

浏览器打开 http://localhost:3000

## 迁移

```bash
tar czf 投资人.tar.gz 投资人/
```
