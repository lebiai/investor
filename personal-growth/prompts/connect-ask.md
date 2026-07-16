# 智能连接规则

> 任何 skill 工作流输出完成后，在追问之前，自动检查 vault 中是否有相关记录。
> 不是通知、不是打断，是 1 行的轻量提示，可忽略。

## 触发场景

| skill 完成 | 搜索关键词（vault 中） | 连接依据 |
|-----------|----------------------|---------|
| sector-analysis（固态电池） | rg "固态电池" vault/timeline.md | 赛道名 |
| deal-review（XX科技） | rg "XX" + rg "固态电池" vault/timeline.md | 项目名 + 赛道 |
| deal-sourcing（固态电池领域） | rg "固态电池" vault/timeline.md | 领域名 |
| content-prod（关于固态电池） | rg "固态电池" vault/timeline.md | 话题 |

## 执行流程

```
Step 1: 确定搜索关键词
  - 从用户当前操作的上下文提取核心关键词（赛道名/公司名/领域名）
  
Step 2: rg 搜索 vault
  rg -i "{关键词}" personal-growth/vault/timeline.md
  
Step 3: 有匹配
  - 匹配到 1 条："你的 insights 库里有一条相关记录（{来源}）：{摘要}，要看吗？"
  - 匹配到多条："你的 insights 库里有 N 条相关记录（{来源1}、{来源2}...），要看吗？"
  用户说"好" → 读取 vault/entries/{id}.md 输出
  用户说"不用"或忽略 → 跳过

Step 4: 无匹配
  - 不提示，直接继续追问阶段
```

## 注意事项

- **轻量**：1 行，可忽略。用户不说话直接继续。
- **不打断图工作流**：在问答阶段之前、追问阶段之后。
- **vault 无数据时不提示**：系统首次使用、vault 为空时，跳过此步骤。
