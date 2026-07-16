---
name: investor-template-prod
version: 1.1.0
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
2. 查 `data/templates/index.md` → 检查同名模板是否已存在
   - 已存在 → "模板[模板名]已存在，覆盖将丢失原有配置，是否确认覆盖？"
   - 用户确认后继续，否则中止
3. 加载 `references/template-processor.md` — 模式A
4. 调用 markitdown CLI 将文件转为 Markdown（markitdown <输入文件> -o <输出文件>），然后分析结构
5. 原始文件 → `data/templates/original/`，解析文件 → `data/templates/parsed/`
6. 更新 `data/templates/index.md`（格式参考 `docs/DATA-STANDARD.md` §2.4）

### 模式二：从成品文档提取模板

用户上传已填好的文档并说"把这个模板化"：

1. 告知用户："正在分析文档结构，准备提取模板..."
2. 加载 `references/template-processor.md` — 模式B
3. 调用 markitdown CLI 将文件转为 Markdown（markitdown <输入文件> -o <输出文件>）
4. 自动识别：固定结构 vs 变量字段
5. 输出字段清单让用户确认
6. 确认后保存模板；如同名已存在 → 提示覆盖风险
7. 输出："模板 [名称] 已就绪，说'用[名称]生成一份'即可使用"

### 模式三：按模板生成 Office 文件 ⭐

用户说"用[模板名]生成一份"，搜索流程参考 `docs/SEARCH-PROTOCOL.md`：

1. 加载 `references/template-generator.md`
2. **rg 全文搜索（Phase 1）：** `rg -i "{模板名}" data/templates/parsed/ -l --md`
   - 匹配到 → 读取解析文件获取结构和字段
3. **索引表搜索（Phase 2）：** 如 rg 未匹配，查 `data/templates/index.md`
   - 索引为空 → "📭 模板库为空，请先上传模板"
   - 未找到匹配 → "模板库中没有[模板名]，已有模板：[列表]"
3. 找到后读取解析文件获取结构和字段
4. 逐项收集用户输入
5. 确定输出格式（Word/PPT/Excel）
6. 确保 `outputs/` 目录存在，不存在则自动创建
7. 利用 Codex 内置的文档/演示文稿/电子表格能力生成真实 Office 文件
8. 文件保存到 `outputs/`，自动打开文件供用户查看

### 模式四：查看模板列表

用户说"有哪些模板"：

1. 读取 `data/templates/index.md`
2. 如索引为空 → "📭 模板库当前为空，您可以：
   - 上传空白模板说'保存模板'
   - 上传成品文档说'把这个模板化'"
3. 如有模板 → 输出模板清单
