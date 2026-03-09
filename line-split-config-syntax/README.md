# 自定义行分隔配置语法高亮 - 完整指南

## 📋 语法格式
```yaml
支持引用其它文件的语法为：@include xxx.dl
支持参数语法：${name}
```

### 核心规则

**块名称的识别条件（必须同时满足）：**
1. ✅ 格式匹配 `[a-zA-Z_][a-zA-Z0-9_-]*`
2. ✅ **前面有空行**（文件开头除外）
3. ✅ 单独一行

**否则，即使格式匹配块名规则，也会被当作延续行。**

### 基本结构

```
块名称
键名: 值
键名: 值
延续行内容
符合块名格式但仍是延续行

块名称        ← 前面有空行，识别为块名
键名: 值
```

## 📝 正确示例

### 示例 1：标准分块格式

```yaml
config-ass
xxx: asdfsd
sdww: xcxxcxc
dwqfisadf: xcasfd
this is the multiline item
xxx: this the single item

config-abbb
xxx: asdfsd
sdww: xcxxcxc
dwqfisadf: xcasfd
this is the multiline item
xxx: this the single item

config-ccc
xxx: asdfsd
sdww: xcxxcxc
dwqfisadf: xcasfd
this is the multiline item
xxx: this the single item
```

**解析结果：**
- `config-ass` → 块名（文件开头）
- `xxx: asdfsd` → 键值对
- `this is the multiline item` → 延续行
- （空行）
- `config-abbb` → 块名（前面有空行）
- ...

### 示例 2：延续行中包含符合块名格式的文本

```yaml
my-block
description: This is a description
config-like-text
more-text-here
still_continuation
value: another key

another-block
text: value
```

**解析结果：**
```
块: my-block
  - description = "This is a description\nconfig-like-text\nmore-text-here\nstill_continuation"
  - value = "another key"

块: another-block
  - text = "value"
```

**说明：**
- `config-like-text` 虽然符合块名格式，但前面没有空行，所以是延续行
- `more-text-here` 同样是延续行
- `still_continuation` 也是延续行

### 示例 3：对比空行的作用

```yaml
# 情况A：有空行 - 识别为新块
block1
key: value

block2          ← 前面有空行，识别为块名
key: value

# 情况B：无空行 - 识别为延续行
block3
key: value
block4          ← 前面无空行，识别为延续行（虽然格式像块名）
key: value
```

**解析结果：**

**情况A：**
```
块: block1
  - key = "value"

块: block2
  - key = "value"
```

**情况B：**
```
块: block3
  - key = "value\nblock4"
  - key = "value"
```

### 示例 2：实际应用场景

```yaml
# ==========================================
# 应用配置文件
# ==========================================

# 开发环境配置
dev-server
host: localhost
port: 3000
debug: true
description: Development server configuration
for local testing and debugging

# 生产环境配置
prod-server
host: 0.0.0.0
port: 80
debug: false
description: Production server configuration
optimized for performance

# 数据库配置
database_config
connection: postgresql://localhost/mydb
pool_size: 10
timeout: 5000
description: Main database connection settings
supports connection pooling

# 缓存配置
redis_cache
host: localhost
port: 6379
ttl: 3600
description: Redis cache configuration
for session storage
```

### 示例 3：复杂配置

```yaml
# API 配置
api-gateway
base_url: https://api.example.com
api_key: your-api-key-here
timeout: 30
retry: 3
description: Main API gateway configuration
handles all external API requests
with automatic retry logic

# 邮件配置
email_service
smtp_host: smtp.gmail.com
smtp_port: 587
username: noreply@example.com
from_address: "No Reply <noreply@example.com>"
template_path: /templates/email
description: Email service configuration
supports HTML templates
and batch sending

# 日志配置
logging_config
level: INFO
file_path: /var/log/app.log
max_size: 100MB
backup_count: 5
format: [%(asctime)s] %(levelname)s: %(message)s
description: Centralized logging configuration
with automatic rotation

# 安全配置
security_settings
enable_cors: true
allowed_origins: https://example.com, https://www.example.com
session_timeout: 1800
password_min_length: 8
description: Security and authentication settings
enforces strong password policy
```

