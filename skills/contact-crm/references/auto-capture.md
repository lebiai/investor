# 自动捕获规则

> 定义从其他 skill 输出中自动提取联系人信息的规则。

## 触发来源

| 来源 skill | 触发时机 | 提取范围 |
|-----------|---------|---------|
| meeting-notes | 会议纪要完成 | 参会方、会议中提及的人名 |
| deal-review | 审阅完成 | 创始人、核心团队、FA联系人 |
| deal-sourcing | 扫描完成 | 发现的创业公司创始人 |
| sector-analysis | 赛道分析完成 | 行业专家、关键公司负责人 |

## 人名识别规则

从文本中识别可能的人名：

1. **上下文模式：**
   - "XX公司创始人张三"
   - "CEO李四说"
   - "和赵六聊了"
   - "经王五介绍"

2. **排除规则（不捕获的）：**
   - 知名公众人物/行业KOL（避免过度捕获）
   - 仅出现在历史数据中且无互动意图的

## Stub 档案格式

自动创建的 stub 仅含基本信息：

```yaml
---
type: contact
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [auto-captured, 来源skill]
source: contact-crm
name: 张三
company: （待补充）
title: （待补充）
role: unknown
status: stub  # stub / complete
---
# 【联系人】张三

## 捕获上下文
- 首次出现：YYYY-MM-DD | [来源skill] | [文件/上下文]
- 关联项目：[项目名]（如适用）

## 补充说明
> 自动捕获，信息不完整。下次见面时可以说"帮我把张三的信息补全"
```

## Stub 升级流程

当用户通过 Phase 1 主动补充信息时：
1. 读取现有 stub 档案
2. 补充完整信息
3. 修改 status 为 complete
4. 保留首次捕获上下文
