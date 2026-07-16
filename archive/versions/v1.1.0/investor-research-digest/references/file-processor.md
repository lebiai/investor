# 文件处理规范

## 支持的输入类型

| 类型 | 处理方式 |
|------|---------|
| PDF 文件 | 微软格式转换 API → MD |
| Word (.docx) | 微软格式转换 API → MD |
| PPT (.pptx) | 微软格式转换 API → MD |
| Excel (.xlsx) | 微软格式转换 API → MD |
| 网页链接 | 爬取内容 → Markdown |
| 纯文本 | 直接引用 |
| 图片 | OCR 提取文字（如需要） |

## 元数据记录

每个文件处理前，先记录到 `knowledge-base/file-index.md`：

| 上传时间 | 文件名 | 文件类型 | 所属项目 | MD路径 |
|---------|--------|---------|---------|--------|

- 上传时间：当前系统时间
- 文件名：原始文件名
- 文件类型：按扩展名判断
- 所属项目：AI 根据文件内容推断
- MD路径：`files/YYYY-MM/文件名.md`

## 原始文件归档

- 原始文件复制到 `knowledge-base/files/original/`
- 命名规则：`YYYYMMDD_原始文件名`

## MD 持久化

- 转换后的 MD 文件保存到 `knowledge-base/files/YYYY-MM/`
- 命名规则：`YYYYMMDD_原始文件名(去掉扩展名).md`
