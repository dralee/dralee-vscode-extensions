
# DEQ 查询语言 - VSCode 语法高亮
### Dralee Export Query
导出查询语法

## 📁 文件结构

```
deq-syntax/
├── package.json
├── language-configuration.json
├── syntaxes/
│   └── deq.tmLanguage.json
└── README.md
```

## 🚀 安装步骤

### 1. 创建扩展目录

```bash
mkdir -p deq-syntax/syntaxes
cd deq-syntax
```

### 2. 创建文件

将以下文件保存到对应位置：
- `package.json` → 根目录
- `language-configuration.json` → 根目录  
- `deq.tmLanguage.json` → `syntaxes/` 目录

### 3. 安装扩展

**Windows:**
```bash
xcopy /E /I deq-syntax "%USERPROFILE%\.vscode\extensions\deq-syntax"
```

**macOS/Linux:**
```bash
cp -r deq-syntax ~/.vscode/extensions/
```

### 4. 重启 VSCode

按 `Ctrl+Shift+P` (Windows/Linux) 或 `Cmd+Shift+P` (macOS)，输入 "Reload Window"

## 📝 语法结构说明

### 完整语法格式

```
[表名$更新条件;查询条件]
字段名
字段名,类型
```

### 语法组成部分

1. **查询块** `[...]`
   - **表名部分**：表的名称
   - **`$` 分隔符**：分隔表名和更新条件
   - **更新条件**：用于更新的条件表达式
   - **`;` 分隔符**：分隔表/更新部分和查询条件
   - **查询条件**：用于查询的条件表达式

2. **字段定义**
   - 单独字段：`creation_time`
   - 带类型字段：`name,string`

### 示例

```deq
# 这是备注
# 带更新条件的查询
[user$id=123;id=232 AND `name`='abcc']
id
name,string
code,string
creation_time

# 简单查询（无更新条件）
[products;category='electronics' AND price>100]
product_id
product_name,string
price,decimal
```

## 🎨 高亮效果说明

| 语法元素 | 示例 | 颜色/样式 | 说明 |
|---------|------|----------|------|
| **注释** | `# 这是备注` | 灰色/斜体 | 行末注释也支持 |
| **表名** | `user` | 青色/粗体 | `[` 后到 `$` 或 `;` 之间 |
| **$ 分隔符** | `$` | 紫色/粗体 | 分隔表名和更新条件 |
| **更新条件** | `id=123` | 混合高亮 | `$` 和 `;` 之间的条件 |
| **; 分隔符** | `;` | 默认颜色 | 分隔更新和查询部分 |
| **查询条件** | `id=232 AND...` | 混合高亮 | `;` 和 `]` 之间的条件 |
| **逻辑运算符** | `AND` `OR` `NOT` | 紫色/粉色 | 条件中的逻辑词 |
| **比较运算符** | `=` `>` `<` | 白色/灰色 | 比较符号 |
| **普通字段名** | `id` | 蓝色 | 条件中的字段 |
| **反引号字段名** | `` `name` `` | 蓝色带引号 | 特殊字符字段 |
| **字符串值** | `'abcc'` | 橙色/棕色 | 引号包围的值 |
| **数字值** | `232` `123` | 绿色 | 数字常量 |
| **字段定义** | `name,string` | 蓝色 + 青色 | 字段名和类型 |
| **单独字段名** | `creation_time` | 蓝色 | 独立一行的字段 |

## 🎨 自定义颜色配置

在 VSCode 的 `settings.json` 中添加：

```json
{
  "editor.tokenColorCustomizations": {
    "textMateRules": [
      {
        "scope": "comment.line.number-sign.deq",
        "settings": {
          "foreground": "#6A9955",
          "fontStyle": "italic"
        }
      },
      {
        "scope": "entity.name.type.table.deq",
        "settings": {
          "foreground": "#4EC9B0",
          "fontStyle": "bold"
        }
      },
      {
        "scope": "keyword.operator.separator.update.deq",
        "settings": {
          "foreground": "#C586C0",
          "fontStyle": "bold"
        }
      },
      {
        "scope": "keyword.operator.logical.deq",
        "settings": {
          "foreground": "#C586C0",
          "fontStyle": "bold"
        }
      },
      {
        "scope": "variable.other.field.deq",
        "settings": {
          "foreground": "#9CDCFE"
        }
      },
      {
        "scope": "variable.other.field.quoted.deq",
        "settings": {
          "foreground": "#9CDCFE",
          "fontStyle": "italic"
        }
      },
      {
        "scope": "storage.type.field-type.deq",
        "settings": {
          "foreground": "#4EC9B0"
        }
      },
      {
        "scope": "variable.other.field-name.deq",
        "settings": {
          "foreground": "#9CDCFE"
        }
      },
      {
        "scope": "string.quoted.single.deq, string.quoted.double.deq",
        "settings": {
          "foreground": "#CE9178"
        }
      },
      {
        "scope": "constant.numeric.deq",
        "settings": {
          "foreground": "#B5CEA8"
        }
      }
    ]
  }
}
```

