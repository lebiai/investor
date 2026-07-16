# 投资人技能套件 — 实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 搭建 5 个 Codex skill + 1 个共用知识库，形成投资人的完整实操技能体系，可一次迁移至投资人 Codex 环境开箱即用。

**Architecture:** 每个能力独立为 skill 目录，共享同一个 knowledge-base/。总入口 workbench 提供菜单导航，其余 4 个 skill 各司其职。所有 skill 为纯 Markdown 编排 + 触发词驱动，无需代码编写。

**Tech Stack:** Codex Skill 体系（SKILL.md + references/ + agents/openai.yaml），docsify（知识库浏览），微软文件转 MD API（research-digest 依赖）

---

## 文件结构总览

```
/Users/aodun/Documents/投资人/
├── README.md                              ← 项目概述
├── CHANGELOG.md                           ← 修改记录
├── docs/
│   ├── 2026-07-16-investor-skills-design.md  ← 设计规格
│   └── plans/
│       └── 2026-07-16-investor-skills-plan.md  ← 本文件
│
├── knowledge-base/
│   ├── README.md
│   ├── index.md
│   ├── file-index.md
│   ├── companies/
│   │   └── README.md
│   ├── sectors/
│   │   └── README.md
│   └── files/
│       ├── original/
│       │   └── .gitkeep
│       └── .gitkeep
│
├── investor-workbench/
│   ├── SKILL.md
│   └── agents/
│       └── openai.yaml
│
├── investor-sector-analysis/
│   ├── SKILL.md
│   ├── references/
│   │   ├── analysis-framework.md
│   │   ├── institutions.md
│   │   ├── company-scan.md
│   │   ├── debate-engine.md
│   │   └── output-specs.md
│   └── agents/
│       └── openai.yaml
│
├── investor-research-digest/
│   ├── SKILL.md
│   ├── references/
│   │   ├── file-processor.md
│   │   ├── content-analyzer.md
│   │   └── knowledge-base-writer.md
│   └── agents/
│       └── openai.yaml
│
├── investor-content-prod/
│   ├── SKILL.md
│   ├── references/
│   │   ├── template-library.md
│   │   └── content-quality-gate.md
│   └── agents/
│       └── openai.yaml
│
└── investor-deal-sourcing/
    ├── SKILL.md
    ├── references/
    │   ├── scan-protocol.md
    │   └── project-template.md
    └── agents/
        └── openai.yaml
```

---

### Task 1: 项目基础设施 + 知识库骨架

**Files:**
- Create: `/Users/aodun/Documents/投资人/README.md`
- Create: `/Users/aodun/Documents/投资人/CHANGELOG.md`
- Create: `/Users/aodun/Documents/投资人/knowledge-base/README.md`
- Create: `/Users/aodun/Documents/投资人/knowledge-base/index.md`
- Create: `/Users/aodun/Documents/投资人/knowledge-base/file-index.md`
- Create: `/Users/aodun/Documents/投资人/knowledge-base/companies/README.md`
- Create: `/Users/aodun/Documents/投资人/knowledge-base/sectors/README.md`
- Create: `/Users/aodun/Documents/投资人/knowledge-base/files/original/.gitkeep`
- Create: `/Users/aodun/Documents/投资人/knowledge-base/files/.gitkeep`

- [ ] **Step 1: README.md — 项目概述 + 使用说明**

  ```markdown
  # 投资人 AI 技能套件

  ## 这是什么

  为投资人打造的全套 Codex 实操技能体系。纯对话驱动，开箱即用。

  ## 包含技能

  | 技能 | 触发词 | 用途 |
  |------|--------|------|
  | `investor-workbench` | "开工" / "投资助手" | 总入口菜单 |
  | `investor-sector-analysis` | "分析一下[赛道]"/"帮我看看[领域]" | 赛道深度分析+公司扫描 |
  | `investor-research-digest` | "帮我整理这个" | 文件→MD→知识库自动沉淀 |
  | `investor-content-prod` | "帮我写一篇关于[话题]的..." | 知识库驱动的内容生产 |
  | `investor-deal-sourcing` | "帮我扫描[领域]的项目" | 项目 sourcing 扫描 |

  ## 快速开始

  在 Codex 对话中输入 **"开工"** 即可看到完整功能菜单。

  ## 知识库

  所有分析、文件、内容自动沉淀到 `knowledge-base/`，越用越深。如需浏览知识库：

  ```bash
  cd knowledge-base && npx docsify serve .
  ```

  ## 迁移

  打包整个目录迁移到投资人 Codex 环境即可使用。
  ```

- [ ] **Step 2: CHANGELOG.md — 修改记录**

  ```markdown
  # CHANGELOG

  ## 2026-07-16

  - 项目初始化
  - 创建知识库骨架
  - 搭建 investor-workbench（总入口）
  - 搭建 investor-sector-analysis（赛道分析 + 公司扫描）
  - 搭建 investor-research-digest（文件管理 + 知识沉淀）
  - 搭建 investor-content-prod（内容产出）
  - 搭建 investor-deal-sourcing（项目 sourcing）
  ```