### 示例 4：多语言内容

```yaml
# 英文文本
en_messages
welcome: Welcome to our application
description: This is a powerful tool
for managing your projects
login_prompt: Please enter your credentials
success: Operation completed successfully

# 中文文本
zh_messages
welcome: 欢迎使用我们的应用
description: 这是一个强大的工具
用于管理您的项目
login_prompt: 请输入您的凭据
success: 操作成功完成

# 日文文本
ja_messages
welcome: アプリケーションへようこそ
description: プロジェクト管理のための
強力なツールです
login_prompt: 認証情報を入力してください
success: 操作が正常に完了しました
```

## 🎨 高亮效果

| 元素 | 示例 | 颜色 | Scope |
|------|------|------|-------|
| **块名称** | `config-ass` | 青色/粗体 | `entity.name.section.block-name` |
| **键名** | `xxx` | 蓝色 | `variable.other.key` |
| **冒号** | `:` | 默认 | `punctuation.separator.colon` |
| **值** | `asdfsd` | 橙色 | `string.unquoted.value` |
| **延续行** | `this is the multiline item` | 橙色 | `string.unquoted.continuation` |
| **注释** | `# comment` | 灰色 | `comment.line` |
| **字符串** | `"text"` | 橙色 | `string.quoted.double` |

## 🔧 语法规则详解

### 1. 块名称识别（begin-end 区域）

```regex
begin: ^([a-zA-Z_][a-zA-Z0-9_-]*)\\s*$
end: ^(?=\\s*$)|^(?=[a-zA-Z_][a-zA-Z0-9_-]*\\s*$)
```

**关键点：**
- `begin` 匹配块名称行
- `end` 在遇到空行或下一个块名时结束
- **块名必须在文件开头或空行之后**

**工作原理：**
```yaml
config-ass         ← begin 匹配（开始新块）
xxx: value         ← 块内容
continuation       ← 块内容
                   ← 空行触发 end
config-abbb        ← 新的 begin 匹配（开始新块）
```

### 2. 为什么符合块名格式的行有时是延续行？

**TextMate 语法的 begin-end 机制：**

1. 当遇到符合 `begin` 模式的行时，进入块区域
2. 在块区域内，所有模式都基于块内的 `patterns`
3. 只有在 `end` 条件满足时才退出块
4. 退出后，下一行才能被识别为新的块名

**示例分析：**

```yaml
block1             ← begin 匹配（进入 block1 区域）
key: value         ← 块内模式：键值对
config-like        ← 块内模式：延续行（虽然格式像块名，但仍在 block1 区域内）
more-text          ← 块内模式：延续行
                   ← end 匹配（退出 block1 区域）
block2             ← begin 匹配（进入 block2 区域）
```

**关键：** 在 `block1` 区域结束（遇到空行）之前，所有行都按块内规则处理。

### 2. 键值对识别

```regex
^([a-zA-Z_][a-zA-Z0-9_]*)(\\s*)(:)(\\s*)(.*)$
```

**注意：键名不支持连字符，只有块名支持**

**有效键名：**
```
✅ key
✅ key_name
✅ key123
✅ _private_key
```

**无效键名：**
```
❌ key-name    (键名不支持连字符)
❌ 123key      (不能以数字开头)
❌ key.name    (不支持点号)
```

### 3. 延续行识别（在块内）

```regex
^(?![a-zA-Z_][a-zA-Z0-9_]*\\s*:)    # 不是键值对
(?!\\s*#)                            # 不是注释
(?!\\s*$)                            # 不是空行
(.+)$                                # 任何内容
```

**重要：** 延续行模式在块区域内生效，**不检查块名格式**。

**这意味着：**
```yaml
my-config
key: value
another-config-name    ← 虽然格式像块名，但仍在 my-config 块内
still-in-block         ← 还是延续行
                       ← 只有空行才结束块
new-block              ← 现在才是新块名
```

