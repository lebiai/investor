---
name: investor-research-digest
version: 1.1.0
description: "文件管理+知识沉淀。上传文件/链接→转MD→分析→知识库入库→输出摘要。支持检索已存文件"
---

# 信息管理

## 触发词

- "帮我整理这篇文章/这个文件"
- "总结一下这个"
- "帮我读一下这个"
- "处理这个文件"
- "帮我找一下[文件名/关键词]"

## 数据来源

本 skill 的数据来源：

| 来源 | 说明 |
|------|------|
| ① 用户上传/链接 | 文件内容本身 |
| ② [skill:agent-reach] 搜索 | 实体识别时的补充查询 |
| ③ data/ 知识库 | 历史内容的关联匹配 |

## 工作流

### Step 1: 输入确认

识别用户提供的内容类型：
- 文件上传（PDF/Word/PPT/Excel/图片）
- 网页链接
- 粘贴的纯文本

如果用户没提供具体内容，追问："请上传文件或提供链接/文字"

### Step 2: 文件处理

加载 `references/file-processor.md`：
1. 识别文件类型，选择处理方式
2. 记录元数据到 `data/file-index.md`
3. 调用微软格式转换 API（PDF/Office 文件）
4. 保存原始文件到 `files/original/`
5. 保存 MD 到 `files/YYYY-MM/`

### Step 3: 内容分析 [来源: ①用户上传 + ③知识库]

加载 `references/content-analyzer.md`：
1. 体裁识别
2. 核心观点提取（3-5 条 + 置信度）
3. 关键数据提取
4. 关联实体识别

### Step 4: 知识库写入 [来源: ③知识库]

加载 `references/knowledge-base-writer.md`：
1. 按规则写入 `data/sectors/`、`data/companies/`、或归档到 `data/files/[体裁]/YYYY-MM/`
   - 所有文件使用 `docs/DATA-STANDARD.md` 规定的 YAML header
   - sector/company 见 §3.1/§3.2，file 见 §3.5
2. 更新 `data/index.md` 或 `data/file-index.md`（格式见 §2.1/§2.2）

### Step 5: 输出摘要

内容直接输出在会话中供用户阅读：
```
📋 一句话总结：...

📝 核心观点：
- [观点1]（高置信度）
- [观点2]（中置信度）
...

📊 关键数据：...

🔗 知识库关联：
- 已关联赛道：[赛道名]（已有分析记录）
- 已关联公司：[公司名]（N条历史记录）

💡 新发现：...
```
文件处理、入库等后台操作已完成，用户无需手动操作。

### 文件检索模式

如果用户说"帮我找一下"，搜索流程参考 `docs/SEARCH-PROTOCOL.md`：
1. **rg 全文搜索（Phase 1）：** `rg -i "{关键词}" data/files/ -l --md`
   - 匹配到 → 输出对应文件的完整 MD 内容
2. **索引表搜索（Phase 2）：** 如 rg 未匹配，查 `data/file-index.md`
   - 按文件名/分类/标签匹配
3. **无结果：** → "未找到完全匹配，以下是近似结果..."
