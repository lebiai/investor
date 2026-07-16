# 投资人 AI 技能套件

## 这是什么

为投资人打造的全套 Codex 实操技能体系。纯对话驱动，开箱即用。

## 包含技能

| 技能 | 触发词 | 用途 |
|------|--------|------|
| `investor-workbench` | "开工" / "投资助手" | 总入口菜单 |
| `investor-sector-analysis` | "分析一下[赛道]" / "帮我看看[领域]" | 赛道深度分析 + 公司扫描 |
| `investor-research-digest` | "帮我整理这个" | 文件 → MD → 知识库自动沉淀 |
| `investor-content-prod` | "帮我写一篇关于[话题]的..." | 知识库驱动的内容生产 |
| `investor-deal-sourcing` | "帮我扫描[领域]的项目" | 项目 sourcing 扫描 |

## 快速开始

在 Codex 对话中输入 **"开工"** 即可看到完整功能菜单。

## 知识库

所有分析、文件、内容自动沉淀到 `knowledge-base/`，越用越深。如需浏览知识库：

```bash
cd knowledge-base && npx docsify serve .
```

浏览器打开 http://localhost:3000

## 迁移

打包整个目录迁移到投资人 Codex 环境即可使用，无需额外配置。
