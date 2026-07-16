
> **数据标准参考：** `docs/DATA-STANDARD.md` — 所有 data/ 和 personal-growth/ 的写入必须遵循。
> 每条记录自包含，含 YAML header 或 timeline table 格式。
>
> **数据类型注册表：** `data/registry.md` — 新增知识库类型前必须在此注册。

> **搜索协议：** `docs/SEARCH-PROTOCOL.md` — 所有 skill 搜索知识库时统一遵守。先 rg 全文搜索、再用索引兜底。
>
> **搜索源配置：** `docs/SEARCH-SOURCES.md` — 各信息类型的首选目标源定义。使用 agent-reach 搜索时按信息类型匹配目标源。


> **操作规范（Agent 专用）：** `docs/CODING.md` — 目标态驱动、批次执行、文件重写优先、中间态清零。
> 本项目的 Agent 必须遵守。

> **个人成长系统：** `personal-growth/AGENTS.md` — 三层捕获（自动记录 + 收尾追问 + 每周蒸馏）。独立模块，不依赖项目其他部分。


# 投资人项目 — 全局规则

## 目录结构分层

```
投资人/
├── skills/          ← [技能层] 所有 Codex Skill
├── data/            ← [数据层] 持久化数据（companies/sectors/files/templates/deals/portfolio）
├── tools/           ← [工具层] 辅助脚本（init/archive）
├── docs/            ← [文档层] 设计文档与实施计划
├── archive/         ← [归档层] 历史版本快照（vX.Y.Z/）
├── outputs/         ← [产出层] 生成的文件
├── personal-growth/ ← [独立模块] 个人成长系统（三层捕获）
├── AGENTS.md        ← 本文件（全局规则）
├── README.md
└── CHANGELOG.md
```

## 文件命名

- `skills/` 下的目录不加 `investor-` 前缀（上下文已明确），直接使用功能名：
  - ✅ `skills/workbench/`
  - ✅ `skills/sector-analysis/`
  - ❌ `skills/workbench/`
- 引用路径以项目根目录为基准，不用绝对路径

## 跨路径引用

| 源文件 | 目标 | 相对路径 |
|--------|------|---------|
| `skills/*/SKILL.md` | `data/` | `../../data/` |
| `skills/*/references/*.md` | `data/` | `../../../data/` |
| `tools/*.sh` | `data/` | `../data/` |

## 数据来源规范

每个 skill 在 SKILL.md 中必须明确标注数据来源，只有两类：

| 来源 | 标签 | 说明 | 工具 |
|------|------|------|------|
| agent-reach 搜索 | `[来源: agent-reach]` | 所有互联网实时数据 | 执行  |
| 知识库 | `[来源: 知识库]` | 本地 data/ 目录下的持久化数据 | 直接读取 data/ 下的文件 |

涉及外部数据的 skill 必须在工作流每个阶段标注 `[来源: ①agent-reach搜索]` 或 `[来源: ②知识库]`。

调用 agent-reach 时必须写出具体的搜索目标，不能只写"使用 agent-reach 搜索"。



## 外部依赖

本项目依赖以下外部 skill：

| 外部 skill | 用途 | 安装方式（init.sh 自动完成） |
|-----------|------|---------------------------|
| agent-reach | 互联网数据搜索（网页 / GitHub / B站 等） | `git clone https://github.com/Panniantong/Agent-Reach.git` → skills 目录 |
| markitdown | 文件转 MD（PDF/Word/PPT/Excel） | `pip install markitdown[pdf,pptx,docx,xlsx]`（Python 工具库，由 init 步骤安装） |

未安装时 `[skill:agent-reach]` 无法生效，init.sh 会自动安装。
markitdown 为 Python 工具库，通过 `pip install markitdown[pdf,pptx,docx,xlsx]` 安装后可直接调用 markitdown CLI。

## 技能间接口契约

以下契约定义了跨 skill 调用的数据交换规范，确保改动一个 skill 不影响其他依赖方。

### research-digest → deal-review

research-digest 的承诺：
- 文件处理完成后，将元数据记录在 `data/file-index.md` 中
- 转换后的 MD 路径格式：`data/files/[分类]/YYYY-MM/YYYYMMDD_文件名.md`
- 输出格式为标准 Markdown，含文件类型识别信息

deal-review 的依赖：
- 不自行处理文件格式转换，完全委托 research-digest
- 仅在 research-digest 处理完成后才启动审阅分析
- 审阅结果写入 `data/deals/`，不写回 research-digest 管理区域

### deal-review → deal-sourcing

deal-review 的承诺：
- 审阅完成后，更新 `data/companies/` 中对应公司档案
- 新发现的潜在标的写入 `data/deals/` 供 deal-sourcing 引用

deal-sourcing 的依赖：
- 读取 `data/deals/` 作为项目发现渠道之一
- 不修改 deal-review 的输出文件

### deal-sourcing → watch

deal-sourcing 的承诺：
- 扫描完成后，自动将领域同步到 watch checklist
- 首次扫描写入 initial snapshot 到 `data/watch/snapshots/`
- 不修改或删除 watch 已存在的条目

watch 的依赖：
- 接受 deal-sourcing 写入的 checklist 行和 snapshot 文件
- 增量比对逻辑保持独立，不依赖 deal-sourcing
- 如用户后续通过 watch 查询该领域，正常执行增量比对

### meeting-notes → contact-crm

meeting-notes 的承诺：
- 会议纪要完成后，输出中的参会方和人名供 contact-crm 捕获
- 不直接写入 data/contacts/

contact-crm 的依赖：
- 通过 auto-capture 规则从 meeting-notes 输出中提取新联系人
- 自动创建 stub 档案，状态标记为 stub
- 用户后续可通过 contact-crm 的 Phase 1 补充完整信息

