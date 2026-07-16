# 数据标准 — 全项目统一规范
> 新增知识库类型前，先在 `data/registry.md` 注册。


> 所有写入 data/ 和 personal-growth/ 的数据必须遵守此规范。
> 目的：每条记录自包含，未来迁移到向量库时无需上下文。

## 1. 核心原则

1. **YAML header 先行** — 每个文件头部有 `---` 包裹的元信息
2. **自包含** — 单条记录脱离文件上下文也能理解含义
3. **表格式索引** — 索引文件统一使用 Markdown table，每行一条记录
4. **追加不覆盖** — 所有写入操作在已有 table 末尾追加，不覆盖、不编辑已有行

---

## 2. 索引类文件（table 格式）

### 2.1 `data/index.md` — 知识库总索引

由 sector-analysis、deal-sourcing、research-digest 在写入时追加。

```markdown
# 知识库索引

> 自动更新，勿手动编辑。每次写入时追加新行。

## 赛道索引

| 赛道 | 首次分析 | 最近更新 | 类型 | 来源 | 文件路径 |
|------|---------|---------|------|------|---------|
| 固态电池 | 2026-07-16 | 2026-07-16 | sector | sector-analysis | data/sectors/固态电池.md |

## 公司索引

| 公司 | 建档时间 | 类型 | 来源 | 标签 | 文件路径 |
|------|---------|------|------|------|---------|
| 宁德时代 | 2026-07-16 | company | sector-analysis | 固态电池, 电池 | data/companies/宁德时代.md |
```

### 2.2 `data/file-index.md` — 文件索引

由 research-digest 在每次文件处理时追加。

```markdown
| 上传时间 | 文件名 | 类型 | 文件类型 | 分类 | 标签 | 所属项目 | MD 路径 | 来源 |
|---------|--------|------|---------|------|------|---------|--------|------|
| 2026-07-16 | XX研报.pdf | file | pdf | 研报 | 固态电池 | 项目A | data/files/研报/2026-07/20260716_XX研报.md | research-digest |
```

### 2.3 `data/deals/index.md` — 审阅索引

由 deal-review 在每次审阅后追加。

```markdown
| 审阅日期 | 项目名 | 类型 | 文档类型 | 赛道 | 推荐评级 | 标签 | 来源 | 文件路径 |
|---------|-------|------|---------|------|---------|------|------|---------|
| 2026-07-16 | XX科技 | deal-review | BP | 固态电池 | ⭐⭐ | 早期, 硬科技 | deal-review | data/deals/20260716_XX科技.md |
```

### 2.4 `data/templates/index.md` — 模板索引

由 template-prod 在每次保存模板时追加。

```markdown
| 模板名 | 类型 | 格式 | 用途 | 上传日期 | 来源 | 原始文件 | 解析文件 |
|--------|------|------|------|---------|------|---------|---------|
| 会议纪要 | template | Word | 周会纪要 | 2026-07-16 | template-prod | data/templates/original/会议纪要.docx | data/templates/parsed/会议纪要.md |
```

### 2.5 `data/watch/checklist.md` — 盯盘清单

由 watch 在"关注"和"查询"时更新。

```markdown
| 条目 | 类型 | 关注时间 | 上次检查 | 最后变化摘要 | 来源 |
|------|------|---------|---------|------------|------|
| 固态电池 | sector | 2026-07-16 | 2026-07-16 | — | watch |
| 宁德时代 | company | 2026-07-16 | 2026-07-16 | 发布新产品 | watch |
```

### 2.6 `data/deals/patterns.md` — 信号模式库

由 deal-review 在每次发现新模式时追加。**不手动编辑。**

```markdown
## 🔴 陷阱模式

| 模式名 | 特征 | 严重度 | 置信度锚点 | 追问方式 | 首现日期 | 最近出现 | 出现次数 | 类型 | 来源 |
|-------|------|--------|-----------|---------|---------|---------|---------|------|------|
| 市场规模倒推 | 无底层计算的百分比渗透率 | 致命 | 无第三方引用 | 这个数据从哪来 | 2026-07-16 | 2026-07-16 | 1 | pattern | deal-review |
```

---


### 2.7 `data/portfolio/index.md` — 组合公司索引

由 portfolio-tracker 在每次新增/更新组合公司时追加。

```markdown
| 公司名 | 投资时间 | 轮次 | 投资金额 | 股权占比 | 赛道 | 最新状态 | 最近更新 | 文件路径 |
|--------|---------|------|---------|---------|------|---------|---------|---------|
| XX科技 | 2026-07 | A轮 | ¥1000万 | 15% | 固态电池 | active | 2026-07-16 | data/portfolio/XX科技.md |
```

### 2.8 `data/portfolio/alerts.md` — 预警索引（内联表）

由 portfolio-tracker 在每次新增/关闭预警时追加。

