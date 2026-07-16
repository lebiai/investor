---
name: investor-sector-analysis
description: "多机构辩论模式赛道分析。六维分析→六家机构评估→公司层扫描→辩论引擎→输出四件套"
---

# 赛道分析

## 触发词

- "帮我分析一下[赛道名]"
- "帮我看看[行业/领域]"
- "从投资人角度分析[领域]"

## 数据来源

本 skill 的数据来源只有两类：

| 来源 | 调用方式 | 用于哪些阶段 |
|------|---------|-------------|
| ① agent-reach 搜索 | 执行 Exa 搜索命令获取互联网实时数据 | Phase 2/3/4 |
| ② data/ 知识库 | 直接读取本地 data/ 目录下的文件 | Phase 1/7 |

每项数据必须标注来源标签 `[来源: agent-reach]` 或 `[来源: 知识库]`。

### 调用 [skill:agent-reach] 搜索

本 skill 通过 [skill:agent-reach] 获取互联网数据。
执行后解析返回结果中的 `results[].title` 和 `results[].text` 提取所需信息。

## 工作流

### Phase 1: 加载记忆 + 知识库查询 [来源: ②知识库]

1. 查 `../../data/sectors/` 是否有该赛道的历史分析记录
2. 如有 → 输出"上次分析过该赛道（YYYY-MM-DD），新信息已合并"
3. 查 `../../data/companies/` 中已有相关公司

### Phase 2: 六维赛道分析 [来源: ①agent-reach搜索]

加载 `references/analysis-framework.md`，逐个维度执行：

对每个维度，构造搜索关键词并调用 [skill:agent-reach] 获取数据：

示例：分析"半导体设备"赛道的"市场规模"维度：

每个维度执行步骤：
1. 构造该维度的中文搜索关键词，调用 [skill:agent-reach] 搜索
2. 从搜索结果中提取相关数据
3. 输出评分（1-10）+ 核心判断 + 辩论触发点标注
4. 每一条数据标注 `[来源: agent-reach]`，按可靠性分级（详见 analysis-framework.md）

### Phase 3: 六机构独立评估 [来源: ①agent-reach搜索]

基于 Phase 2 的搜索结果，加载 `references/institutions.md`，按六家机构的人设逐家输出：
1. 每家输出核心观点（3-5 句话）
2. 每家输出吸引力评分（1-10）
3. 如用户有风格偏好 → 相应调整权重

### Phase 4: 公司层扫描 [来源: ①agent-reach搜索]

加载 `references/company-scan.md`：

1. 搜索上市公司数据：

2. 搜索未上市公司融资信息：
3. 生成公司对比表
4. 输出投资信号

### Phase 5: 辩论引擎 [来源: ①+②]

综合前序所有搜索结果和知识库数据，加载 `references/debate-engine.md`：
1. 共识检测
2. 分歧检测（含严重评级）
3. 盲点检测

### Phase 6: 输出四件套

加载 `references/output-specs.md`，按规范生成：
1. 完整分析报告
2. 赛道打分卡
3. 辩论对比表
4. 公司对比表

### Phase 7: 知识库入库 [来源: ②知识库]

将本次分析结果写入本地知识库：
1. 写入 `../../data/sectors/[赛道名].md`
   - 执行摘要 + 六维概览表 + 关键公司清单 + 累积观点
2. 写入 `../../data/companies/`（每家公司单独建档）
   - 基础信息 + 核心数据表 + 知识来源记录
3. 更新 `../../data/index.md`

### Phase 8: 交互追问

输出完成后，追问：
- "需要深入分析某家公司吗？"
- "想从哪个维度进一步深挖？"
- "要把这个赛道分析写成文章吗？"（引导到 content-prod）
