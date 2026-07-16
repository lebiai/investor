---
name: investor-deal-review
version: 1.0.0
description: "超级投资人审阅引擎。上传BP/路演材料/Term Sheet/财务模型等，六角色独立评估→跨角色辩论→输出立体审阅包+尽调路线图"
---

# 项目审阅

## 触发词

- "帮我看看这个BP" / "审阅这个BP"
- "评估一下这个项目"
- "看看这个路演材料" / "看看这份Term Sheet"
- "分析一下这个商业计划书"
- "审阅这份[文档类型]"

## 数据来源

本 skill 的数据来源：

| 来源 | 调用方式 | 说明 |
|------|---------|------|
| ① 用户上传文档 | 直接接收用户提供的文件 | BP/Pitch Deck/TS/财务模型/尽调报告等 |
| ② [skill:agent-reach] 搜索 | 使用 agent-reach 获取互联网数据（`[skill:agent-reach]`） | 各角色独立调用补充知识 |
| ③ `data/` 知识库 | 直接读取本地 data/ 目录下的文件 | sectors/ companies/ 历史数据 |
| ④ `data/deals/` 历史案例 | 读取历史审阅记录 | 越用越聪明——模式匹配 + 案例引用 |

## 前置条件

用户必须提供文件（BP/路演材料/TS等），否则无法执行审阅。
支持格式：PDF / PPT / Word / Excel / 图片（通过 [skill:research-digest] 转换为 MD）。

## 工作流

### Phase 1: 文档分类 [来源: ①用户上传]

加载 `references/classifier.md`：
1. 判断文档类型：BP / Pitch Deck / Term Sheet / 财务模型 / 尽调报告 / 竞品分析 / 其他
2. 输出："识别为[类型]，将按对应框架审阅"
3. 如无法识别 → 告知用户"文档类型不明确，将按通用框架审阅"

### Phase 2: 结构化提取 [来源: ①用户上传]

加载 `references/extraction.md`：
1. 按文档类型加载对应的提取模板
2. 提取核心数据：团队 / 市场 / 产品 / 财务 / 融资
3. 输出提取摘要让用户确认或补充

### Phase 3: 六角色辩论审阅 ⭐ [来源: ②agent-reach搜索 + ③知识库 + ④历史案例]

加载 `references/debate-engine.md`，执行六角色独立评估 + 交叉批驳。
每个角色的知识库搜索遵循 `docs/SEARCH-PROTOCOL.md`：

① 行业研究员 → 先 rg 搜索赛道数据，再用 [skill:agent-reach] 补充
② 财务分析师 → 先 rg 搜索可比公司财务数据，再用 [skill:agent-reach] 补充
③ 风控官 → 先 rg 搜索风险记录 + patterns，再用 [skill:agent-reach] 补充
④ 产业资本 → 先 rg 搜索公司档案，再用 [skill:agent-reach] 补充
⑤ 竞争对手 → 先 rg 搜索竞品信息，再用 [skill:agent-reach] 补充
⑥ 投委会主席 → 综合前五者输出 + 检索 `data/sectors/`

每个角色输出统一格式：判断 + 评分 + 置信度 + 疑问 + 对其他角色的批驳。

### Phase 4: 竞品基线 [来源: ③知识库]

加载 `references/competitive-baseline.md`：
1. 与 `data/companies/` 中同类公司横向对比
2. 与 `data/deals/` 中类似审阅项目对比

### Phase 5: 创始人穿透 ⭐ [来源: ①用户上传 + ②agent-reach搜索]

加载 `references/founder-insight.md`：
1. 从文档中提取创始人相关信号
2. 使用 [skill:agent-reach] 搜索创始人背景补充
3. 输出创始人评估矩阵

### Phase 6: 估值交叉验证 [来源: ②agent-reach搜索 + ③知识库]

加载 `references/valuation-crosscheck.md`：
1. 可比公司法 — 使用 [skill:agent-reach] 搜索可比公司估值
2. 近期交易法 — 搜索同赛道近期融资估值
3. 如有财务预测 → DCF 敏感度分析
4. 输出估值区间

### Phase 7: 尽调路线图 [来源: 综合]

加载 `references/diligence-roadmap.md`：
1. 根据上述所有阶段的产出
2. 生成动态尽调路线图：先查什么 / 再查什么 / 核心追问
3. 追问清单（给创始人的 N 个问题）

### Phase 8: 输出完整审阅包 [来源: 综合①-⑦]

加载 `references/memo-framework.md`，按规范生成并输出在会话中：（Phase 3 信号识别依赖 signal-library.md 的 40+ 内置模式）

```
📋 [项目名] — 投资审阅报告

Layer 1: 5 分钟速览
├── 一句话定位
├── 核心数据
├── 推荐评级

Layer 2: 完整评估
├── 六角色评分雷达
├── 信号表（🔴/🟢/🟡/⚪）
├── 估值区间

Layer 3: 行动指引
├── 跟进建议（推进 / 观望 / 放弃）
├── 尽调路线图
├── 追问清单

Layer 4: 组合视角
├── 竞品基线对比
├── 赛道阶段匹配度
```

**输出方式：** 四层内容直接呈现在对话中，用户可当场追问或跳到跟进步骤。

### Phase 9: 知识库入库 [来源: ③知识库 + ④历史案例]

自动更新知识库（用户无需感知）：

1. 写入 `data/deals/[YYYYMMDD]_[项目名].md`
   - 格式参考 `docs/DATA-STANDARD.md` §3.3：YAML header（type: deal-review）+ 正文
2. 更新 `data/deals/index.md`（格式见 §2.3：新增 type/文档类型/标签/来源 列）
3. 如发现新模式 → 追加到 `data/deals/patterns.md`（格式见 §2.6：新增 首现日期/最近出现/出现次数/类型/来源 列）
4. 更新 `data/companies/` 对应档案（如已建档）
5. 更新 `data/index.md`