### deal-review → content-prod (IC-memo)

deal-review 的承诺：
- 审阅完成后，输出完整的 Phase 1-9 数据供 content-prod 使用
- 不自行生成备忘录

content-prod 的依赖：
- Step 0 来源检测识别"备忘录""IC memo"触发词
- 读取 deal-review 输出数据的关键字段：
  - Layer 1（执行摘要）+ Phase 3（六角色评分）+ signal-library 管道
  - Phase 6（估值分析）+ Phase 7（尽调路线图）
- 自动按 IC-memo 模板填充各 section
- 缺失数据 → 标注"待补充：需先完成[具体 phase]"

### portfolio-tracker → research-digest

portfolio-tracker 的承诺：
- 上传的投后管理相关文件（董事会材料、财务报告等）委托 research-digest 处理
- 处理结果关联到 `data/portfolio/` 中对应公司档案

research-digest 的依赖：
- 文件处理时识别与投后管理相关的文件类型
- 在 `data/file-index.md` 中标记文件所属的组合公司
- 不修改 data/portfolio/ 目录

### deal-review → data/ 知识库

deal-review 的承诺：
- 审阅结果写入 `data/deals/[YYYYMMDD]_[项目名].md`
- 更新 `data/deals/index.md`（追加）
- 如发现新模式 → 追加到 `data/deals/patterns.md`
- 更新 `data/companies/` 对应档案
- 更新 `data/index.md`

## 变更影响矩阵

任何修改操作，对照下表检查需要同步更新的文件：

### 新增 skill

| 需要更新的文件 | 操作 |
|--------------|------|
| `skills/[skill-name]/` | 新建完整目录 |
| `skills/workbench/SKILL.md` | 菜单项 + 路由规则 |
| `tools/init.sh` | SKILL_LIST 增加 |
| `tools/archive.sh` | for dir 循环增加 |
| `README.md` | 技能一览表 |
| `CHANGELOG.md` | 按组件格式记录 |

前置动作：无需归档，新 skill 无旧版本

### 修改 skill 内部逻辑

1. 存档：`bash tools/archive.sh skill <技能名>`
2. 修改：直接覆盖（不留旧内容）
3. 升版本：在 SKILL.md YAML 中 `version:` 字段 +1
4. 更新 CHANGELOG.md：按组件格式记录
5. 检查：是否影响其它组件的交叉引用（data/ 写入格式、输出类型等）

### 修改工具脚本

工具脚本不存档，直接在 CHANGELOG 记录变更。
1. 修改：直接覆盖
2. 更新 CHANGELOG.md

### 修改目录结构或路径

1. 搜索所有 `skills/*/SKILL.md` → `../../data/` 是否正确
2. 搜索所有 `skills/*/references/*.md` → `../../../data/` 是否正确
3. 检查 `tools/init.sh` 和 `tools/archive.sh` 中的路径
4. 更新 AGENTS.md 目录结构描述
5. 更新 README.md 目录树

### 修改数据来源或外部调用

1. 搜索所有 `[skill:xxx]` 和 `[来源: xxx]` → 修改 SKILL.md
2. 更新 AGENTS.md 依赖清单 + 数据来源规范
3. 更新 tools/init.sh（如需新增/删除安装步骤）

### 新增文件分类

| 需要更新的文件 | 操作 |
|--------------|------|
| `data/files/[新分类]/` | 新建目录 |
| `skills/research-digest/references/content-analyzer.md` | 添加识别特征 |
| `skills/research-digest/references/file-processor.md` | 添加归档路径 |

### 通用规则

1. **改前先归档**：`bash tools/archive.sh <技能名>`（archive 只存技能版本）
2. **改完升版本**：version 字段 +1
3. **改完搜一遍**：`grep -rn "[关键词]" skills/ tools/ AGENTS.md` 确认无遗漏引用
4. **更新 CHANGELOG.md**：按组件格式一行记录
5. **确认 SKILL.md 无旧版残留**：不允许写新旧对比、升级记录

## 文档纪律 & 组件版本管理

### 组件独立版本化

每个组件（skill / tool / config）独立管理版本号，修改只升自己的。

| 组件类型 | 版本号位置 | 示例 |
|---------|-----------|------|
| skill | SKILL.md YAML 中的 version: | version: 1.1.0 |
| tool | 文件头部 VERSION: 注释 | VERSION: 1.1.0 |
| config | 手动指定 | AGENTS.md、README.md 无内嵌版本 |

### 版本号规则

- 主版本.次版本.修订（如 v1.0.0、v1.1.0）
- 新增能力 → 次版本+1（如 v1.0.0 → v1.1.0）
- Bug/逻辑修复 → 修订+1（如 v1.1.0 → v1.1.1）
- 重大重构 → 主版本+1（如 v1.1.0 → v2.0.0）

### 存档流程

archive 仅存档 skills/ 下的技能版本。修改前运行：

```
bash tools/archive.sh <技能名>    # 存档技能（自动读取 version 字段）
```

示例：

```
bash tools/archive.sh sector-analysis
# 然后修改 skills/sector-analysis/SKILL.md
# 修改后在 version 字段升版本
```


### 版本记录（CHANGELOG）

每次存档后，在 CHANGELOG.md 按组件格式添加一行记录：

```
## YYYY-MM-DD

### skills
- sector-analysis: v1.0.0 → v1.1.0（Phase 1 空状态提示）

### tools
- init.sh: v1.1.0（路径修复）
```

## 初始化流程

用户首次部署说"初始化" → workbench 编排 → 执行 `bash tools/init.sh`
