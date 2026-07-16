# 模板生成逻辑

## 触发场景

用户说：
- "用[模板名]生成一份"
- "套[模板名]模板"
- "按会议纪要模板帮我写一份"

## 前置条件

模板已在 `knowledge-base/templates/parsed/` 中有解析文件，
原始文件在 `knowledge-base/templates/original/` 中。

## 生成流程

### Step 1: 查找模板

1. 查 `knowledge-base/templates/index.md` → 匹配模板名
2. 未找到 → "模板库中没有[模板名]，已有模板：[列表]"
3. 找到 → 读取 `knowledge-base/templates/parsed/模板名.md`

### Step 2: 收集填写内容

根据模板解析文件中的"填写字段"逐项询问用户：

```
模板 [模板名] 需要以下信息：
1. 会议主题 → [用户输入]
2. 会议日期 → [用户输入]
3. 参会人员 → [用户输入]
...
一次告诉我，或我逐个问
```

如果用户一次性说全，直接解析使用；否则逐个追问。

### Step 3: 确定输出格式

根据模板解析文件中的格式信息决定输出类型：

| 模板格式 | 输出类型 | 使用的内置能力 |
|----------|---------|--------------|
| Word (.docx) | .docx 文件 | Codex Documents skill / python-docx |
| PowerPoint (.pptx) | .pptx 文件 | Codex Presentations skill / python-pptx |
| Excel (.xlsx) | .xlsx 文件 | Codex Spreadsheets skill / openpyxl |

### Step 4: 生成文件

#### 方式A：基于原始模板文件（推荐）

如果 `knowledge-base/templates/original/` 中有原始模板文件：

1. 复制原始模板文件到输出目录
2. 使用内置的文档处理能力打开副本
3. 将收集到的字段值填入对应位置（替换 `[字段名]` 或 `${字段名}` 占位符）
4. 输出最终文件

格式继承自原始模板文件。说明原始模板已有的样式、字体、布局均自动保留。

#### 方式B：基于解析文件结构创建

如果没有原始模板文件，根据解析文件中的结构描述，使用 Codex 内置的 Document / Presentation / Spreadsheets skill 创建文件。

### Step 5: 交付

输出文件保存到项目 `outputs/` 目录，命名规则：

```
outputs/[模板名]_YYYYMMDD_HHMMSS.docx
```

告知用户文件路径，让用户可以直接打开使用。
