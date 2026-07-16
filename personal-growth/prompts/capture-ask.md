# 自动捕获规则

> 用于 agent 判断何时应该自动记录 context。不询问、不打断。

## 捕获条件

以下工作流完成时，自动追加一行到 `context/timeline.md`：

### sector-analysis 完成

```markdown
| {当前日期} | analysis | {赛道名} | 用户分析了{赛道名}赛道 | sector-analysis |
```

### deal-review 完成

```markdown
| {当前日期} | review | {项目名}, {赛道} | 用户审阅了{项目名}的{doc_type} | deal-review |
```

### deal-sourcing 完成

```markdown
| {当前日期} | scan | {领域名} | 用户扫描了{领域名}的新项目 | deal-sourcing |
```

### content-prod 完成

```markdown
| {当前日期} | write | {话题} | 用户写了关于{话题}的{体裁} | content-prod |
```

### research-digest 完成

```markdown
| {当前日期} | read | {文件名} | 用户处理了{文件名} | research-digest |
```

### watch 完成

```markdown
| {当前日期} | read | {条目名} | 用户查询了{条目名}动态 | watch |
```

## 不捕获的场景

- 用户说"帮我看看..."但中途取消
- 用户说"这个方案先放着"
- 用户做的工作和投资无关（如问天气、闲聊）