- [ ] **Step 3: knowledge-base/README.md**

  ```markdown
  # 投资人知识库

  > 自动累积，无需手动维护。所有 skill 使用完毕自动写入。

  ## 目录说明

  | 目录 | 内容 | 由谁写入 |
  |------|------|---------|
  | `companies/` | 公司档案（基本信息 + 财务数据 + 历史观点） | sector-analysis, deal-sourcing, research-digest |
  | `sectors/` | 赛道档案（六维概览 + 关键公司 + 累积观点） | sector-analysis, research-digest |
  | `files/` | 原始文件 + MD 转换件（按年月归档） | research-digest |

  ## 浏览知识库

  终端运行：
  ```bash
  cd knowledge-base && npx docsify serve .
  ```
  浏览器打开 http://localhost:3000
  ```

- [ ] **Step 4: knowledge-base/index.md**

  ```markdown
  # 知识库索引

  > 自动更新，勿手动编辑。

  ## 赛道索引
  
  （由 sector-analysis 和 research-digest 在每次写入时更新）

  | 赛道 | 首次分析 | 最近更新 | 文件路径 |
  |------|---------|---------|---------|


  ## 公司索引

  （由 sector-analysis、deal-sourcing、research-digest 在写入时更新）

  | 公司 | 建档时间 | 来源 | 文件路径 |
  |------|---------|------|---------|
  ```

- [ ] **Step 5: knowledge-base/file-index.md**

  ```markdown
  # 文件索引

  > 自动更新，勿手动编辑。由 research-digest 在每次文件处理时写入。

  | 上传时间 | 文件名 | 文件类型 | 所属项目 | MD 路径 |
  |---------|--------|---------|---------|--------|
  ```

- [ ] **Step 6: companies/README.md 和 sectors/README.md**

  ```markdown
  # 公司档案目录

  每家公司一个 Markdown 文件，由 sector-analysis、deal-sourcing、research-digest 自动写入。
  格式：公司名.md（如 中微公司.md）
  ```

  ```markdown
  # 赛道档案目录

  每个赛道一个 Markdown 文件，由 sector-analysis、research-digest 自动写入。
  格式：赛道名.md（如 半导体设备.md）
  ```

---

### Task 2: `investor-workbench` — 总入口 Skill

**Files:**
- Create: `/Users/aodun/Documents/投资人/investor-workbench/SKILL.md`
- Create: `/Users/aodun/Documents/投资人/investor-workbench/agents/openai.yaml`

- [ ] **Step 1: agents/openai.yaml**

  ```yaml
  name: investor-workbench
  description: "投资人AI助手总入口。说'开工'或'投资助手'展示所有能力"
  trigger_words:
    - "开工"
    - "投资助手"
    - "有什么能力"
  ```

- [ ] **Step 2: SKILL.md — 总入口编排**

  ```markdown
  ---
  name: investor-workbench
  description: "投资人AI助手总入口——说'开工'即可查看全部能力"
  ---

  # 投资人工作台

  ## 触发词

  - "开工"
  - "投资助手"
  - "有什么能力"

  ## 工作流

  用户说出触发词时，输出以下菜单：

  ┌─────────────────────────────────────────────┐
  │  📋 投资人助手已就绪                            │
  │                                              │
  │  ① 赛道分析                                    │
  │     → "帮我分析一下[赛道名]"                      │
  │     → 六维分析 + 多机构辩论 + 公司扫描             │
  │                                              │
  │  ② 信息整理                                    │
  │     → "帮我整理这篇文章/这个文件"                   │
  │     → 自动转MD + 存入知识库                      │
  │                                              │
  │  ③ 内容产出                                    │
  │     → "帮我写一篇关于[话题]的[体裁]"               │
  │     → 基于知识库的内容生产                        │
  │                                              │
  │  ④ 项目扫描                                    │
  │     → "帮我扫描[领域]的新项目"                    │
  │     → 新融资/新入局者/估值参考                    │
  │                                              │
  │  ⑤ 知识库浏览                                  │
  │     → 终端运行：                                 │
  │       cd knowledge-base && npx docsify serve . │
  │     浏览器打开 http://localhost:3000            │
  │                                              │
  │  直接说需求，不用选编号                           │
  └─────────────────────────────────────────────┘

  用户说出任意需求后，根据意图路由到对应 skill 的工作流。

  ## 路由规则

  - 关键词含"分析""赛道""行业""怎么看" → 激活 sector-analysis
  - 关键词含"整理""总结""摘要""读一下" → 激活 research-digest
  - 关键词含"写""发""文章""小红书""朋友圈" → 激活 content-prod
  - 关键词含"扫描""项目""标的""融资" → 激活 deal-sourcing
  - 关键词含"打开""浏览""知识库" → 输出知识库浏览指引
  - 无法匹配 → 根据上下文做最佳判断或询问用户
  ```

---

### Task 3: `investor-sector-analysis` — 赛道分析 Skill

**Files:**
- Create: `/Users/aodun/Documents/投资人/investor-sector-analysis/SKILL.md`
- Create: `/Users/aodun/Documents/投资人/investor-sector-analysis/references/analysis-framework.md`
- Create: `/Users/aodun/Documents/投资人/investor-sector-analysis/references/institutions.md`
- Create: `/Users/aodun/Documents/投资人/investor-sector-analysis/references/company-scan.md`
- Create: `/Users/aodun/Documents/投资人/investor-sector-analysis/references/debate-engine.md`
- Create: `/Users/aodun/Documents/投资人/investor-sector-analysis/references/output-specs.md`
- Create: `/Users/aodun/Documents/投资人/investor-sector-analysis/agents/openai.yaml`

