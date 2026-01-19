
# 键值对配置语法 - VSCode 语法高亮
### Dralee Key Value Config
键值对配置语法

支持多行值

## 📋 语法格式

### 基本格式

```
键名: 值
```

### 多行值格式

```
键名: 第一行内容
这是第二行内容（延续行）
这是第三行内容（延续行）
```

**规则：**
- 带 `:` 的行是新的键值对
- 不带 `:` 的行是上一个值的延续

## 📝 完整示例

### 示例 1：基本用法

```ini
# 基本键值对
xxx: asdfsd
sdww: xcxxcxc
dwqfisadf: xcasfd
this is the multiline item
xxx: this the single item
```

**解析结果：**
```
键: xxx
值: asdfsd

键: sdww
值: xcxxcxc

键: dwqfisadf
值: xcasfd
this is the multiline item

键: xxx
值: this the single item
```

### 示例 2：多行值

```ini
# 单行值
name: John Doe

# 多行值
description: This is the first line
This is the second line
This is the third line

# 下一个键值对
status: active
```

### 示例 3：混合使用

```ini
# 配置文件

# 基本信息
title: My Application
version: 1.0.0

# 详细描述（多行）
description: This application provides
a comprehensive solution for
managing your data efficiently

# 作者信息
author: John Doe
email: john@example.com

# 长文本（多行）
readme: Welcome to the application!
Here are the main features:
- Feature 1
- Feature 2
- Feature 3

# 单行配置
debug: true
port: 8080
```

### 示例 4：带注释

```ini
# ==========================================
# 应用配置
# ==========================================

# 应用名称
app_name: MyApp

# 应用描述
app_description: A powerful application
for data processing and analysis
with advanced features

# 服务器配置
server_host: localhost
server_port: 3000

# 数据库连接
database_url: postgresql://localhost/mydb
```

### 示例 5：带引号的值

```ini
# 字符串值
simple_text: hello world

# 带引号的值
quoted_text: "This is a quoted string"
single_quoted: 'Another quoted string'

# 包含特殊字符
path: "C:\\Users\\Name\\Documents"
url: 'https://example.com'

# 多行带引号
message: "This is line one
and this continues"
```

## 🎨 高亮效果

| 元素 | 示例 | 颜色 | Scope |
|------|------|------|-------|
| **键名** | `xxx` | 蓝色 | `variable.other.key` |
| **冒号** | `:` | 默认 | `punctuation.separator.colon` |
| **单行值** | `asdfsd` | 橙色 | `string.unquoted.value` |
| **延续行** | `this is the multiline item` | 橙色 | `string.unquoted.continuation` |
| **双引号字符串** | `"text"` | 橙色 | `string.quoted.double` |
| **单引号字符串** | `'text'` | 橙色 | `string.quoted.single` |
| **注释** | `# comment` | 灰色 | `comment.line` |

## 🔧 语法规则详解

### 1. 键值对识别

```regex
^([a-zA-Z_][a-zA-Z0-9_]*)(\\s*)(:)(\\s*)(.*)$
```

**匹配：**
- `^` - 行首
- `([a-zA-Z_][a-zA-Z0-9_]*)` - 键名（字母或下划线开头）
- `\\s*` - 可选空白
- `:` - 冒号分隔符
- `\\s*` - 可选空白
- `(.*)` - 值（该行剩余内容）

**示例：**
```ini
name: John Doe
  ↑   ↑  ↑
  键  :  值
```

### 2. 延续行识别

```regex
^(?![a-zA-Z_][a-zA-Z0-9_]*\\s*:)(?!\\s*#)(.+)$
```

**匹配：**
- `^` - 行首
- `(?![a-zA-Z_][a-zA-Z0-9_]*\\s*:)` - **不是**键值对格式
- `(?!\\s*#)` - **不是**注释
- `(.+)` - 任何非空内容

**示例：**
```ini
description: First line
Second line          ← 延续行（没有冒号）
Third line           ← 延续行
```

### 3. 注释识别

```regex
^\\s*#.*$
```

**匹配：**
- `^\\s*` - 行首可选空白
- `#` - 井号
- `.*` - 任何内容到行尾

## 💡 使用场景

### 场景 1：配置文件

```ini
# 服务器配置
host: localhost
port: 8080
max_connections: 100

# 日志配置
log_level: INFO
log_file: /var/log/app.log
```

### 场景 2：元数据

```ini
title: My Document
author: John Doe
date: 2024-01-16
tags: important, draft, review

abstract: This document describes
the implementation of a new feature
that will improve system performance
```

### 场景 3：多语言内容

```ini
en_title: Welcome
en_description: This is the English version
of the application

zh_title: 欢迎
zh_description: 这是应用程序的
中文版本
```

### 场景 4：模板定义

```ini
template_name: Email Notification
template_subject: New Message
template_body: Hello {{name}},
You have received a new message:
{{message}}
Please check your account.
```

## 🚨 常见问题

### Q1: 如何区分延续行和新的键值对？

**规则：**
- ✅ 包含 `:` → 新的键值对
- ✅ 不包含 `:` → 延续行

```ini
# ✅ 正确
key1: value1
continuation line
key2: value2

# ❌ 如果要在值中使用冒号，用引号
key3: "value: with colon"
```

### Q2: 延续行的缩进重要吗？

**不重要。** 缩进会被保留为值的一部分：