```markdown
| 创建时间 | 等级 | 公司 | 预警类型 | 摘要 | 状态 | 关闭时间 |
|---------|------|------|---------|------|------|---------|
| 2026-07-16 | 🔴 | XX科技 | 现金流枯竭 | 现金流仅剩2个月 | active | — |
```

### 2.9 `data/meetings/index.md` — 会议纪要索引

由 meeting-notes 在每次创建纪要时追加。

```markdown
| 日期 | 标题 | 类型 | 关联公司/项目 | 标签 | 文件路径 |
|------|------|------|-------------|------|---------|
| 2026-07-16 | XX公司季度会 | 投后管理 | XX公司 | 投后, 里程碑 | data/meetings/20260716_XX公司季度会.md |
```

### 2.10 `data/contacts/index.md` — 联系人索引

由 contact-crm 在每次新增或更新联系人时追加。

```markdown
| 姓名 | 公司 | 职位 | 角色 | 行业 | 最近互动 | 介绍人 | 状态 | 文件路径 |
|------|------|------|------|------|---------|-------|------|---------|
| 张三 | XX科技 | CEO | founder | 固态电池 | 2026-07-15 | 李四 | complete | data/contacts/张三.md |
```
## 3. 内容类文件（YAML header + 正文）

### 3.1 `data/sectors/[赛道名].md` — 赛道档案

```markdown
---
type: sector
created: 2026-07-16
updated: 2026-07-16
tags: [固态电池, 新能源]
source: sector-analysis
---
# 【赛道分析】固态电池

## 执行摘要
...
```

### 3.2 `data/companies/[公司名].md` — 公司档案

```markdown
---
type: company
created: 2026-07-16
updated: 2026-07-16
tags: [固态电池, 电池龙头]
source: sector-analysis
---
# 【公司档案】宁德时代
...
```

### 3.3 `data/deals/[YYYYMMDD]_[项目名].md` — 审阅记录

```markdown
---
type: deal-review
created: 2026-07-16
tags: [固态电池, 早期, BP]
source: deal-review
rating: ⭐⭐
---
# 【审阅】XX科技 — 固态电池电解质
...
```

### 3.4 `data/watch/snapshots/[条目]_YYYYMMDD.md` — 盯盘快照

```markdown
---
type: watch-snapshot
created: 2026-07-16
tags: [固态电池]
source: watch
---
# 【快照】固态电池 — 2026-07-16
...
```

### 3.5 `data/files/[分类]/YYYY-MM/[日期]_[文件名].md` — 转换后文件

```markdown
---
type: file
created: 2026-07-16
tags: [固态电池, 研报]
source: research-digest
original: XX研报.pdf
classification: 研报
---
# XX研报
...
```

### 3.6 `data/templates/parsed/[模板名].md` — 模板解析文件

```markdown
---
type: template-parsed
created: 2026-07-16
tags: [会议纪要]
source: template-prod
original: data/templates/original/会议纪要.docx
---
# 模板: 会议纪要
...
```

---


### 3.7 `data/portfolio/[公司名].md` — 投后公司档案

```yaml
---
type: portfolio-company
created: 2026-07-16
updated: 2026-07-16
tags: [固态电池, A轮, 2026]
source: portfolio-tracker
investment:
  round: A轮
  amount: ¥XXXX万
  ownership: X%
  date: 2026-07
status: active
---
# 【投后】XX公司
...
```

### 3.8 `data/portfolio/[公司名].md`（内联 timeline 表）— 里程碑记录

里程碑记录在公司档案文件的 timeline 表中，不单独成文件。

```markdown
## 里程碑时间线
| 里程碑 | 预期完成 | 实际完成 | 状态 | 备注 |
|--------|---------|---------|------|------|
| 产品上线 | 2026-Q2 | 2026-06 | ✅ | 按时完成 |
```

### 3.9 `data/portfolio/[公司名]_board_[日期].md` — 董事会记录

```yaml
---
type: board-meeting
created: 2026-07-16
tags: [XX公司, 董事会]
source: portfolio-tracker
company: XX公司
meeting-date: 2026-07-20
---
# 董事会 — XX公司 | 2026-07-20
...
```

### 3.10 `data/portfolio/[公司名]_exit.md` — 退出记录

```yaml
---
type: exit-record
created: 2026-07-16
tags: [XX公司, IPO, 退出]
source: portfolio-tracker
company: XX公司
exit-type: IPO
status: planning
---
# 退出路径 — XX公司
...
```


### 3.11 `data/meetings/[日期]_[标题].md` — 会议纪要

```yaml
---
type: meeting
created: 2026-07-16
tags: [XX公司, 投后管理]
source: meeting-notes
meeting-type: 投后管理
company: XX公司
---
# 会议纪要 — XX公司季度会 | 2026-07-16
...
```

### 3.12 内联于会议纪要 — 行动项

行动项记录在会议纪要文件末尾的 table 中，不单独成文件。