- [ ] **Step 1: agents/openai.yaml**

  ```yaml
  name: investor-sector-analysis
  description: "多机构辩论模式赛道深度分析。六维分析+六家机构评估+公司扫描+辩论引擎。触发词：分析一下、帮我看看"
  trigger_words:
    - "分析一下"
    - "帮我看看"
    - "赛道"
    - "行业分析"
  ```

- [ ] **Step 2: references/analysis-framework.md — 六维分析框架**

  ```markdown
  # 六维赛道分析框架

  所有维度在分析时基于实时搜索数据，输出评分（1-10）和核心判断。

  ## 维度一：市场规模

  - TAM（潜在总市场规模）/ SAM（可服务市场）/ SOM（可获得市场）
  - 当前规模（亿元/亿美元）
  - 数据来源标注

  ## 维度二：增速

  - 过去 3-5 年 CAGR
  - 未来 3-5 年预测 CAGR
  - 增长驱动力分析
  - 是否处于渗透率加速拐点

  ## 维度三：竞争格局

  - CR3/CR5 集中度
  - 头部梯队成员及市场份额
  - 竞争壁垒类型（技术/品牌/规模/网络效应/监管）
  - 格局稳定度（new entrant 威胁程度）

  ## 维度四：技术壁垒

  - 核心技术门槛（研发强度/专利壁垒/know-how）
  - 技术迭代速度
  - 是否存在颠覆性技术替代风险
  - 国产替代空间（如适用）

  ## 维度五：政策环境

  - 监管态度（鼓励/中性/限制）
  - 补贴/税收政策影响
  - 地缘政治风险（如半导体/能源等战略行业）
  - 合规成本

  ## 维度六：资本热度

  - 近 12 个月融资事件数量及金额
  - 估值水位（二级市场 PE 倍数 vs 历史均值）
  - 一级市场估值变化趋势
  - 产业资本 vs 财务资本参与度

  ## 辩论触发点标注

  每个维度分析完成后，标注：
  - 该维度中数据矛盾或重大分歧 → 供辩论引擎使用
  - 明显的信息缺口 → 标注盲点
  ```

- [ ] **Step 3: references/institutions.md — 六机构人设**

  ```markdown
  # 六家投资机构评估人设

  每次赛道分析时，让每家机构独立输出对该赛道的核心观点和评分。

  ## Sequoia Capital（红杉）

  - **风格**: 早期赛道型，关注颠覆性技术和巨大市场空间
  - **关注重点**: 市场天花板是否足够大、团队是否够强、时机是否合适
  - **典型评分标准**:
    - 市场空间 >1000 亿 → 高分；技术壁垒足够高 → 加分
    - 早期赛道（渗透率 <10%）→ 积极
  - **指令**: 扮演 Sequoia 的赛道分析合伙人，重点评估"这个赛道能不能长出千亿级公司"

  ## Benchmark Capital

  - **风格**: 极致产品驱动，团队极精简
  - **关注重点**: 产品差异性、用户体验壁垒、网络效应
  - **典型评分标准**:
    - 产品有 10x 改进 → 兴奋；需要重资本投入 → 谨慎
    - 团队小而精 → 加分
  - **指令**: 扮演 Benchmark 的投资人，重点评估"这个赛道的产品能不能比现有方案好 10 倍"

  ## SoftBank Vision Fund（软银）

  - **风格**: 大赌大赢，赛道级的重注
  - **关注重点**: 是否能成为赛道第一、AI 赋能空间、全球化潜力
  - **典型评分标准**:
    - 谁有潜力成为绝对第一 → 投；第二名没意义
    - AI/技术驱动 → 加分
  - **指令**: 扮演 SoftBank 的投资负责人，重点评估"这个赛道值不值得下 100 亿的注"

  ## Hillhouse Capital（高瓴）

  - **风格**: 全阶段、深入研究驱动
  - **关注重点**: 基本面深度、管理层质量、长期护城河
  - **典型评分标准**:
    - 深入研究能发现市场忽视的信号 → 机会
    - 管理层格局和执行力 → 核心加分项
  - **指令**: 扮演 Hillhouse 的研究负责人，重点评估"深入研究会发现什么市场忽视的机会"

  ## Warren Buffett（巴菲特风格）

  - **风格**: 价值投资，长期持有，能力圈
  - **关注重点**: 护城河（宽/窄/无）、ROE、自由现金流、管理层诚信
  - **典型评分标准**:
    - 护城河宽度 → 核心指标；高 ROE + 低负债 → 加分
    - 看不懂的技术 → 跳过（能力圈原则）
  - **指令**: 扮演 Buffett 的视角，重点评估"这个赛道有没有能持有 20 年的公司"

  ## 3G Capital（3G 资本风格）

  - **风格**: 运营驱动，投后管理，成本优化
  - **关注重点**: 行业是否分散可以整合、运营效率提升空间、管理激励
  - **典型评分标准**:
    - 行业极其分散 → 最佳机会；可标准化运营 → 加分
    - 投后管理可以显著提升利润率 → 核心指标
  - **指令**: 扮演 3G Capital 的合伙人，重点评估"这个赛道能不能通过运营整合出巨大价值"

  ## 用户权重调整

  如果用户表达了风格偏好（如"我偏价值投资""我喜欢高风险高回报"），相应调整各机构评分的加权系数。

  | 用户偏好 | 加权的机构 |
  |---------|-----------|
  | 价值投资/稳健 | Buffett ↑、Hillhouse ↑ |
  | 高风险高回报 | Sequoia ↑、SoftBank ↑ |
  | 运营驱动 | 3G Capital ↑、Benchmark ↑ |
  | 全阶段研究 | Hillhouse ↑、Sequoia ↑ |
  ```

