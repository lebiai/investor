---
name: investor-watch
version: 1.2.0
description: "盯盘跟踪+每日简报。关注赛道/公司后，每次查询只输出变化的部分。说'今天有什么值得关注的'生成简报。"
---

# 盯盘跟踪

## 触发词

- "关注[赛道/公司]" — 加入 watch list，记录当前快照
- "[赛道/公司]有什么新动态" — 比对更新，输出变化
- "最近有什么值得关注的" / "今天有什么值得关注的" — 遍历所有已关注条目，生成每日简报
- "今日简报" / "早报" — 一键生成当日市场简报

## 数据来源

本 skill 的数据来源只有两类：

| 来源 | 调用方式 |
|------|---------|
| ① [skill:agent-reach] 搜索 | 获取最新动态 |
| ② data/ 知识库 | 读取快照 + 历史 + 公司/赛道档案 |

## 工作流

### 模式一：关注

用户说"关注[赛道/公司]"，搜索流程参考 `docs/SEARCH-PROTOCOL.md`：

1. **查 checklist：** 读取 `data/watch/checklist.md` → 是否已在列表中
2. 已在 → "已关注过，上次检查：YYYY-MM-DD"
3. 未在 →
   - **rg 全文搜索（Phase 1）：** `rg -i "{条目}" data/sectors/ data/companies/ -l --md`
   - **索引表搜索（Phase 2）：** 如 rg 未匹配，查 `data/index.md`
   - 如知识库中无该条目数据 → "知识库中暂无[条目]的数据，将首次通过 agent-reach 搜索获取当前快照"
   - 调用 [skill:agent-reach] 搜索获取当前信息作为初始快照
   - 写入快照到 `data/watch/snapshots/`
   - 更新 `data/watch/checklist.md` 追加一行
   - "已关注 [条目]（N家公司），有新动态随时问我"

### 模式二：查询动态

用户说"[赛道/公司]有什么新动态"：

1. 查 checklist 确认已关注，读取上次快照
2. 调用 `[skill:agent-reach]` 搜索最新信息
3. 加载 `references/snapshot-compare.md` 执行逐项比对
4. 输出变化摘要：

```
📋 [赛道] 动态追踪（上次检查：YYYY-MM-DD）

🔴 新发现（N条）
├── ...

🟡 变化（N条）
└── ...

✅ 其余N家无重大变化
```

5. 输出变化摘要（内容直接呈现在会话中）
6. 自动更新知识库（用户无需感知）：
   - 更新 `data/companies/` 对应档案
   - 更新 `data/sectors/` 对应档案
   - 写入 `data/watch/history.md`（格式参考 DATA-STANDARD.md 表格追加）
   - 写入新快照 `data/watch/snapshots/[条目]_YYYYMMDD.md`（格式参考 §3.4）

### 模式三：全局一览

用户说"最近有什么值得关注的"：

1. 读取 `data/watch/checklist.md`
2. 如索引为空 → "📭 尚未关注任何条目，说'关注[赛道/公司]'开始盯盘"
3. 如有条目 → 遍历每个条目，按模式二执行
4. 汇总：

```
📋 全局动态（共关注 N 个条目）

🔴 [赛道/公司] — 变化摘要
✅ [赛道/公司] — 无变化
✅ [赛道/公司] — 无变化
```
