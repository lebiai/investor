---
name: investor-template-prod
description: "模板类文档生成。上传模板→解析结构→按模板生成内容。支持Word/Excel/PPT。触发词：模板、套模板、生成文档"
---

# 模板文档生成

## 触发词

- "保存模板" / "把这个存为模板" — 上传并保存新模板
- "用[模板名]生成一份" / "套[模板名]模板" — 按模板生成内容
- "有哪些模板" / "查看模板列表" — 列出所有可用模板

## 工作流

### 模式一：保存模板

用户上传文件并说"保存模板"：

1. 向用户确认：模板名称、用途、需要填写的字段
2. 加载 `references/template-processor.md`
3. 调用 markitdown 将文件转为 MD
4. 分析结构（标题层级、表格、列表、占位符）
5. 原始文件 → `knowledge-base/templates/original/`
6. 解析文件 → `knowledge-base/templates/parsed/`
7. 更新 `knowledge-base/templates/index.md`
8. 输出"模板 [名称] 已保存"

### 模式二：按模板生成

用户说"用[模板名]生成一份"：

1. 加载 `references/template-generator.md`
2. 查 `knowledge-base/templates/index.md` 匹配模板
3. 读取解析文件获取结构和填写字段
4. 逐项收集用户输入
5. 按结构填充生成内容
6. 交付并询问是否保存

### 模式三：查看模板列表

用户说"有哪些模板"：

1. 读取 `knowledge-base/templates/index.md`
2. 输出模板清单：

```
📋 可用模板：
| 模板名 | 格式 | 用途 | 上传日期 |
|--------|------|------|---------|
| 会议纪要模板 | .docx | 会议记录 | 2026-07-17 |
| ... | ... | ... | ... |

说"用[模板名]生成一份"开始使用
```