- [ ] **Step 4: references/company-scan.md — 公司层扫描逻辑**

  ```markdown
  # 公司层扫描逻辑

  在六维赛道分析 + 六机构评估之后执行，对赛道内的具体公司进行扫描和对比。

  ## 扫描范围

  ### 上市公司

  - 按子领域/细分环节分类（如半导体：设备/设计/封测/材料/EDA）
  - 每家公司收集：
    - 股票代码、市值
    - 营收（近 3 年）、营收增速
    - 毛利率、净利率
    - PE（TTM）/ PS
    - 核心产品/市场地位
  - 输出横向对比表

  ### 未上市公司

  - 按细分领域归类
  - 每家公司收集：
    - 一句话定位（做什么的）
    - 最新估值 / 融资轮次
    - 主要投资方
    - 成立时间
  - 输出项目清单

  ## 产业链定位

  对每一家公司标注：
  - 处于产业链哪个环节（上游/中游/下游）
  - 可替代性（高/中/低）— 谁卡住关键环节
  - 该环节的价值分配占比

  ## 投资信号生成

  结合赛道阶段给出信号类型：

  | 赛道阶段 | 建议策略 | 关注方向 |
  |---------|---------|---------|
  | 早期（渗透率 <5%） | 广撒网 | 找到第一梯队所有玩家 |
  | 成长期（5-30%） | 选龙头 | 份额扩张最快的公司 |
  | 成熟期（>30%） | 等低估 | 低估值 + 高分红或整合逻辑 |
  | 变革期（技术替代） | 关注新势力 | 有颠覆潜力的新入局者 |

  ## 数据源

  - 上市公司数据：web search 实时获取
  - 未上市公司数据：公开融资报道 + 行业研究
  - 标注每个数据的来源，无来源时说明"基于公开可比数据估算"
  ```

- [ ] **Step 5: references/debate-engine.md — 辩论引擎逻辑**

  ```markdown
  # 辩论引擎

  在六维分析 + 六机构评估 + 公司扫描之后执行，分析哪些是共识、哪些是分歧、哪些被忽略。

  ## 第一步：共识检测

  扫描六家机构输出的观点和评分，找出：

  - **高度共识**（5-6 家一致）→ 标注为"机构共识"，引用为可靠信号
  - **中度共识**（3-4 家一致）→ 标注为"多数认可"，附少数异议理由
  - **无共识**（<3 家一致）→ 不标注

  共识内容示例：
  ```
  ✅ 机构共识（5/6）：该赛道处于成长期前段，3-5 年内 CAGR >30%
     - 仅 Buffett 认为增速可能被高估，理由：历史基数低
  ```

  ## 第二步：分歧检测

  找出分歧点，按严重度评级：

  | 评级 | 定义 | 标记 |
  |------|------|------|
  | ⚡ 重大分歧 | 评分差 ≥4 分 或 投资结论完全相反 | Red Alert |
  | ⚡ 中度分歧 | 评分差 2-3 分 或 对同一维度的判断不同 | Yellow |
  | 轻微分歧 | 评分差 1 分 或 侧重点不同 | Blue |

  每个分歧点分析：
  - 分歧的根因（数据差异 / 哲学差异 / 信息不对称）
  - 解决分歧需要什么额外信息

  ## 第三步：盲点检测

  找出所有机构都未深入讨论的风险因子或机会信号。

  盲点来源：
  - 六维分析中标注的"辩论触发点"但未被机构讨论的
  - 公司扫描中发现但机构未评价的
  - 外部环境变化（政策、技术、地缘）未被纳入的

  盲点标记格式：
  ```
  ◯ 潜在盲点：XX 市场的地缘政治风险
     - 六家机构均未讨论该风险
     - 实际影响：高（参考近期 XX 事件）
     - 建议：进一步深入研究
  ```
  ```

- [ ] **Step 6: references/output-specs.md — 输出四件套规范**

  ```markdown
  # 输出规范

  最终交付物包含四个部分：

  ## 1. 完整分析报告

  结构：
  ```
  # [赛道名] 赛道深度分析

  ## 执行摘要（300 字内）
  一句话总结 + 核心发现 + 投资信号的最高优先级

  ## 一、赛道基本面
  （六维分析摘要，每个维度 2-3 段）

  ## 二、多机构评估观点
  （六家各自的核心观点，每家 3-5 句话）

  ## 三、公司层扫描
  （上市公司对比表 + 未上市公司清单 + 产业链位置）

  ## 四、辩论分析
  （共识/分歧/盲点）

  ## 五、综合投资建议
  （信号类型 + 优先级排序 + 下一步）
  ```

  ## 2. 赛道打分卡

  表格格式：
  | 维度 | 评分(1-10) | 核心判断 | 分歧度 |
  |------|-----------|---------|--------|
  | 市场规模 | 7 | ... | 低 |
  | 增速 | 8 | ... | 中 |
  | ... | ... | ... | ... |

  8 分以上代表真正卓越，大多数赛道各维度在 4-7 分。

  ## 3. 辩论对比表

  | 议题 | Sequoia | Benchmark | SoftBank | Hillhouse | Buffett | 3G | 总结 |
  |------|---------|-----------|----------|-----------|---------|-----|------|
  | 市场吸引力 | 9 | 8 | 10 | 7 | 5 | 6 | ⚡分歧 |
  | ... | | | | | | | |

  ## 4. 公司对比表

  ### 上市公司

  | 公司 | 子领域 | 市值 | 营收增速 | 毛利率 | PE | 竞争地位 |
  |------|--------|------|---------|-------|-----|---------|

  ### 未上市明星项目

  | 公司 | 定位 | 最新融资 | 估值 | 投资方 |
  |------|------|---------|------|--------|
  ```

