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

1. 查 `../../data/sectors/` 是否有该赛道的历史分析记录
2. 如有 → 输出"上次分析过该赛道（YYYY-MM-DD），新信息已合并"
3. 查 `../../data/companies/` 中已有相关公司

### Phase 2: 六维赛道分析

加载 `references/analysis-framework.md`，逐个维度执行：
1. 使用 web search 获取该维度的最新公开数据
2. 每个维度输出评分（1-10）+ 核心判断 + 辩论触发点标注
3. 每一条数据标注来源，按可靠性分级（详见 analysis-framework.md）

### Phase 3: 六机构独立评估

加载 `references/institutions.md`，按六家机构的人设逐家输出：
1. 每家输出核心观点（3-5 句话）
2. 每家输出吸引力评分（1-10）
3. 如用户有风格偏好 → 相应调整权重

### Phase 4: 公司层扫描

加载 `references/company-scan.md`：
1. 使用 web search 获取赛道内的上市公司数据（优先财报/行情）
2. 使用 web search 获取未上市公司融资信息（优先公开报道）
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
