# VSCode 语法高亮 - 优先级处理指南

## 🎯 核心原则

在 TextMate 语法中，优先级由以下因素决定：

### 1. **模式顺序（最重要）**
- **先定义的模式优先匹配**
- 将最具体、最严格的模式放在前面
- 将最宽泛、最通用的模式放在后面

### 2. **正则表达式精确度**
- 更精确的正则表达式优先
- 使用锚点（`^` `$`）提高精确度
- 使用否定前瞻/后顾增加约束

## 📋 你的语法示例

```
abc=/dd/sd/1234          # 关键符: =
efg=a,b,c                # 关键符: =
jao==/ddd/asd/dw.png=>   # 关键符: == 和 =>
abc="hello";<==>abc="hello-aa";  # 关键符: <==>
```

## 🔧 优先级设置策略

### 原则：从具体到宽泛

```
优先级 1（最高）: <==>  （最具体，包含最多字符）
优先级 2:        ==>   （较具体）
优先级 3:        ==    （中等具体）
优先级 4（最低）: =     （最宽泛）
```

### 实现方式

```json
{
  "patterns": [
    {
      "comment": "优先级 1: 最具体的模式",
      "include": "#bidirectional-assignment"  // <==>
    },
    {
      "comment": "优先级 2: 次具体的模式",
      "include": "#double-equal-arrow"  // ==>
    },
    {
      "comment": "优先级 3: 中等模式",
      "include": "#double-equal"  // ==
    },
    {
      "comment": "优先级 4: 最宽泛的模式",
      "include": "#single-equal"  // =
    }
  ]
}
```

## 🎨 详细实现

### 1. 双向赋值（最高优先级）

```json
"bidirectional-assignment": {
  "patterns": [
    {
      "name": "meta.bidirectional-assignment",
      "match": "^\\s*([a-zA-Z_][a-zA-Z0-9_]*)\\s*(=)\\s*(\"[^\"]*\")\\s*(;)\\s*(<==>)\\s*([a-zA-Z_][a-zA-Z0-9_]*)\\s*(=)\\s*(\"[^\"]*\")\\s*(;)\\s*$",
      "captures": {
        "5": {
          "name": "keyword.operator.bidirectional"  // <==> 高亮
        }
      }
    }
  ]
}
```

**匹配：** `abc="hello";<==>abc="hello-aa";`

**关键点：**
- 使用 `^` 和 `$` 锚定整行
- 精确匹配 `<==>` 的完整上下文
- 包含前后的 `=` 和 `;`

### 2. 双等号加箭头（次高优先级）

```json
"double-equal-arrow": {
  "patterns": [
    {
      "name": "meta.double-equal-arrow",
      "match": "^\\s*([a-zA-Z_][a-zA-Z0-9_]*)\\s*(==)\\s*([^=\\s]+)\\s*(=>)\\s*$",
      "captures": {
        "2": {
          "name": "keyword.operator.double-equal"  // ==
        },
        "4": {
          "name": "keyword.operator.arrow"  // =>
        }
      }
    }
  ]
}
```

**匹配：** `jao==/ddd/asd/dw.png=>`

**关键点：**
- `[^=\\s]+` 避免匹配包含更多 `=` 的内容
- 同时匹配 `==` 和 `=>`

### 3. 双等号（中等优先级）

```json
"double-equal": {
  "patterns": [
    {
      "name": "meta.double-equal",
      "match": "^\\s*([a-zA-Z_][a-zA-Z0-9_]*)\\s*(==)\\s*(.+)\\s*$",
      "captures": {
        "2": {
          "name": "keyword.operator.double-equal"
        }
      }
    }
  ]
}
```

**匹配：** `xxx==value`（如果不匹配前面的模式）

### 4. 单等号（最低优先级）

```json
"single-equal": {
  "patterns": [
    {
      "comment": "路径赋值",
      "match": "^\\s*([a-zA-Z_][a-zA-Z0-9_]*)\\s*(=)\\s*(/[^\\s]+)\\s*$",
      "captures": {
        "2": {
          "name": "keyword.operator.assignment"
        },
        "3": {
          "name": "string.unquoted.path"
        }
      }
    },
    {
      "comment": "列表赋值",
      "match": "^\\s*([a-zA-Z_][a-zA-Z0-9_]*)\\s*(=)\\s*([a-zA-Z_][a-zA-Z0-9_,]*)\\s*$",
      "captures": {
        "2": {
          "name": "keyword.operator.assignment"
        }
      }
    }
  ]
}
```

**匹配：** 
- `abc=/dd/sd/1234`
- `efg=a,b,c`

## 🚫 常见错误

### ❌ 错误：宽泛模式在前

```json
{
  "patterns": [
    {"include": "#single-equal"},    // 太宽泛，会匹配所有
    {"include": "#double-equal"},    // 永远不会被执行
    {"include": "#bidirectional"}    // 永远不会被执行
  ]
}
```

### ✅ 正确：具体模式在前

```json
{
  "patterns": [
    {"include": "#bidirectional"},   // 最具体
    {"include": "#double-equal"},    // 较具体
    {"include": "#single-equal"}     // 最宽泛
  ]
}
```