- [ ] **Step 7: SKILL.md — 赛道分析主编排**

  ```markdown
  ---
  name: investor-sector-analysis
  description: "多机构辩论模式赛道分析。六维分析→六家机构评估→公司层扫描→辩论引擎→输出四件套"
  ---

  # 赛道分析

  ## 触发词

  - "帮我分析一下[赛道名]"
  - "帮我看看[行业/领域]"
  - "从投资人角度分析[领域]"

  ## 工作流

  ### Phase 1: 加载记忆 + 知识库查询

  1. 查 `knowledge-base/sectors/index.md` 是否有该赛道的历史分析记录
  2. 如有 → 输出"上次分析过该赛道（YYYY-MM-DD），新信息已合并"
  3. 查 `knowledge-base/companies/` 中已有相关公司

  ### Phase 2: 六维赛道分析

  加载 `references/analysis-framework.md`，逐个维度执行：
  1. 使用 web search 获取该维度的最新数据
  2. 每个维度输出评分（1-10）+ 核心判断 + 辩论触发点标注
  3. 标注数据来源

  ### Phase 3: 六机构独立评估

  加载 `references/institutions.md`，按六家机构的人设逐家输出：
  1. 每家输出核心观点（3-5 句话）
  2. 每家输出吸引力评分（1-10）
  3. 如用户有风格偏好 → 相应调整权重

  ### Phase 4: 公司层扫描

  加载 `references/company-scan.md`：
  1. 使用 web search 获取赛道内的上市公司数据
  2. 使用 web search 获取未上市公司融资信息
  3. 生成公司对比表
  4. 输出投资信号

  ### Phase 5: 辩论引擎

  加载 `references/debate-engine.md`：
  1. 共识检测
  2. 分歧检测（含严重评级）
  3. 盲点检测

  ### Phase 6: 输出四件套

  加载 `references/output-specs.md`，按规范生成：
  1. 完整分析报告
  2. 赛道打分卡
  3. 辩论对比表
  4. 公司对比表

  ### Phase 7: 知识库入库

  1. 写入 `knowledge-base/sectors/[赛道名].md`
     - 执行摘要 + 六维概览表 + 关键公司清单 + 累积观点
  2. 写入 `knowledge-base/companies/`（每家公司单独建档）
     - 基础信息 + 核心数据表 + 知识来源记录
  3. 更新 `knowledge-base/sectors/README.md` 和 `knowledge-base/companies/README.md` 中的索引
  4. 更新 `knowledge-base/index.md`

  ### Phase 8: 交互追问

  输出完成后，追问：
  - "需要深入分析某家公司吗？"
  - "想从哪个维度进一步深挖？"
  - "要把这个赛道分析写成文章吗？"（引导到 content-prod）
  ```

---

### Task 4: `investor-research-digest` — 信息管理 Skill

**Files:**
- Create: `/Users/aodun/Documents/投资人/investor-research-digest/SKILL.md`
- Create: `/Users/aodun/Documents/投资人/investor-research-digest/references/file-processor.md`
- Create: `/Users/aodun/Documents/投资人/investor-research-digest/references/content-analyzer.md`
- Create: `/Users/aodun/Documents/投资人/investor-research-digest/references/knowledge-base-writer.md`
- Create: `/Users/aodun/Documents/投资人/investor-research-digest/agents/openai.yaml`

- [ ] **Step 1: agents/openai.yaml**

  ```yaml
  name: investor-research-digest
  description: "自动文件管理和知识沉淀。上传/链接→转MD→知识库入库→输出摘要。触发词：整理、总结、读一下"
  trigger_words:
    - "帮我整理"
    - "总结"
    - "读一下"
    - "摘要"
    - "处理这个文件"
  ```

- [ ] **Step 2: references/file-processor.md — 文件处理规范**

  ```markdown
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
  - 所属项目：AI 根据文件内容推断（如内容提到某赛道/公司名，或用户之前讨论过的主题）
  - MD路径：`files/YYYY-MM/文件名.md`

  ## 原始文件归档

  - 原始文件复制到 `knowledge-base/files/original/`
  - 命名规则：`YYYYMMDD_原始文件名`

  ## MD 持久化

  - 转换后的 MD 文件保存到 `knowledge-base/files/YYYY-MM/`
  - 命名规则：`YYYYMMDD_原始文件名(去掉扩展名).md`
  ```

- [ ] **Step 3: references/content-analyzer.md — 内容分析逻辑**

  ```markdown
  # 内容分析逻辑

  ## 体裁识别

  根据内容和结构判断：
  | 特征 | 体裁 |
  |------|------|
  | 有"摘要""评级""目标价" | 研报 |
  | 有"本报讯""记者" | 新闻 |
  | 有资产负债表/利润表 | 财报 |
  | 有"会议""发言""Q&A" | 纪要 |
  | 有技术细节+专利 | 白皮书 |
  | 以上都不是 | 其它 |

  ## 核心观点提取

  - 提取 3-5 条核心观点
  - 每条标注置信度（高/中/低）
  - 标注来源出处（原文中的段落引用）

  ## 关键数据提取

  - 数值类数据：数字 + 单位 + 时间范围
  - 对比类数据：增速变化、市场份额变化
  - 估值类数据：PE/PS/市值/估值

  ## 关联实体识别

  识别文本中出现的：
  - 公司名 → 查 knowledge-base/companies/ 是否有对应档案
  - 赛道/行业名 → 查 knowledge-base/sectors/
  - 技术关键词（如"3nm""Chiplet""固态电池")
  - 人名（创始人/高管/分析师）
  ```

