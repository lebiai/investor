# 数据类型注册表

> 每新增一种知识库类型，在此注册。迁移脚本读取此文件即可知道所有数据的位置和格式。
> 字段标准见 `docs/DATA-STANDARD.md`。

## 注册规范

新增知识库类型的流程：

1. 在下方 `## 已注册类型` 表追加一行
2. 创建对应的索引文件（如已有则不重复创建）
3. 更新各 SKILL.md 的写入规则引用新索引

---

## 已注册类型

| 类型标识 | 所属项目 | 存储路径 | 索引文件 | 写入者 | 格式参考（DATA-STANDARD.md） |
|---------|---------|---------|---------|-------|---------------------------|
| sector | investor | data/sectors/{name}.md | data/index.md（赛道表） | sector-analysis, research-digest | §3.1 + §2.1 |
| company | investor | data/companies/{name}.md | data/index.md（公司表） | sector-analysis, deal-sourcing, research-digest | §3.2 + §2.1 |
| deal-review | investor | data/deals/{date}_{name}.md | data/deals/index.md | deal-review | §3.3 + §2.3 |
| pattern | investor | data/deals/patterns.md | data/deals/patterns.md | deal-review | §2.6 |
| file | investor | data/files/{分类}/{YYYY-MM}/{date}_{name}.md | data/file-index.md | research-digest | §3.5 + §2.2 |
| watch-snapshot | investor | data/watch/snapshots/{name}_{date}.md | data/watch/checklist.md | watch | §3.4 + §2.5 |
| template | investor | data/templates/original/{name}.{ext} | data/templates/index.md | template-prod | §2.4 |
| template-parsed | investor | data/templates/parsed/{name}.md | data/templates/index.md | template-prod | §3.6 + §2.4 |
| insight | personal-growth | personal-growth/vault/timeline.md | personal-growth/vault/timeline.md（内联） | personal-growth 系统 | §4.1 |
| context | personal-growth | personal-growth/context/timeline.md | personal-growth/context/timeline.md（内联） | 自动捕获 | §4.3 |
| inbox-item | personal-growth | personal-growth/inbox/timeline.md | personal-growth/inbox/timeline.md（内联） | 捕获阶段 | §4.2 |
| weekly-pulse | personal-growth | personal-growth/pulse/weekly/{year}/W{week}.md | personal-growth/pulse/（目录索引） | 蒸馏阶段 | §4.4 |
| portfolio-company | investor | data/portfolio/{name}.md | data/portfolio/index.md | portfolio-tracker | §3.7 + §2.7 |
| milestone | investor | data/portfolio/{company}.md（内联 timeline 表） | 内联于公司档案 | portfolio-tracker | §3.8 |
| portfolio-alert | investor | data/portfolio/alerts.md | data/portfolio/alerts.md（内联） | portfolio-tracker | §2.8 |
| board-meeting | investor | data/portfolio/{company}_board_{date}.md | data/portfolio/index.md（同表扩展） | portfolio-tracker | §3.9 |
| exit-record | investor | data/portfolio/{name}_exit.md | data/portfolio/index.md（同表扩展） | portfolio-tracker | §3.10 |

| meeting | investor | data/meetings/{date}_{title}.md | data/meetings/index.md | meeting-notes | §3.11 + §2.9 |
| action-item | investor | 内联于会议纪要文件 | data/meetings/index.md（同表扩展） | meeting-notes | §3.12 |
---

| contact | investor | data/contacts/{name}.md | data/contacts/index.md | contact-crm | §3.13 + §2.10 |
## 注册流程

当新增一种知识库类型时：

```
Step 1: 在本表追加一行
Step 2: 在 DATA-STANDARD.md 添加该类型的格式定义（YAML header ➕ table 列）
Step 3: 创建索引文件（如引用已有索引则跳过）
Step 4: 更新写入该类型的 SKILL.md，确保写入时使用标准格式
```
