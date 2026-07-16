---
name: investor-content-prod
version: 1.2.0
description: "基于知识库的内容生产。说'帮我写一篇关于[话题]的[体裁]'，自动找知识库素材+套模板+出稿"
---

# 内容产出

## 触发词

- "帮我写一篇关于[话题]的[体裁]"
- "把这个赛道分析写成文章"
- "生成为投委会备忘录" / "生成投资备忘录"
- "把这个审阅生成投资备忘录"
- "帮我发一篇小红书关于..."
- "写个朋友圈"

## 工作流

### Step 0: 来源检测

如果触发词包含"备忘录""投资备忘录""IC memo""投委会"，且当前上下文来自 deal-review 审阅：

1. 读取 deal-review 的输出数据（无需重新搜索知识库）
2. 直接跳转到 Step 3，加载 `references/template-library.md` 的"投委会备忘录（IC Memo）"模板
3. 模板自动填充 deal-review 各 phase 的数据
4. 无数据可填充的 section → 标注"待补充"
5. 进入 Step 4 质量检查 → Step 5 交付

### Step 1: 查知识库

搜索流程参考 `docs/SEARCH-PROTOCOL.md`。

1. **rg 全文搜索（Phase 1）：** `rg -i "{话题}" data/ -l --md`
   - 匹配到 sectors/companies/file-index 中的文件 → 读取
2. **索引表搜索（Phase 2）：** 如 rg 未匹配，查 `data/index.md` + `data/file-index.md`
3. **判断结果：**
   - 找到素材 → 输出清单让用户确认
   - 未找到素材 → "知识库中暂无[话题]相关素材，将通过 agent-reach 搜索获取信息"
     - 调用 [skill:agent-reach] 搜索（Phase 3）
4. 输出找到的素材清单给用户确认：
   ```
   已找到以下素材：
   - [赛道名] 赛道分析（YYYY-MM-DD）
   - [公司名] 公司档案
   - 相关研报 N 篇
   - [来源: agent-reach] 搜索结果 N 条
   需要用全部还是指定某个？
   ```

### Step 2: 定调

询问用户（或从已有上下文推断）：
1. 体裁（如未指定）：公众号/小红书/朋友圈/投资备忘录/路演纪要
2. 角度：行业趋势/龙头对比/投资机会/风险警示
3. 风格：专业严谨/通俗易懂/犀利观点

### Step 3: 内容生成

加载 `references/template-library.md` 对应体裁模板：
1. 按模板结构组织内容
2. 数据标注出处（"[来源：赛道分析 YYYY-MM-DD]" 或 "[来源: agent-reach]"）
3. 生成 3 个备选标题
4. 抽取 1-2 句金句（标🌟）

### Step 4: 质量检查

加载 `references/content-quality-gate.md` 逐项检查，不合格则修改。

### Step 5: 交付

内容直接输出在会话中供用户阅读。

输出格式：
```
## 标题备选
1. ...
2. ...
3. ...

---
（正文内容）
---

🌟 金句：...

📝 注：数据来源标注在文内 [出处]
```

### Step 6: 保存

自动保存到 `outputs/` 目录，保存完成后告知用户路径并尝试打开文件：
- 文件路径：`outputs/YYYY-MM-DD-标题.md`
