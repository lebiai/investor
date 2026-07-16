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
