# 投资人搜索源配置

> 定义各类型信息的目标搜索源。所有 skill 统一遵守。
> 通用网站搜索走 curl 公共搜索（免费、无需 key）。
> 平台专用搜索走 agent-reach（B站/GitHub/RSS/Jina Reader）。

## 核心原则

| 搜索场景 | 方式 | 说明 |
|---------|------|------|
| 通用网站搜索（site:xxx.com） | curl 公共搜索 | 搜 36氪/东方财富/知乎等，直接 curl Bing/Baidu |
| 平台专用搜索 | agent-reach | B站搜索、GitHub 搜索、RSS 读取 |
| 读取网页全文 | Jina Reader | `curl -s "https://r.jina.ai/URL"` |

## 一、一级市场（创业投资）

| 信息需求 | 目标源 | 搜索方式 |
|---------|-------|---------|
| 创业公司融资首发 | 36氪 | curl 搜索 `site:36kr.com 融资 关键词` |
| 投资机构动态 | 投资界 | curl 搜索 `site:pedaily.cn 关键词` |
| 公司融资数据库 | IT桔子 | curl 搜索 `site:itjuzi.com 关键词` |
| 创业公司报道 | 猎云网/亿欧 | curl 搜索 `site:lieyunwang.com 关键词` |
| 公司工商/股权 | 天眼查/企查查 | curl 搜索 `天眼查 公司名 股权` |
| 医疗赛道项目 | 动脉网 | curl 搜索 `site:vbdata.cn 关键词` |
| 项目数据/FA | 鲸准/烯牛数据 | curl 搜索 `site:jingdata.com 关键词` |

## 二、二级市场（A股/港股/美股）

| 信息需求 | 目标源 | 搜索方式 |
|---------|-------|---------|
| 投资者讨论、深度 | 雪球 | curl 搜索 `site:xueqiu.com 关键词` |
| 公司公告 | 巨潮资讯 | curl 搜索 `site:cninfo.com.cn 公司名 公告` |
| 财经综合资讯 | 东方财富/新浪财经 | curl 搜索 `site:eastmoney.com 关键词` |
| 快讯/即时资讯 | 财联社/华尔街见闻 | curl 搜索 `site:cls.cn 关键词` |
| 港股/美股资讯 | 格隆汇/智通财经 | curl 搜索 `site:gelonghui.com 关键词` |
| 券商研报 | 东方财富研报 | curl 搜索 `site:data.eastmoney.com/report 关键词` |
| 宏观/政策解读 | 第一财经/21经济 | curl 搜索 `site:yicai.com 关键词` |

## 三、行业研究

| 信息需求 | 目标源 | 搜索方式 |
|---------|-------|---------|
| 互联网/科技行业报告 | 艾瑞咨询 | curl 搜索 `site:iresearch.cn 行业名` |
| 各行业研究报告 | 前瞻网/中商网 | curl 搜索 `site:qianzhan.com 行业名` |
| 行业深度洞察 | 头豹/亿欧 | curl 搜索 `site:leadleo.com 行业名` |
| 全球行业数据 | Fortune BI/Grand View | curl 搜索 `site:fortunebusinessinsights.com 关键词` |
| 科技媒体分析 | 虎嗅/界面 | curl 搜索 `site:huxiu.com 关键词` |
| 全球创业/科技 | TechCrunch/Crunchbase | curl 搜索 `site:techcrunch.com 关键词` |

## 四、政策与监管

| 信息需求 | 目标源 | 搜索方式 |
|---------|-------|---------|
| 国务院政策 | 政府网 | curl 搜索 `site:gov.cn 政策名` |
| 发改委 | 发改委 | curl 搜索 `site:ndrc.gov.cn 关键词` |
| 工信部 | 工信部 | curl 搜索 `site:miit.gov.cn 关键词` |
| 证监会 | 证监会 | curl 搜索 `site:csrc.gov.cn 政策名` |
| 科技部 | 科技部 | curl 搜索 `site:most.gov.cn 关键词` |
| 地方政府政策 | 政府网 | curl 搜索 `site:gov.cn 省/市 政策名` |

## 五、消费趋势与舆情

| 信息需求 | 目标源 | 搜索方式 |
|---------|-------|---------|
| 消费口碑、趋势 | 小红书 | agent-reach 小红书搜索（需浏览器登录态） |
| 行业深度讨论 | 知乎 | curl 搜索 `site:zhihu.com 关键词` |
| 商业深度报道 | 晚点/LatePost | curl 搜索 `site:latepost.com 关键词` |

## 六、技术与专利

| 信息需求 | 目标源 | 搜索方式 |
|---------|-------|---------|
| 开源项目评估 | GitHub | agent-reach GitHub 搜索 |
| 学术论文 | arXiv | curl 搜索 `site:arxiv.org 关键词` |
| 专利查询 | Google Patents | curl 搜索 `site:patents.google.com 关键词` |

## 七、国际对标

| 信息需求 | 目标源 | 搜索方式 |
|---------|-------|---------|
| 全球财经 | Bloomberg/Reuters | curl 搜索 `site:bloomberg.com 关键词` |
| 全球PE/VC数据 | Crunchbase | curl 搜索 `site:crunchbase.com 关键词` |
| 研究报告 | Gartner | curl 搜索 `site:gartner.com 关键词` |

## curl 搜索命令参考

```bash
# Bing 搜索（推荐，中文首选）
curl -s "https://www.bing.com/search?q=关键词&count=10" \
  -H "User-Agent: Mozilla/5.0"

# 站点限定
curl -s "https://www.bing.com/search?q=site:36kr.com+关键词&count=10" \
  -H "User-Agent: Mozilla/5.0"

# 百度搜索（备选）
curl -s "https://www.baidu.com/s?wd=关键词&rn=10" \
  -H "User-Agent: Mozilla/5.0"
```

## 搜索执行规则

### 多源并行

同一需求同时搜 2-3 个目标源：

```
搜索"固态电池"
并行：
  ├→ curl site:36kr.com 固态电池 融资
  ├→ curl site:qianzhan.com 固态电池
  └→ curl site:cls.cn 固态电池
```

### 来源标注

| 实际使用的搜索方式 | 标注标签 |
|-------------------|---------|
| curl Bing/Baidu 搜索 | `[来源: 36氪 via 公共搜索]` |
| agent-reach 平台搜索 | `[来源: 小红书 via agent-reach]` |
| Jina Reader 读网页 | `[来源: Jina Reader]` |

### 降级

所有搜索方式都不需 API Key。如果 curl 不通：

```
→ 告知用户：当前环境网络受限，实时搜索不可用
→ 知识库中有相关档案吗？
```
