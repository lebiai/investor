---
name: investor-template-prod
description: "模板类文档生成。上传空白模板/成品文档提取→解析结构→按模板生成Word/PPT/Excel文件。利用Codex内置文档能力输出。"
---

# 模板文档生成

## 触发词

- "保存模板" / "把这个存为模板" — 上传空白模板直接保存
- "把这个模板化" — 上传成品文档，自动提取模板结构
- "用[模板名]生成一份" / "套[模板名]模板" — 按模板生成 Word/PPT/Excel 文件
- "有哪些模板" / "查看模板列表" — 列出所有可用模板

## 工作流

### 模式一：保存空白模板

用户上传空白模板文件并说"保存模板"：

1. 向用户确认：模板名称、用途、需要填写的字段
2. 加载 `references/template-processor.md` — 模式A
3. 调用 markitdown 转换 → 分析结构
4. 原始文件 → `templates/original/`，解析文件 → `templates/parsed/`
5. 更新 `templates/index.md`

### 模式二：从成品文档提取模板

用户上传已填好的文档并说"把这个模板化"：

1. 告知用户："正在分析文档结构，准备提取模板..."
2. 加载 `references/template-processor.md` — 模式B
3. 调用 markitdown 转换
4. 自动识别：固定结构 vs 变量字段
5. 输出字段清单让用户确认
6. 确认后保存模板
7. 输出："模板 [名称] 已就绪，说'用[名称]生成一份'即可使用"

### 模式三：按模板生成 Office 文件 ⭐

用户说"用[模板名]生成一份"：

1. 加载 `references/template-generator.md`
2. 查模板索引，读取解析文件获取结构和字段
3. 逐项收集用户输入
4. 确定输出格式（Word/PPT/Excel）
5. 利用 Codex 内置的文档/演示文稿/电子表格能力生成真实 Office 文件
6. ：统一字体、表格边框、对齐标准
7. 文件保存到 `outputs/`，告知用户路径

### 模式四：查看模板列表

用户说"有哪些模板"：

1. 读取 `templates/index.md`
2. 输出模板清单