```ini
key: first line
  indented line      # 保留缩进
    more indented    # 保留缩进
no indent            # 无缩进
```

**解析结果：**
```
key = "first line\n  indented line\n    more indented\nno indent"
```

### Q3: 空行如何处理？

**空行会中断延续：**

```ini
key1: line 1
line 2

line 3           # ❌ 这不属于 key1（中间有空行）
```

**如果要包含空行，使用引号或特殊标记：**

```ini
key1: "line 1
line 2

line 3"          # ✅ 引号内可以有空行
```

### Q4: 如何处理特殊字符？

**使用引号：**

```ini
# 包含冒号
url: "https://example.com:8080"

# 包含井号
tag: "#important"

# 包含引号（需要转义）
quote: "He said \"Hello\""

# 路径
path: "C:\\Users\\Name"
```

## 🎯 最佳实践

### 1. 命名规范

```ini
# ✅ 推荐：使用下划线分隔
app_name: MyApp
server_port: 8080
database_url: localhost

# ❌ 不推荐：驼峰式（不符合语法）
appName: MyApp     # ❌ 大写字母可能不支持
```

### 2. 注释规范

```ini
# ===== 模块注释 =====
# 使用分隔线标识模块

# 配置项注释
key: value

# 多行注释
# 这个配置项用于...
# 它支持以下选项...
key: value
```

### 3. 多行值格式

```ini
# 推荐：清晰的多行格式
description: First line of description
Second line with more details
Third line with additional information

# 推荐：使用缩进提高可读性
message: Welcome to the application!
  Please follow these steps:
  1. Configure your settings
  2. Start the service
  3. Check the logs
```

### 4. 分组组织

```ini
# ==========================================
# 服务器配置
# ==========================================
server_host: localhost
server_port: 8080
server_timeout: 30

# ==========================================
# 数据库配置
# ==========================================
db_host: localhost
db_port: 5432
db_name: mydb
```

## 🔍 调试技巧

### 使用 Token Inspector

1. 打开测试文件
2. `Ctrl/Cmd + Shift + P`
3. 输入 "Developer: Inspect Editor Tokens and Scopes"
4. 点击要检查的部分

**检查点：**
- ✅ 键名应该是 `variable.other.key`
- ✅ `:` 应该是 `punctuation.separator.colon`
- ✅ 单行值应该是 `string.unquoted.value`
- ✅ 延续行应该是 `string.unquoted.continuation`

### 测试用例

创建 `test-keyvalue.txt`：

```ini
# ==========================================
# 测试1: 基本键值对
# ==========================================
key1: value1
key2: value2
key3: value3

# ==========================================
# 测试2: 多行值
# ==========================================
multiline: first line
second line
third line

# ==========================================
# 测试3: 混合
# ==========================================
single: one line
multi: line one
line two
another: single line again

# ==========================================
# 测试4: 带引号
# ==========================================
quoted: "double quoted"
single: 'single quoted'
path: "C:\\Path\\To\\File"

# ==========================================
# 测试5: 特殊情况
# ==========================================
empty_value:
just_key:
with_spaces:    value with leading spaces
```

## 📦 完整配置

### package.json

```json
{
  "name": "keyvalue-syntax",
  "displayName": "Key-Value Config Syntax",
  "description": "简单键值对配置文件语法高亮",
  "version": "0.0.1",
  "engines": {
    "vscode": "^1.60.0"
  },
  "categories": [
    "Programming Languages"
  ],
  "contributes": {
    "languages": [
      {
        "id": "keyvalue",
        "aliases": ["Key-Value", "keyvalue"],
        "extensions": [".kv", ".keyvalue", ".conf"],
        "configuration": "./language-configuration.json"
      }
    ],
    "grammars": [
      {
        "language": "keyvalue",
        "scopeName": "source.keyvalue",
        "path": "./syntaxes/keyvalue.tmLanguage.json"
      }
    ]
  }
}
```

### language-configuration.json

```json
{
  "comments": {
    "lineComment": "#"
  },
  "brackets": [
    ["\"", "\""],
    ["'", "'"]
  ],
  "autoClosingPairs": [
    ["\"", "\""],
    ["'", "'"]
  ],
  "surroundingPairs": [
    ["\"", "\""],
    ["'", "'"]
  ]
}
```

## 🎓 完整示例文件

```ini
# ==========================================
# 应用配置文件
# ==========================================

# 基本信息
app_name: My Application
app_version: 1.0.0
app_author: John Doe

# 应用描述
app_description: This is a powerful application
that helps you manage your data efficiently
with an intuitive user interface

# 服务器配置
server_host: localhost
server_port: 8080
server_timeout: 30

# 数据库配置
db_connection: postgresql://localhost/mydb
db_pool_size: 10
db_timeout: 5000

# 日志配置
log_level: INFO
log_file: /var/log/app.log
log_format: [%(asctime)s] %(levelname)s: %(message)s

# 功能开关
feature_a: enabled
feature_b: disabled
feature_c: enabled

# 欢迎消息（多行）
welcome_message: Welcome to the application!
Thank you for using our service.
If you have any questions, please contact support.

# 帮助文本
help_text: Available commands:
  - start: Start the service
  - stop: Stop the service
  - status: Check status
  - help: Show this message

# 结束标记
config_version: 1.0
```

需要将这个功能集成到你的配置枚举语法中吗？