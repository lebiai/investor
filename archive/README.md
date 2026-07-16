# Archive — 技能版本存档

> 仅存档技能（skills/）的历史版本。工具脚本和配置文件通过 CHANGELOG 记录，不存档。

## 结构

```
archive/
├── README.md              ← 本文件
├── legacy/               ← 旧版全量存档（v1.0.0 ~ v2.1.1），只读不修改
└── skills/               ← 技能组件独立版本存档
    ├── sector-analysis/
    │   ├── v1.0.0/       ← 第1版
    │   └── v1.1.0/       ← 第2版
    ├── deal-review/
    │   └── v1.0.0/
    └── ...
```

## 存档方式

修改技能前运行：

```bash
bash tools/archive.sh skill <技能名>
```

工具脚本和配置文件改完直接在 CHANGELOG 记录，不存档。