- [ ] **Step 4: references/knowledge-base-writer.md — 知识库写入协议**

  ```markdown
  # 知识库写入协议

  ## 写入规则

  每次内容分析完成后，决定知识库的写入方式：

  ### 关联了已有赛道

  如果内容关联的赛道在 `knowledge-base/sectors/` 中已有档案：
  1. 打开已有档案
  2. 在"累积观点"章节追加新内容（标注日期 + 来源文件）
  3. 更新"最近更新"日期

  ### 关联了已有公司

  如果内容关联的公司已建档：
  1. 打开公司档案
  2. 在"核心数据"中更新财务数据（如有）
  3. 在"知识来源"中追加新条目
  4. 在"关键洞察"中追加新观点

  ### 新赛道/新公司

  如果内容提到的新赛道/新公司在知识库中不存在：
  1. 按标准格式新建档案
  2. 初始数据填充：提取内容中提到的信息
  3. 在"知识来源"标注"初始建档：XXX文件"

  ### 不关联任何条目

  如果内容不关联任何已知实体：
  1. 只归档到 `knowledge-base/files/YYYY-MM/` 目录
  2. 在 `file-index.md` 中记录
  3. 告知用户"未匹配到已有知识库条目，已在文件目录归档"
  ```

- [ ] **Step 5: SKILL.md — 信息管理主编排**

  ```markdown
  ---
  name: investor-research-digest
  description: "文件管理+知识沉淀。上传文件/链接→转MD→分析→知识库入库→输出摘要。支持检索已存文件"
  ---

  # 信息管理

  ## 触发词

  - "帮我整理这篇文章/这个文件"
  - "总结一下这个"
  - "帮我读一下这个"
  - "处理这个文件"
  - "帮我找一下[文件名/关键词]"

  ## 工作流

  ### Step 1: 输入确认

  识别用户提供的内容类型：
  - 文件上传（PDF/Word/PPT/Excel/图片）
  - 网页链接
  - 粘贴的纯文本

  如果用户没提供具体内容，追问："请上传文件或提供链接/文字"

  ### Step 2: 文件处理

  加载 `references/file-processor.md`：
  1. 识别文件类型，选择处理方式
  2. 记录元数据到 `file-index.md`
  3. 调用微软格式转换 API（PDF/Office 文件）
  4. 保存原始文件到 `files/original/`
  5. 保存 MD 到 `files/YYYY-MM/`

  ### Step 3: 内容分析

  加载 `references/content-analyzer.md`：
  1. 体裁识别
  2. 核心观点提取（3-5 条 + 置信度）
  3. 关键数据提取
  4. 关联实体识别

  ### Step 4: 知识库写入

  加载 `references/knowledge-base-writer.md`：
  1. 按规则写入 knowledge-base/sectors/、companies/、或仅归档
  2. 更新 knowledge-base/index.md

  ### Step 5: 输出摘要

  输出：
  ```
  📋 一句话总结：...

  📝 核心观点：
  - [观点1]（高置信度）
  - [观点2]（中置信度）
  ...

  📊 关键数据：...

  🔗 知识库关联：
  - 已关联赛道：[赛道名]（已有分析记录）
  - 已关联公司：[公司名]（N条历史记录）

  💡 新发现：...
  ```

  ### 文件检索模式

  如果用户说"帮我找一下"：
  1. 查 `knowledge-base/file-index.md` → 匹配文件名/内容/时间/项目
  2. 匹配到 → 输出 `files/YYYY-MM/` 下的完整 MD 内容
  3. 未匹配到 → "未找到完全匹配，以下是近似结果..."
  ```

---

### Task 5: `investor-content-prod` — 内容产出 Skill

**Files:**
- Create: `/Users/aodun/Documents/投资人/investor-content-prod/SKILL.md`
- Create: `/Users/aodun/Documents/投资人/investor-content-prod/references/template-library.md`
- Create: `/Users/aodun/Documents/投资人/investor-content-prod/references/content-quality-gate.md`
- Create: `/Users/aodun/Documents/投资人/investor-content-prod/agents/openai.yaml`

- [ ] **Step 1: agents/openai.yaml**

  ```yaml
  name: investor-content-prod
  description: "基于知识库的内容生产。支持公众号/小红书/朋友圈/投资备忘录等体裁。触发词：帮我写"
  trigger_words:
    - "帮我写"
    - "发一篇"
    - "写个文章"
    - "做个内容"
    - "改成文章"
  ```

