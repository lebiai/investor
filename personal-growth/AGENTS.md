# 个人成长系统 — 独立运行规则

> 本目录可整体移植到其他项目，不依赖 investor 体系。
> 数据标准见 `docs/DATA-STANDARD.md`，搜索协议见 `docs/SEARCH-PROTOCOL.md`。

## 核心模型：三层捕获

```
第0层：自动捕获 ── 工作对话中提取上下文，写入 context/timeline.md
第1层：收尾追问 ── 工作流完成后追加1行问题，回答存入 inbox/timeline.md
第2层：定期蒸馏 ── 每周一次，将 inbox 碎片整理成 vault 永久记录
```

## 第0层：自动捕获（完全无感知）

### 触发条件

用户在 investor 项目中进行以下操作时，自动记录到 context/timeline.md：

| 用户操作 | 类型 | 记录示例 |
|---------|------|---------|
| 赛道分析 | analysis | 用户分析了{赛道名}赛道 |
| 项目审阅 | review | 用户审阅了{项目名}的{文档类型} |
| 项目扫描 | scan | 用户扫描了{领域}的新项目 |
| 文件整理 | read | 用户处理了{文件名} |
| 内容写作 | write | 用户写了关于{话题}的{体裁} |

### 写入规则

```markdown
| 日期 | 类型 | 标签 | 摘要 | 来源 |
| 2026-W29 | analysis | 固态电池 | 用户分析了固态电池赛道 | sector-analysis 完成 |
```

- 每次工作完成时自动追加一行
- 用户不需要知道它的存在
- 不询问、不打断

## 第1层：收尾追问（低感知，每个工作流后1行）

### 通用规则

每个 investor skill 完成输出后，追加 1 行追问。用户可回可不回。

回答后自动处理：
- 存入 `inbox/timeline.md`，状态为 `pending`
- 追问本身 **不干扰工作流**，用户可以直接忽略

### 各 skill 追问模板

加载 `prompts/followup-ask.md`，根据当前完成的 skill 选择对应追问。

| skill | 追问内容 |
|-------|---------|
| sector-analysis | "分析完了。这次有没有什么让你意外的发现？" |
| deal-review | "审阅完了。这个BP里有没有没见过的新陷阱？" |
| deal-sourcing | "扫描完了。有没有让你眼前一亮的新标的？" |
| content-prod | "写完了。发现知识库里缺了什么信息？" |
| research-digest | "整理完了。有没有新旧信息矛盾的地方？" |
| watch | "对比完了。最大的变化是什么？" |
| 用户主动说"记录一下..." | 自动识别意图，追问："属于模式/教训/原则还是连接？" |

### 追问触发机制

```
工作流完成输出
  ↓
是否配置了追问？ → 否 → 结束
  ↓ 是
输出追问（1行）
  ↓
用户回答？ → 否 → 结束（不影响工作流）
  ↓ 是
解析回答 → 分类 → 写入 inbox/timeline.md
```

## 第2层：定期蒸馏（每周5分钟）

### 触发

加载 `prompts/weekly-ask.md`。

用户说"周报" 或 本周末首次打开项目时主动提醒。

### 流程

```
Step 1: 统计本周活动
  - context 记录数
  - inbox 未蒸馏条数
  - "你这周有N条碎片，要花5分钟整理吗？"

Step 2: 用户确认后，逐条引导
  - 从 inbox 读取 pending 条目
  - 每一条引导用户：摘要 → 标签 → 关联性
  - 完成后逐条移动：inbox(distilled) → vault(timeline.md)

Step 3: 输出周报
  加载 prompts/weekly-ask.md 的 4 个问题
  逐一回答后：输出 pulse/weekly/{year}/W{week}.md

Step 4: 清空 inbox
  - 已蒸馏的行标记状态为 `distilled`
  - 下周继续累积
```

### 周报 4 个问题

1. 这周有没有 moment 让你觉得"之前想错了"？
2. 这周注意到的 1 个重复模式（不限领域）
3. 这周做的决定里，哪个信息量最大？
4. 下周想验证的 1 个假设

## 智能连接（触发时机：每个 skill 输出后）
加载 `prompts/connect-ask.md`：

1. 从当前 skill 的上下文提取关键词（赛道名/公司名/领域名）
2. `rg -i "{关键词}" vault/timeline.md` 搜索匹配
3. 有匹配 → 1 行提示用户，用户说"好"则读取 `vault/entries/{id}.md`
4. 无匹配 → 跳过，直接进入追问阶段

### 示例

用户分析"固态电池"后：
"你的 insights 库里有一条关于固态电池的记录（来自 book-digest）：
半固态和全固态技术路线差异大，评估公司时需区分。要看吗？"

用户说"好" → 读取 vault/entries/2026W28-001.md 输出
用户忽略 → 直接进入追问阶段

## vault 结构

每条记录包含：

- **类型**：pattern（模式）/ lesson（教训）/ principle（原则）/ cross-link（跨领域连接）/ insight（洞察）
- **标签**：至少 1 个
- **摘要**：一句话
- **来源**：哪个工作/追问产生的
- **正文**：可选，详细说明（存储在 `vault/entries/{id}.md`）

## 数据标准

所有 timeline.md 文件遵循 `docs/DATA-STANDARD.md` §4 的标准格式。
新增数据类先在 `data/registry.md` 注册。