## 🛡️ 防止误匹配的技巧

### 1. 使用否定前瞻（Negative Lookahead）

```json
{
  "comment": "匹配 = 但不是 == 或 ===",
  "match": "([a-zA-Z_][a-zA-Z0-9_]*)\\s*(=)(?!=)\\s*(.+)",
  "captures": {
    "2": {"name": "keyword.operator.assignment"}
  }
}
```

**说明：** `(?!=)` 确保 `=` 后面不是另一个 `=`

### 2. 使用否定后顾（Negative Lookbehind）

```json
{
  "comment": "匹配 = 但前面不是 <",
  "match": "([a-zA-Z_][a-zA-Z0-9_]*)\\s*(?<!<)(=)\\s*(.+)",
  "captures": {
    "2": {"name": "keyword.operator.assignment"}
  }
}
```

**说明：** `(?<!<)` 确保 `=` 前面不是 `<`

### 3. 精确匹配整个模式

```json
{
  "comment": "完整匹配 <==> 结构",
  "match": "^(.+?)(<==>)(.+?)$",
  "captures": {
    "2": {"name": "keyword.operator.bidirectional"}
  }
}
```

## 📊 优先级决策树

```
遇到包含 = 的行
├─ 包含 <===> ？
│  ├─ 是 → 使用 bidirectional-assignment 模式
│  └─ 否 ↓
├─ 包含 ==> ？
│  ├─ 是 → 使用 double-equal-arrow 模式
│  └─ 否 ↓
├─ 包含 == ？
│  ├─ 是 → 使用 double-equal 模式
│  └─ 否 ↓
└─ 包含 = ？
   └─ 是 → 使用 single-equal 模式
```

## 🔍 调试优先级问题

### 步骤 1：检查模式顺序

查看 `patterns` 数组中的顺序是否从具体到宽泛。

### 步骤 2：使用 VSCode 调试工具

1. 打开测试文件
2. 按 `Ctrl/Cmd + Shift + P`
3. 输入 `Developer: Inspect Editor Tokens and Scopes`
4. 点击文本查看应用了哪个 scope

### 步骤 3：测试边界情况

```
# 测试文件
abc=/dd/sd/1234                      # 应该匹配 single-equal
efg=a,b,c                            # 应该匹配 single-equal
jao==/ddd/asd/dw.png=>              # 应该匹配 double-equal-arrow
abc="hello";<==>abc="hello-aa";     # 应该匹配 bidirectional
test==value                          # 应该匹配 double-equal
```

### 步骤 4：逐个禁用模式测试

临时注释掉某些模式，看是否影响其他模式的匹配。

## 💡 最佳实践

### 1. 明确的命名

```json
{
  "patterns": [
    {"include": "#most-specific-pattern"},
    {"include": "#medium-specific-pattern"},
    {"include": "#least-specific-pattern"}
  ]
}
```

### 2. 添加注释说明优先级

```json
{
  "patterns": [
    {
      "comment": "PRIORITY 1: Bidirectional assignment with <==>",
      "include": "#bidirectional"
    },
    {
      "comment": "PRIORITY 2: Arrow assignment with ==>",
      "include": "#arrow"
    }
  ]
}
```

### 3. 使用锚点限定范围

```json
{
  "match": "^\\s*keyword\\s*$",  // 只匹配整行为 keyword 的情况
  "match": "\\bkeyword\\b"       // 匹配单词边界的 keyword
}
```

### 4. 分组相似模式

```json
{
  "repository": {
    "assignment-operators": {
      "patterns": [
        {"include": "#complex-assignment"},
        {"include": "#simple-assignment"}
      ]
    }
  }
}
```

## 🎓 总结

**优先级控制的黄金法则：**

1. ✅ **从具体到宽泛** - 最严格的模式放最前
2. ✅ **使用锚点** - `^` `$` `\b` 限定匹配范围
3. ✅ **使用否定断言** - `(?!...)` `(?<!...)` 排除不想要的匹配
4. ✅ **测试边界情况** - 确保所有情况都被正确处理
5. ✅ **添加注释** - 说明每个模式的用途和优先级

**检查清单：**

- [ ] 模式是否按从具体到宽泛排序？
- [ ] 每个模式是否有明确的匹配范围？
- [ ] 是否有模式会意外匹配其他模式的内容？
- [ ] 是否所有边界情况都被覆盖？
- [ ] 是否添加了足够的注释说明？


### 需要添加自定义颜色配置
~/.config/Code/User/settings.json
```json
"editor.tokenColorCustomizations": {
      "textMateRules": [
      {
        "scope": "keyword.operator.bidirectional.priority",
        "settings": {
          "foreground": "#C586C0"
        }
      },
      {
        "scope": "keyword.operator.arrow.priority",
        "settings": {
          "foreground": "#B5CEA8",
          "fontStyle": "bold"
        }
      },
      {
        "scope": "constant.other.list-item.priority",
        "settings": {
          "foreground": "#4FC1FF"
        }
      }
      ]
}
```