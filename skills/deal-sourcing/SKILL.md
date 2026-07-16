---
name: investor-deal-sourcing
version: 1.2.0
description: "项目sourcing。说'帮我扫描[领域]的项目'，查知识库+实时搜索→输出项目清单+跟进建议"
---

# 项目扫描

## 触发词

- "帮我扫描一下[领域]的新项目"
- "[领域]有什么好项目"
- "这个方向有哪些标的"
- "最近[领域]有什么融资"

## 数据来源

本 skill 的数据来源：

| 来源 | 说明 |
|------|------|
| ① agent-reach 搜索 | 新融资/新项目/估值等实时信息 |
| ② data/ 知识库 | 已有项目档案和历史记录 |

## 工作流

### Step 1: 查知识库 [来源: ②知识库]

搜索流程参考 `docs/SEARCH-PROTOCOL.md`。
加载 `references/scan-protocol.md`：
1. **rg 全文搜索（Phase 1）：** `rg -i "{领域}" data/ -l --md`
   - 匹配到 sectors/ 或 companies/ 中的文件 → 直接读取
2. **索引表搜索（Phase 2）：** 如 rg 未匹配，查 `data/index.md`
   - 查赛道表 + 公司表
3. **无结果：** → "该领域尚无已建档项目，将完全依赖实时搜索获取"

### Step 2: 实时扫描 [来源: ①agent-reach搜索]

使用 [skill:agent-reach] 执行搜索：

```
搜索覆盖：
1. 最近 3-6 个月该领域的融资事件
2. 新入局者 / 跨界玩家
3. 产业资本 + 财务资本布局

### Step 3: 输出项目清单

内容直接输出在会话中供用户阅读：
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

### Step 4: 知识库入库 [来源: ②知识库]

自动更新知识库（用户无需感知）：

1. 新项目写入 `data/companies/`
   - 格式参考 `docs/DATA-STANDARD.md` §3.2：YAML header（type: company）+ 正文
   - 内容参考 `references/project-template.md`
2. 更新 `data/sectors/` 对应条目
3. 更新 `data/index.md`（公司表追加，格式见 §2.1）

### Step 5: 同步到盯盘 [→ watch 接口]

自动将扫描领域加入 watch list（用户无需感知）：

1. 检查 `data/watch/checklist.md` 中是否已有该领域
2. 已有 → 跳过，不重复添加
3. 未有 →
   - 在 `data/watch/checklist.md` 追加一行：
     ```
     | [领域] | 项目扫描 | YYYY-MM-DD | YYYY-MM-DD | 0 | deal-sourcing |
     ```
   - 在 `data/watch/snapshots/` 写入首次快照：
     - 内容来源：本扫描的 Step 2 实时搜索结果
     - 文件格式：`[领域]_YYYYMMDD.md`（含 YAML header type: watch-snapshot）
4. 告知用户："该领域已自动加入盯盘，有新动态随时问我"

**接口契约：** deal-sourcing 写入 watch checklist，但不读取或修改 watch 的 snapshots/ 和 history/。watch 的增量比对逻辑由 watch skill 独立维护。