### 4. 空行的关键作用

**空行是块的唯一分隔符：**

```yaml
# 场景1：空行分隔 - 正确识别
block1
key: value
                   ← 空行结束 block1
block2             ← 识别为新块名
key: value

# 场景2：无空行 - 全部在同一块内
block1
key: value
block2             ← 不是块名，是延续行！
key: value         ← 这是块1的键值对
```

**解析对比：**

**场景1：**
```
块: block1
  - key = "value"

块: block2
  - key = "value"
```

**场景2：**
```
块: block1
  - key = "value\nblock2"  ← block2 成了值的一部分！
  - key = "value"
```

## 💡 使用场景

### 场景 1：环境配置

```yaml
# 开发环境
development
database_url: postgresql://localhost/dev_db
cache_enabled: false
debug: true
log_level: DEBUG

# 测试环境
testing
database_url: postgresql://test-server/test_db
cache_enabled: true
debug: true
log_level: INFO

# 生产环境
production
database_url: postgresql://prod-server/prod_db
cache_enabled: true
debug: false
log_level: WARNING
```

### 场景 2：微服务配置

```yaml
# 用户服务
user-service
endpoint: http://users.internal:8001
timeout: 10
retry: 3
description: User management service
handles authentication and profiles

# 订单服务
order-service
endpoint: http://orders.internal:8002
timeout: 15
retry: 5
description: Order processing service
manages order lifecycle

# 支付服务
payment-service
endpoint: http://payments.internal:8003
timeout: 30
retry: 3
description: Payment gateway integration
supports multiple providers
```

### 场景 3：功能开关

```yaml
# 用户功能
user_features
registration: enabled
social_login: enabled
two_factor_auth: disabled
description: User-facing features
can be toggled independently

# 管理功能
admin_features
user_management: enabled
analytics_dashboard: enabled
system_settings: enabled
description: Administrative features
restricted to admin users

# 实验性功能
experimental_features
ai_recommendations: disabled
real_time_notifications: disabled
advanced_search: enabled
description: Experimental features
may be unstable
```

### 场景 4：主题配置

```yaml
# 浅色主题
light_theme
primary_color: #007bff
background_color: #ffffff
text_color: #333333
border_color: #dee2e6
description: Default light theme
suitable for daytime use

# 深色主题
dark_theme
primary_color: #0d6efd
background_color: #212529
text_color: #f8f9fa
border_color: #495057
description: Dark theme for night mode
reduces eye strain

# 高对比度主题
high_contrast_theme
primary_color: #000000
background_color: #ffffff
text_color: #000000
border_color: #000000
description: High contrast theme
for accessibility
```

## 🚨 常见问题

### Q1: 为什么符合块名格式的行有时不被识别为块名？

**答：必须在空行之后（或文件开头）。**

```yaml
# ❌ 错误理解
my-block
key: value
another-block    # 以为这是新块，其实是延续行！

# ✅ 正确写法
my-block
key: value
                 # 必须有空行
another-block    # 现在才是新块
```

### Q2: 块名和键名有什么区别？

**位置和格式：**

| 类型 | 位置要求 | 格式 | 支持连字符 |
|------|---------|------|-----------|
| **块名** | 空行后（或文件开头） | `[a-zA-Z_][a-zA-Z0-9_-]*` | ✅ |
| **键名** | 任意，后接 `:` | `[a-zA-Z_][a-zA-Z0-9_]*` | ❌ |

```yaml
config-server      # ✅ 块名（支持连字符）
server-name: test  # ❌ 错误（键名不支持连字符）
server_name: test  # ✅ 正确（键名用下划线）
```

### Q3: 如何确保文本被识别为块名？

**两个条件：**
1. ✅ 前面有空行（或文件第一行）
2. ✅ 格式匹配 `[a-zA-Z_][a-zA-Z0-9_-]*`