## 📖 完整示例

```deq
# ========================================
# DEQ 查询语言示例
# ========================================

# 示例 1: 带更新条件的查询
# 表名：user，更新条件：id=123，查询条件：id=232 AND name='abcc'
[user$id=123;id=232 AND `name`='abcc']  # 行末注释
id
name,string
code,string
creation_time

# 示例 2: 复杂更新条件
[orders$`order_id`=789 AND status='pending';customer_id=456]
order_id
customer_id,integer
status,string
total_amount,decimal
created_at,datetime

# 示例 3: 简单查询（无更新条件）
[products;category='electronics' OR price>1000]
product_id
product_name,string
price,decimal
stock,integer

# 示例 4: 多个逻辑运算符
[employees$dept_id=10;salary>50000 AND (role='manager' OR level>=5)]
emp_id
name,string
salary,decimal
role,string
level,integer
hire_date,date

# 示例 5: 使用反引号的特殊字段
[`user-info`$`user-id`=100;`user-name`='test' AND `is-active`=1]
`user-id`
`user-name`,string
`is-active`,boolean
`created-at`,datetime
```

## 🔧 支持的语法特性

### ✅ 已支持

1. **注释**
   - 独立行：`# 注释内容`
   - 行末注释：`[table;condition]  # 注释`

2. **查询块结构**
   - 完整格式：`[表名$更新条件;查询条件]`
   - 无更新格式：`[表名;查询条件]`
   - `$` 符号特殊高亮（紫色/粗体）

3. **条件表达式**（同时支持更新条件和查询条件）
   - 逻辑运算符：`AND`, `OR`, `NOT`
   - 比较运算符：`=`, `!=`, `<>`, `>`, `<`, `>=`, `<=`
   - 字段名：普通字段和反引号字段
   - 值：字符串、数字

4. **字段定义**
   - 带类型：`name,string`
   - 单独字段：`creation_time`

## 🐛 调试技巧

### 查看 Token Scope

1. 按 `Ctrl/Cmd + Shift + P`
2. 输入：`Developer: Inspect Editor Tokens and Scopes`
3. 点击要检查的文本

### 测试正则表达式

对于复杂的语法规则，可以使用：
- https://regex101.com/
- https://regexr.com/

## 💡 语法说明

### 分隔符的作用

```
[表名$更新条件;查询条件]
     ↑        ↑
     |        |
     |        +--- 分隔更新部分和查询部分
     +------------ 分隔表名和更新条件
```

### 使用场景

1. **带更新的查询**
   ```deq
   [user$id=123;status='active']
   # 在 user 表中，更新 id=123 的记录，查询 status='active' 的记录
   ```

2. **纯查询**
   ```deq
   [user;status='active']
   # 在 user 表中，查询 status='active' 的记录
   ```

## 📦 打包分享

```bash
npm install -g vsce
cd deq-syntax
vsce package
```

生成 `deq-syntax-0.0.1.vsix` 文件，可通过：
Extensions → ... → Install from VSIX 安装

## 🎯 快速参考

| 操作 | 快捷键 |
|------|--------|
| 添加/移除注释 | `Ctrl/Cmd + /` |
| 格式化文档 | `Shift + Alt + F` |
| 查看 Token | `Ctrl/Cmd + Shift + P` → Inspect |
| 重新加载窗口 | `Ctrl/Cmd + Shift + P` → Reload |

需要添加更多功能吗？比如：
- 函数支持
- 嵌套查询
- 更多运算符
- 代码片段（Snippets）