```markdown
## 待办事项
| 负责人 | 事项 | 截止日期 | 状态 |
|-------|------|---------|------|
| 张三 | 跟进融资进展 | 2026-08-01 | 待办 |
```

### 3.13 `data/contacts/[姓名].md` — 联系人档案

```yaml
---
type: contact
created: 2026-07-16
updated: 2026-07-16
tags: [固态电池, 专家]
source: contact-crm
name: 张三
company: XX科技
title: CEO
role: founder
status: complete
---
# 【联系人】张三 — XX科技 CEO
...
```

### 3.14 内联于联系人档案 — 互动记录

互动记录记录在联系人档案文件末尾的 table 中，不单独成文件。

```markdown
## 互动记录
| 日期 | 类型 | 摘要 | 关联 | 备注 |
|------|------|------|------|------|
| 2026-07-15 | 路演 | 路演上认识，聊了技术路线 | deals/XX科技.md | 逻辑清晰 |
```

### 3.15 内联于联系人档案 — 关系网络

```markdown
## 关系网络
- 介绍人：李四（XX资本）
- 共同联系人：王五（FA）
```
## 4. personal-growth 类文件（统一 timeline 表格）

### 4.1 `vault/timeline.md` — 洞察记录

```markdown
# 洞察时间线

> 由 agent 在每次蒸馏后自动追加。每条记录自包含，含类型标签。

| 日期 | 类型 | 标签 | 摘要 | 来源 | 正文链接 |
|------|------|------|------|------|---------|
| 2026-W29 | pattern | 固态电池, 赛道 | 固态电池的技术路线和我想的不一样 | 赛道分析追问 | vault/entries/2026W29-001.md |
| 2026-W29 | lesson | BP, 审阅 | 主动暴露弱点的创始人信号值得关注 | deal-review追问 | vault/entries/2026W29-002.md |
```

**类型枚举：** pattern（模式）/ lesson（教训）/ principle（原则）/ cross-link（跨领域连接）/ insight（洞察）

### 4.2 `inbox/timeline.md` — 碎片临时区

```markdown
| 日期 | 类型 | 标签 | 原文 | 来源上下文 | 状态 |
|------|------|------|------|-----------|------|
| 2026-W29-周四 | pattern | 固态电池 | 发现XX公司和我想的完全不一样 | sector-analysis 追问回答 | pending |
```

**状态枚举：** pending（待蒸馏）/ distilled（已蒸馏）

### 4.3 `context/timeline.md` — 自动捕获区（用户无感知）

```markdown
| 日期 | 类型 | 标签 | 摘要 | 来源 |
|------|------|------|------|------|
| 2026-W29-周四 | analysis | 固态电池 | 用户分析了固态电池赛道 | 工作流自动捕获 |
| 2026-W29-周四 | review | XX科技 | 用户审阅了XX科技的BP | 工作流自动捕获 |
```

**类型枚举：** analysis（赛道分析）/ review（项目审阅）/ scan（扫描）/ read（阅读）/ write（写作）

### 4.4 `pulse/weekly/[年份]/W周.md` — 周报

```markdown
---
type: weekly-pulse
created: 2026-W29
tags: [个人成长]
source: personal-growth
---
# 周回顾 — 2026-W29

## 1. 这周有没有让我觉得"之前想错了"的 moment？
...

## 2. 这周注意到的 1 个重复模式
...

## 3. 这周做的决定里，哪个信息量最大？
...

## 4. 下周想验证的 1 个假设
...
```

---

## 5. 字段汇总

| 字段 | 必需 | 所有类型通用 | 说明 |
|------|------|------------|------|
| `type` | ✅ | ✅ | 数据类型枚举：sector / company / deal-review / file / pattern / template / template-parsed / watch-snapshot / insight / weekly-pulse 等 |
| `created` | ✅ | ✅ | ISO 日期或周格式 |
| `updated` | — | 部分 | sector/company 持久档案需要 |
| `tags` | ✅ | ✅ | 数组，至少 1 个 |
| `source` | ✅ | ✅ | 写入该记录的 skill 或系统名 |
| `rating` | — | deal-review 专用 | ⭐⭐⭐/⭐⭐/⭐/暂缓/放弃 |

---

## 6. 迁移到向量库示例

```python
# 伪代码 — 读取所有 content 类型文件
for path in glob("data/**/*.md"):
    with open(path) as f:
        header, body = parse_yaml_header(f)
        if header:
            record = {
                "id": f"{header['type']}/{path}",
                "text": body,
                "metadata": header,
            }
            vector_db.insert(record)

# 读取所有 index 类型的 table
for path in glob("data/**/*.md"):
    with open(path) as f:
        table = parse_markdown_table(f)
        for row in table:
            if row.get("文件路径"):
                # 已经有 content 文件，跳过
                continue
            # 纯索引表数据
            record = {
                "id": f"{path}/{row[0]}",
                "text": str(row),
                "metadata": {"type": infer_type(path), **row},
            }
            vector_db.insert(record)
```
