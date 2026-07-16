# 模板库

由 investor-template-prod 管理。每上传一个模板，自动完成：
1. 原始文件 → `original/`
2. 结构解析 → `parsed/`
3. 索引记录 → `index.md`

## 目录结构

```
templates/
├── README.md          ← 本文件
├── index.md           ← 模板索引（自动更新）
├── original/          ← 原始模板文件（.docx/.xlsx/.pptx）
└── parsed/            ← 结构解析文件（.md）
```