- [ ] **Step 2: references/template-library.md — 体裁模板库**

  ```markdown
  # 体裁模板库

  ## 公众号文章

  - **字数**: 1500-2500 字
  - **结构**:
    1. **钩子（前 100 字）**: 一个反直觉的数据/反差/热点切入
    2. **背景（200 字）**: 为什么这个话题现在值得关注
    3. **数据分析（600-1000 字）**: 2-3 个核心数据点，每个拆开讲
    4. **观点输出（300-500 字）**: 投资人的独家判断
    5. **总结 + 互动（100 字）**: 一句话总结 + 抛问题给读者
  - **风格**: 专业但不枯燥，数据多但有叙事感

  ## 小红书

  - **字数**: 300-500 字
  - **结构**:
    1. **金句开头（1 行）**: 戳中痛点的观点
    2. **3 个核心点**（每个 50-100 字）:
       - 点 1: 数据/事实
       - 点 2: 观点/判断
       - 点 3: 可行动建议
    3. **总结句（1 行）**
    4. **标签（3-5 个）**: #投资人视角 #行业洞察 等
  - **风格**: 口语化、有记忆点、适合截图传播

  ## 朋友圈

  - **字数**: 100-200 字
  - **结构**: 一句观点 + 一个数据支撑 + 一句号召
  - **风格**: 犀利、个人化、像真人在说话

  ## 投资备忘录

  - **字数**: 2000-4000 字
  - **结构**:
    1. **投资逻辑（500-800 字）**: 为什么是这个赛道/公司
    2. **关键假设（500-800 字）**: 增长假设/利润率假设/估值假设
    3. **风险分析（300-500 字）**: Top 3 风险 + 触发条件
    4. **估值分析（300-500 字）**: DCF / 可比公司 / 历史区间
    5. **结论 + 仓位建议（200 字）**
  - **风格**: 严谨、可回溯、作为决策记录

  ## 路演纪要

  - **字数**: 500-1000 字
  - **结构**:
    1. **核心论点（100 字）**: 一句话论点
    2. **3-5 条论据**（每条 50-100 字）
    3. **下一步（50 字）**: 后续跟进事项
  - **风格**: 信息密度高、适合快速阅读
  ```

- [ ] **Step 3: references/content-quality-gate.md — 内容质量检查**

  ```markdown
  # 内容质量检查清单

  每篇内容交付前，逐项检查：

  ## 事实检查

  - [ ] 每个数据/事实都能对应到知识库出处
  - [ ] 知识库中没有的数据 → 标注"基于公开信息估算"或"待验证"
  - [ ] 不编造超出知识库范围的信息

  ## 情绪钩子

  - [ ] 前 100 字（公众号）/ 前 30 字（小红书）能抓住注意力
  - [ ] 至少有一个反直觉/反差/争议点

  ## 可传播性

  - [ ] 至少 1 句金句可以独立分享
  - [ ] 没有行业黑话堆砌（除非目标读者专业度高）
  - [ ] 读完能说出"核心观点是什么"

  ## 平台适配

  - [ ] 字数在目标体裁建议范围 ±10%
  - [ ] 风格符合目标平台
  ```

- [ ] **Step 4: SKILL.md — 内容产出主编排**

  ```markdown
  ---
  name: investor-content-prod
  description: "基于知识库的内容生产。说'帮我写一篇关于[话题]的[体裁]'，自动找知识库素材+套模板+出稿"
  ---

  # 内容产出

  ## 触发词

  - "帮我写一篇关于[话题]的[体裁]"
  - "把这个赛道分析写成文章"
  - "帮我发一篇小红书关于..."
  - "写个朋友圈"

  ## 工作流

  ### Step 1: 查知识库

  1. 搜索 `knowledge-base/sectors/` 和 `knowledge-base/companies/`
  2. 搜索 `knowledge-base/file-index.md` 查阅相关研报摘要
  3. 输出找到的素材清单给用户确认：
     ```
     已找到以下素材：
     - [赛道名] 赛道分析（YYYY-MM-DD）
     - [公司名] 公司档案
     - 相关研报 N 篇
     需要用全部还是指定某个？
     ```

  ### Step 2: 定调

  询问用户（或从已有上下文推断）：
  1. 体裁（如未指定）：公众号/小红书/朋友圈/投资备忘录/路演纪要
  2. 角度：行业趋势/龙头对比/投资机会/风险警示
  3. 风格：专业严谨/通俗易懂/犀利观点

  ### Step 3: 内容生成

  加载 `references/template-library.md` 对应体裁模板：
  1. 按模板结构组织内容
  2. 数据标注出处（"[来源：赛道分析 YYYY-MM-DD]"）
  3. 生成 3 个备选标题
  4. 抽取 1-2 句金句（标🌟）

  ### Step 4: 质量检查

  加载 `references/content-quality-gate.md` 逐项检查，不合格则修改。

  ### Step 5: 交付

  输出格式：
  ```
  ## 标题备选
  1. ...
  2. ...
  3. ...

  ---
  （正文内容）
  ---

  🌟 金句：...

  📝 注：数据来源标注在文内 [出处]
  ```

  ### Step 6: 保存

  询问用户是否保存到 `outputs/` 目录：
  - 保存 → `outputs/YYYY-MM-DD-标题.md`
  - 不保存 → 只输出给用户
  ```

---

### Task 6: `investor-deal-sourcing` — 项目扫描 Skill

**Files:**
- Create: `/Users/aodun/Documents/投资人/investor-deal-sourcing/SKILL.md`
- Create: `/Users/aodun/Documents/投资人/investor-deal-sourcing/references/scan-protocol.md`
- Create: `/Users/aodun/Documents/投资人/investor-deal-sourcing/references/project-template.md`
- Create: `/Users/aodun/Documents/投资人/investor-deal-sourcing/agents/openai.yaml`

