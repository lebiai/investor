---
name: investor-research-digest
description: "文件管理+知识沉淀。上传文件/链接→转MD→分析→知识库入库→输出摘要。支持检索已存文件"
---

# 信息管理

## 触发词

- "帮我整理这篇文章/这个文件"
- "总结一下这个"
- "帮我读一下这个"
- "处理这个文件"
- "帮我找一下[文件名/关键词]"

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
2. 记录元数据到 `file-index.md`
3. 调用微软格式转换 API（PDF/Office 文件）
4. 保存原始文件到 `files/original/`
5. 保存 MD 到 `files/YYYY-MM/`

### Step 3: 内容分析

加载 `references/content-analyzer.md`：
1. 体裁识别
2. 核心观点提取（3-5 条 + 置信度）
3. 关键数据提取
4. 关联实体识别

### Step 4: 知识库写入

加载 `references/knowledge-base-writer.md`：
1. 按规则写入 knowledge-base/sectors/、companies/、或仅归档
2. 更新 knowledge-base/index.md

### Step 5: 输出摘要

输出格式：
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

### 文件检索模式

如果用户说"帮我找一下"：
1. 查 `knowledge-base/file-index.md` → 匹配文件名/内容/时间/项目
2. 匹配到 → 输出 `files/YYYY-MM/` 下的完整 MD 内容
3. 未匹配到 → "未找到完全匹配，以下是近似结果..."
