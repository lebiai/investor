# 知识库搜索协议

> 定义 agent 搜索知识库时的标准化流程，所有 skill 统一遵守。

## 核心原则

**先 rg 全文搜索，再用索引兜底。** 不反过来。

```
```
rg 搜索（毫秒级）→ 匹配 → 读内容
       ↓（不匹配）
索引表搜索 → 定位文件 → 读内容
       ↓（仍不匹配）
[skill:agent-reach] 外部搜索
```
```

## Phase 1: rg 全文搜索（最快路径）

对 data/ 或 personal-growth/ 下的全部 Markdown 文件进行全文搜索。

```
```bash
# 搜索所有文件
rg -i "关键词" data/ -l --md

# 限类型搜索
rg -i "关键词" data/sectors/ -l --md

# 搜索个人成长
rg -i "关键词" personal-growth/vault/ -l --md
```
```

**适用场景：** 用户明确提到公司名/赛道名/项目名/关键词。

**限制：** 用户说的是模糊概念（"那个评级很高的项目"）时可能不匹配。

## Phase 2: 索引表搜索（rg 不匹配时）

当 rg 没搜到或用户描述模糊时，按优先级扫描索引表：

| 优先级 | 索引文件 | 扫描内容 | 适用场景 |
|--------|---------|---------|---------|
| 1 | `data/index.md` | 赛道名 + 公司名 | 用户提到赛道/公司 |
| 2 | `data/deals/index.md` | 项目名 + 评级 + 赛道 | 用户提到审阅过的项目 |
| 3 | `data/watch/checklist.md` | 关注的条目 | 用户提到跟踪内容 |
| 4 | `data/file-index.md` | 文件名 + 分类 + 标签 | 用户提到文件 |
| 5 | `data/deals/patterns.md` | 模式名 | 用户提到特定模式 |
| 6 | `personal-growth/vault/timeline.md` | 洞察记录 | 用户提到个人见解 |

**扫描方式：** 读取索引表的 Markdown table，按列匹配。

```
```
例如 data/index.md 的赛道表：
rg "电解质" data/index.md
→ 匹配到：固态电池（标签列含"电解质"）
→ 读取：data/sectors/固态电池.md
```
```

## Phase 3: 外部搜索（知识库无结果时）

```
```bash
# 通过 agent-reach 搜索
[skill:agent-reach] 搜索：{关键词}
```
```

仅在前两阶段无结果时使用。

## 各 skill 搜索协议对照

| skill | Phase 1 搜索域 | Phase 2 索引 |
|-------|---------------|-------------|
| sector-analysis | data/sectors/ + data/companies/ | data/index.md |
| deal-review | data/deals/ + data/companies/ | data/deals/index.md |
| deal-sourcing | data/companies/ + data/sectors/ | data/index.md |
| content-prod | data/sectors/ + data/companies/ + data/file-index.md | data/index.md |
| research-digest | data/file-index.md + data/files/ | data/file-index.md |
| watch | data/watch/snapshots/ + data/watch/history.md | data/watch/checklist.md |
| personal-growth | personal-growth/vault/ + personal-growth/context/ | vault/timeline.md |



## Phase 3 降级：agent-reach 不可用时

当 `[skill:agent-reach]` 不可用（未安装/未注册/网络不通）时：

1. **告知用户**："agent-reach 不可用，搜索将使用公共搜索引擎降级"
2. **curl 公共搜索**按 SEARCH-SOURCES.md 的目标源执行：
   ```bash
   curl -s "https://www.baidu.com/s?wd={site:目标源 关键词}" -H "User-Agent: Mozilla/5.0"
   ```
3. **标记来源为** `[来源: 公共搜索]`（禁止标为 agent-reach）
4. **不阻塞任务**——公共搜索结果精度可能低于 agent-reach，但至少能获取信息

## 性能说明

- `rg` 搜索 1000 个 Markdown 文件 < 0.5 秒
- 读取索引表（< 100 行）约 1-2 次 AI 调用
- Phase 1 → Phase 2 → Phase 3 总耗时约 2-3 秒
- 不需要额外的搜索引擎或数据库