- [ ] **Step 1: agents/openai.yaml**

  ```yaml
  name: investor-deal-sourcing
  description: "项目sourcing扫描。说'帮我扫描[领域]的项目'，查知识库+实时搜索→输出项目清单"
  trigger_words:
    - "帮我扫描"
    - "有什么项目"
    - "标的"
    - "新项目"
    - "融资"
  ```

- [ ] **Step 2: references/scan-protocol.md — 扫描流程规范**

  ```markdown
  # 项目扫描流程规范

  ## 查知识库

  在实时搜索之前，先查询本地知识库：
  1. `knowledge-base/sectors/[领域].md` → 该赛道的已有分析
  2. `knowledge-base/companies/` → 该领域已建档的公司
  3. 标记哪些是已有关注、哪些是已知信息

  ## 实时扫描范围

  使用 web search 搜索以下内容：
  1. **新融资事件**: 近 3-6 个月该领域的融资/融资轮次
  2. **新入局者**: 跨界进入该赛道的玩家
  3. **资本布局**: 头部 VC/PE/CVC 在该领域的投资动向
  4. **估值水位**: 可比公司一级/二级定价

  ## 信息组织

  将扫描结果分为三类：
  - **已有关注 + 动态更新** → 知识库已有项目，补充最新信息
  - **新发现项目** → 首次出现的标的
  - **资本热度信号** → 数量/金额/参与的基金类型

  ## 输出项目清单格式

  ### 已关注意向项目

  | 公司 | 最新估值 | 最新动态 | 上次更新时间 | 跟进状态 |
  |------|---------|---------|------------|---------|

  ### 新发现项目

  | 公司 | 定位 | 融资轮次 | 融资金额 | 主要投资方 | 发现日期 |
  |------|------|---------|---------|-----------|---------|

  ### 跟进建议

  - 优先看哪个、为什么
  - 什么阶段适合什么方式的接触
  ```

- [ ] **Step 3: references/project-template.md — 项目档案模板**

  ```markdown
  # 项目档案模板

  写入 `knowledge-base/companies/` 时的公司档案格式：

  ```markdown
  # [公司名]

  ## 基础信息
  - **成立时间**：
  - **主营业务**：
  - **最新估值/市值**：
  - **融资轮次**：
  - **主要投资方**：

  ## 核心数据
  | 指标 | 最新 | 前年 | 说明 |
  |------|------|------|------|

  ## 知识来源
  - YYYY-MM-DD：[来源 + 操作]
  - ...

  ## 关键洞察
  - （所有相关 skill 的累积观点）
  ```
  ```

- [ ] **Step 4: SKILL.md — 项目扫描主编排**

  ```markdown
  ---
  name: investor-deal-sourcing
  description: "项目sourcing。说'帮我扫描[领域]的项目'，查知识库+实时搜索→输出项目清单+跟进建议"
  ---

  # 项目扫描

  ## 触发词

  - "帮我扫描一下[领域]的新项目"
  - "[领域]有什么好项目"
  - "这个方向有哪些标的"
  - "最近[领域]有什么融资"

  ## 工作流

  ### Step 1: 查知识库

  加载 `references/scan-protocol.md`：
  1. 查 knowledge-base/sectors/ → 该领域是否有分析记录
  2. 查 knowledge-base/companies/ → 已建档的被投/关注项目
  3. 标记已知 vs 未知

  ### Step 2: 实时扫描

  使用 web search：
  1. 最近 3-6 个月该领域的融资事件
  2. 新入局者 / 跨界玩家
  3. 产业资本 + 财务资本布局

  ### Step 3: 输出项目清单

  输出内容：

  ```
  📋 已关注意向项目
  （知识库已有 + 最新动态更新）

  🔍 新发现项目（N个）
  （最新融资/公开报道）

  📊 估值参考
  （同赛道可比公司估值区间）

  🔗 人脉线索
  （如搜索到创始团队/投资机构信息）

  💡 跟进建议
  1. [项目名] → 优先原因
  2. [项目名] → 推荐原因
  ```

  ### Step 4: 知识库入库

  1. 新项目写入 `knowledge-base/companies/`（按 `references/project-template.md` 格式建档）
  2. 更新 `knowledge-base/sectors/` 对应条目
  3. 更新 `knowledge-base/index.md`
  ```

---

## 执行顺序

```
基础设施 ──→ workbench ──→ sector-analysis ──→ research-digest ──→ content-prod ──→ deal-sourcing
(Task 1)    (Task 2)     (Task 3)            (Task 4)            (Task 5)         (Task 6)
```

每个 Task 生产的是可独立工作的 Skill。Task 1 是底座，Task 2-6 可以并行。

---

## 依赖清单

| 依赖 | 用途 | 安装方式 |
|------|------|---------|
| docsify | 知识库浏览 | `npm install -g docsify-cli` 或 `npx docsify` |
| 微软文件转MD API | 文件格式转换 | 配置 API key（在投资人环境中配置） |

---

## 交付标准

- [ ] 所有 Skill 独立可用，纯对话触发
- [ ] knowledge-base 目录结构完整
- [ ] 每个 skill 有明确的触发词
- [ ] workbench 输出完整菜单
- [ ] sector-analysis 完整跑通（六维+机构+公司+辩论+入库）
- [ ] research-digest 支持文件处理+知识库入库+检索
- [ ] content-prod 基于知识库生成内容
- [ ] deal-sourcing 支持新项目扫描+入库
- [ ] 打包迁移脚本已备