```yaml
# ✅ 正确 - 文件第一行
first-block
key: value

# ✅ 正确 - 空行之后
                   
second-block
key: value

# ❌ 错误 - 没有空行
third-block        ← 这是 second-block 的延续行！
key: value
```

### Q4: 多个空行有影响吗？

**没有影响，多个空行等同于一个空行：**

```yaml
block1
key: value


                   ← 多个空行
block2             ← 仍然识别为块名
key: value
```

## 🎯 最佳实践

### 1. 命名规范

```yaml
# ✅ 推荐：使用有意义的块名
database_config
api_gateway_settings
user_preferences

# ✅ 推荐：使用下划线分隔键名
database_host: localhost
api_base_url: https://api.example.com
max_connections: 100

# ❌ 避免：无意义的名称
block1
block2
temp
```

### 2. 注释规范

```yaml
# ==========================================
# 数据库配置部分
# ==========================================

# 主数据库
main_database
host: localhost    # 数据库主机
port: 5432         # PostgreSQL 默认端口
database: myapp
username: admin
```

### 3. 组织结构

```yaml
# 按功能分组
# ==========================================
# 服务器配置
# ==========================================
web_server
# ...

app_server
# ...

# ==========================================
# 数据库配置
# ==========================================
primary_database
# ...

cache_database
# ...
```

### 4. 多行值格式

```yaml
# 推荐：清晰的多行格式
api_config
description: This is the main API configuration
It handles all external requests
and manages rate limiting

# 推荐：使用缩进
help_text
message: Welcome!
  Please follow these steps:
  1. Configure settings
  2. Start service
  3. Monitor logs
```

## 🔍 调试技巧

### 测试用例文件

创建 `test-blocks.conf`：

```yaml
# ==========================================
# 测试1: 基本块
# ==========================================
block1
key1: value1
key2: value2

block2
key1: value1
key2: value2

# ==========================================
# 测试2: 多行值
# ==========================================
multiline_block
description: First line
Second line
Third line
status: active

# ==========================================
# 测试3: 块名格式
# ==========================================
config-with-dash
test_key: value

config_with_underscore
test_key: value

ConfigCamelCase
test_key: value

_private_config
test_key: value

# ==========================================
# 测试4: 连续块（无空行）
# ==========================================
block_a
key: value
block_b
key: value
block_c
key: value

# ==========================================
# 测试5: 带引号的值
# ==========================================
quoted_values
url: "https://example.com:8080"
path: "C:\\Users\\Name"
text: "This has: a colon"
```

### 使用 Token Inspector

1. 打开测试文件
2. `Ctrl/Cmd + Shift + P`
3. 输入 "Developer: Inspect Editor Tokens and Scopes"
4. 验证各部分的 scope

**预期结果：**
- `config-ass` → `entity.name.section.block-name`
- `xxx` → `variable.other.key`
- `:` → `punctuation.separator.colon`
- `asdfsd` → `string.unquoted.value`
- `this is...` → `string.unquoted.continuation`

## 📦 完整配置文件

### package.json

```json
{
  "name": "block-config-syntax",
  "displayName": "Block Config Syntax",
  "description": "分块配置文件语法高亮",
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
        "id": "blockconfig",
        "aliases": ["Block Config", "blockconfig"],
        "extensions": [".conf", ".config", ".cfg"],
        "configuration": "./language-configuration.json"
      }
    ],
    "grammars": [
      {
        "language": "blockconfig",
        "scopeName": "source.blockconfig",
        "path": "./syntaxes/blockconfig.tmLanguage.json"
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

### settings.json
```json
"editor.tokenColorCustomizations": {
    "textMateRules": [
    {
      "scope":"entity.name.section.block-name.blockconfig",
      "settings": {
        "foreground": "#B5CEA8",
        "fontStyle": "bold"
      }
    },
    {
      "scope":"entity.name.type.eval",
      "settings": {
        "foreground": "#C586C0",
        "fontStyle": "bold"
      }
    }
  ]
}
```