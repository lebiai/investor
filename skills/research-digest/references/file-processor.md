# 文件处理规范

## 支持的输入类型

| 类型 | 处理方式 |
|------|---------|
| PDF 文件 | 微软格式转换 API → MD |
| Word (.docx) | 微软格式转换 API → MD |
| PPT (.pptx) | 微软格式转换 API → MD |
| Excel (.xlsx) | 微软格式转换 API → MD |
| 网页链接 | [skill:agent-reach] 获取内容 → Markdown |
| 纯文本 | 直接引用 |
| 图片 | OCR 提取文字（如需要） |

## 归档分类

内容分析完成后，按识别结果归入对应分类。完整分类清单见 `content-analyzer.md`。

## 元数据记录 — 追加规则

每个文件处理前，先记录到 `data/file-index.md`。

**操作方式：追加** — 在已有 table 末尾新增一行，不覆盖原有内容。

| 上传时间 | 文件名 | 文件类型 | 分类 | 所属项目 | 路径 |
|---------|--------|---------|------|---------|------|

- 上传时间：当前系统时间
- 文件名：原始文件名
- 文件类型：按扩展名判断
- 分类：内容分析时识别
- 所属项目：AI 根据文件内容推断
- 路径：`files/[分类]/YYYY-MM/文件名.md`

## 原始文件归档

- 原始文件复制到 `data/files/original/[分类]/`
- 命名规则：`YYYYMMDD_原始文件名`

## MD 持久化

- 转换后的 MD 文件保存到 `data/files/[分类]/YYYY-MM/`
- 命名规则：`YYYYMMDD_原始文件名(去掉扩展名).md`
- 文件头部加 YAML header（参考 `docs/DATA-STANDARD.md` §3.5）：
  ```markdown
  ---
  type: file
  created: {日期}
  tags: [{分类}]
  source: research-digest
  original: {原始文件名}
  classification: {分类}
  ---
  ```
