# 投资人项目 — 全局规则

## 目录结构分层

```
投资人/
├── skills/          ← [技能层] 所有 Codex Skill
├── data/            ← [数据层] 持久化数据（companies/sectors/files/templates）
├── tools/           ← [工具层] 辅助脚本（init/archive）
├── docs/            ← [文档层] 设计文档与实施计划
├── archive/         ← [归档层] 历史版本快照（vX.Y.Z/）
├── outputs/         ← [产出层] 生成的文件
├── AGENTS.md        ← 本文件（全局规则）
├── README.md
└── CHANGELOG.md
```

## 文件命名

- `skills/` 下的目录不加 `investor-` 前缀（上下文已明确），直接使用功能名：
  - ✅ `skills/workbench/`
  - ✅ `skills/sector-analysis/`
  - ❌ `skills/investor-workbench/`
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

调用 agent-reach 时必须写出实际的 Exa 搜索命令，不能只写"使用 agent-reach 搜索"。

## 外部依赖

本项目的 3 个 skill（sector-analysis / research-digest / deal-sourcing）依赖以下外部 skill：

| 外部 skill | 用途 | 安装方式（init.sh 自动完成） |
|-----------|------|---------------------------|
| agent-reach | 互联网数据搜索（Exa / 网页 / GitHub 等） | `git clone https://github.com/Panniantong/Agent-Reach.git` → skills 目录 |
| markitdown | 文件转 MD（PDF/Word/PPT/Excel） | `https://github.com/microsoft/markitdown`（init.sh 自动安装 skill 封装） |

未安装时 `[skill:agent-reach]` 和 `[skill:markitdown]` 无法生效。init.sh 会自动安装。

## 变更影响矩阵

任何修改操作，对照下表检查需要同步更新的文件：

### 新增或删除 skill

| 需要更新的文件 | 操作 |
|--------------|------|
| `skills/[skill-name]/` | 新建或删除整个目录 |
| `skills/workbench/SKILL.md` | 菜单项 + 路由规则 |
| `tools/init.sh` | `SKILL_LIST` 列表 |
| `tools/archive.sh` | `for dir in` 循环 |
| `README.md` | 技能一览表 |
| `CHANGELOG.md` | 加记录 |
| `AGENTS.md` | 如有外部依赖，更新依赖清单 |

前置动作：`bash tools/archive.sh vX.Y.Z`

### 修改 skill 内部逻辑

| 需要更新的文件 | 操作 |
|--------------|------|
| `skills/[name]/SKILL.md` | 直接覆盖（不留旧内容） |
| `skills/[name]/references/*.md` | 如有引用规则变化同步更新 |
| 其它 skill 的 SKILL.md | 如果接口/路径变了，涉及交叉引用的都要改 |

### 修改目录结构或路径

| 需要更新的文件 | 检查点 |
|--------------|--------|
| 所有 `skills/*/SKILL.md` 中的路径引用 | `../../data/` 是否正确 |
| 所有 `skills/*/references/*.md` 中的路径引用 | `../../../data/` 是否正确 |
| `tools/init.sh` 和 `tools/archive.sh` 中的路径 | `$PROJECT_DIR/skills/` 等 |
| `AGENTS.md` | 目录结构分层描述 |
| `README.md` | 目录树 |

### 修改数据来源或外部调用

| 需要更新的文件 | 检查点 |
|--------------|--------|
| 所有引用该来源的 `SKILL.md` | 搜索 `[skill:xxx]` 或 `[来源: xxx]` |
| `AGENTS.md` | 依赖清单 + 数据来源规范 |
| `tools/init.sh` | 如需新增/删除安装步骤 |

### 新增文件分类

| 需要更新的文件 | 操作 |
|--------------|------|
| `data/files/[新分类]/` | 新建目录 |
| `skills/research-digest/references/content-analyzer.md` | 添加识别特征 |
| `skills/research-digest/references/file-processor.md` | 添加归档路径 |

### 通用规则

1. **改前先归档**：`bash tools/archive.sh vX.Y.Z`
2. **改完搜一遍**：`grep -rn "[关键词]" skills/ tools/ AGENTS.md` 确认无遗漏引用
3. **更新 CHANGELOG.md**：一行记录
4. **确认 SKILL.md 无旧版残留**：不允许写新旧对比、升级记录

## 文档纪律

1. **去旧保新** — 每个 SKILL.md / reference 文件只保留当前最新执行方案，不包含旧版流程、新旧对比、迭代记录
2. **改前归档** — 更新任何 skill 前，先运行 `bash tools/archive.sh vX.Y.Z`
3. **版本记录** — 每次归档后，在 `CHANGELOG.md` 添加一行记录
4. **版本号格式** — `v主版本.次版本.修订`（如 v1.1.0、v2.0.0）
5. **历史查询** — 所有旧版本完整保留在 `archive/` 目录下

## 初始化流程

用户首次部署说"初始化" → workbench 编排 → 执行 `bash tools/init.sh`
