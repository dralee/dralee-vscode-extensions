
# DEC 查询语言 - VSCode 语法高亮
### Dralee Enum Config
枚举配置语法

## 📁 文件结构

```
config-enum-syntax/
├── package.json
├── language-configuration.json
├── syntaxes/
│   └── configenum.tmLanguage.json
└── README.md
```

## 🚀 安装步骤

### 1. 创建扩展目录

```bash
mkdir -p config-enum-syntax/syntaxes
cd config-enum-syntax
```

### 2. 创建文件

将以下文件保存到对应位置：
- `package.json` → 根目录
- `language-configuration.json` → 根目录  
- `configenum.tmLanguage.json` → `syntaxes/` 目录

### 3. 安装扩展

**Windows:**
```bash
xcopy /E /I config-enum-syntax "%USERPROFILE%\.vscode\extensions\config-enum-syntax"
```

**macOS/Linux:**
```bash
cp -r config-enum-syntax ~/.vscode/extensions/
```

### 4. 重启 VSCode

按 `Ctrl+Shift+P` (Windows/Linux) 或 `Cmd+Shift+P` (macOS)，输入 "Reload Window"

## 📝 语法结构说明

### 完整语法格式

```ini
# 注释
[表名]
字段名==>$Ref$枚举类型
字段名==>字段描述：枚举值-枚举描述$$枚举项名称，枚举值-枚举描述$$枚举项名称$#枚举类型
```

### 语法组成部分

#### 1. **注释**
```ini
# 这是备注
```
- 以 `#` 开头的行

#### 2. **表名定义**
```ini
[quality_check_order_report_item]
```
- 用方括号 `[]` 包围

#### 3. **字段定义 - 引用类型**
```ini
字段名==>$Ref$枚举类型
```
- **字段名**：变量名
- **`==>`**：赋值运算符
- **`$Ref$`**：引用关键字
- **枚举类型**：引用的枚举类型名

**示例：**
```ini
source_order_type==>$Ref$OrderTypeEnum
check_result==>$Ref$QualityCheckResult
```

#### 4. **字段定义 - 枚举定义**
```ini
字段名==>字段描述：枚举值-枚举描述$$枚举项名称，枚举值-枚举描述$$枚举项名称$#枚举类型
```

**组成元素：**
- **字段名**：变量名
- **`==>`**：赋值运算符
- **字段描述**：可选的字段说明
- **分隔符**：`：` `:` `;` `；` （字段描述与枚举值之间）
- **枚举项格式**：`枚举值-枚举描述$$枚举项名称`
  - **枚举值**：数字
  - **`-` `:` `：`**：枚举值与描述的分隔符
  - **枚举描述**：中文说明
  - **`$$`**：枚举名称分隔符
  - **枚举项名称**：英文常量名
- **`,` `，`**：枚举项之间的分隔符
- **`$#`**：枚举类型分隔符
- **枚举类型**：枚举类型名称

**示例：**
```ini
status==>质检报告明细状态:10-草稿$$Draft,20-未核对$$Unchecked$#QualityReportItemStatus
bind_status==>绑定状态：0-未绑定$$None，10-默认绑定$$Default$#QualityReportBindStatus
```

## 🎨 高亮效果说明

| 语法元素 | 示例 | 颜色/样式 | 说明 |
|---------|------|----------|------|
| **注释** | `# 这是备注` | 灰色/斜体 | 行首 # 开头 |
| **表名** | `[quality_check_order_report_item]` | 青色/粗体 | 方括号内容 |
| **字段名** | `status` | 蓝色 | 字段变量名 |
| **赋值符** | `==>` | 紫色 | 赋值运算符 |
| **$Ref$ 关键字** | `$Ref$` | 粉色/粗体 | 引用关键字 |
| **枚举引用类型** | `OrderTypeEnum` | 青色 | 被引用的枚举 |
| **字段描述** | `质检报告明细状态` | 橙色 | 字段说明文本 |
| **枚举值** | `10` `20` | 绿色 | 数字常量 |
| **枚举描述** | `草稿` `未核对` | 橙色 | 中文说明 |
| **$$ 分隔符** | `$$` | 紫色 | 枚举名分隔符 |
| **枚举项名称** | `Draft` `Unchecked` | 青绿色/粗体 | 英文常量名 |
| **$# 分隔符** | `$#` | 紫色/粗体 | 类型分隔符 |
| **枚举类型** | `QualityReportItemStatus` | 青色 | 枚举类型名 |

## 🎨 自定义颜色配置

在 VSCode 的 `settings.json` 中添加：

```json
{
    "editor.tokenColorCustomizations": {
      "textMateRules": [
      {
        "scope": "comment.line.number-sign.configenum",
        "settings": {
          "foreground": "#6A9955",
          "fontStyle": "italic"
        }
      },
      {
        "scope": "entity.name.type.table.configenum",
        "settings": {
          "foreground": "#4EC9B0",
          "fontStyle": "bold"
        }
      },
      {
        "scope": "variable.other.field-name.configenum",
        "settings": {
          "foreground": "#9CDCFE"
        }
      },
      {
        "scope": "keyword.operator.assignment.configenum",
        "settings": {
          "foreground": "#C586C0",
          "fontStyle": "bold"
        }
      },
      {
        "scope": "keyword.control.ref.configenum",
        "settings": {
          "foreground": "#C586C0",
          "fontStyle": "bold"
        }
      },
      {
        "scope": "entity.name.type.enum-ref.configenum",
        "settings": {
          "foreground": "#4EC9B0"
        }
      },
      {
        "scope": "string.unquoted.field-description.configenum",
        "settings": {
          "foreground": "#CE9178"
        }
      },
      {
        "scope": "constant.numeric.enum-value.configenum",
        "settings": {
          "foreground": "#B5CEA8"
        }
      },
      {
        "scope": "string.unquoted.enum-description.configenum",
        "settings": {
          "foreground": "#CE9178"
        }
      },
      {
        "scope": "keyword.operator.enum-name-separator.configenum",
        "settings": {
          "foreground": "#C586C0"
        }
      },
      {
        "scope": "entity.name.constant.enum-name.configenum",
        "settings": {
          "foreground": "#4FC1FF",
          "fontStyle": "bold"
        }
      },
      {
        "scope": "keyword.operator.enum-type-separator.configenum",
        "settings": {
          "foreground": "#C586C0",
          "fontStyle": "bold"
        }
      },
      {
        "scope": "entity.name.type.enum-type.configenum",
        "settings": {
          "foreground": "#4EC9B0",
          "fontStyle": "bold"
        }
      }
    ]
  }
}
```

## 📖 完整示例

创建测试文件 `test.conf`：

```ini
# ========================================
# 质检订单报告配置
# ========================================

# 质检报告明细表
[quality_check_order_report_item]

# 引用已定义的枚举类型
source_order_type==>$Ref$OrderTypeEnum
check_result==>$Ref$QualityCheckResult
task_status==>$Ref$QualityTaskStatus
check_method==>$Ref$QualityCheckMethod

# 定义新的枚举类型
status==>质检报告明细状态:10-草稿$$Draft,20-未核对$$Unchecked,30-已核对$$Checked,40-已否决$$Rejected,50-已作废$$Cancel$#QualityReportItemStatus

bind_status==>绑定状态：0-未绑定$$None，10-默认绑定$$Default，20-已绑定$$Bound$#QualityReportBindStatus

# 使用不同的分隔符
priority==>优先级；1:低$$Low,2:中$$Medium,3:高$$High$#PriorityLevel

# ========================================
# 订单类型配置
# ========================================

[order_type_config]
type==>订单类型：1-普通订单$$Normal，2-紧急订单$$Urgent，3-预约订单$$Reserved$#OrderType
```

## 🔧 支持的语法特性

### ✅ 已支持

1. **注释**
   - 独立行注释：`# 注释内容`

2. **表名定义**
   - 格式：`[表名]`

3. **字段引用类型**
   - 格式：`字段名==>$Ref$枚举类型`
   - 自动高亮 `$Ref$` 关键字

4. **字段枚举定义**
   - 完整格式支持
   - 字段描述（可选）
   - 多个枚举项
   - 枚举值、描述、名称的完整高亮

5. **灵活的分隔符**
   - 字段描述分隔：`:` `：` `;` `；`
   - 枚举描述分隔：`-` `:` `：`
   - 枚举项分隔：`,` `，`

6. **特殊符号**
   - `==>` - 赋值运算符
   - `$Ref$` - 引用关键字
   - `$$` - 枚举名称分隔符
   - `$#` - 枚举类型分隔符

## 💡 语法规则详解

### 分隔符使用

```ini
字段名 ==> 字段描述 : 枚举值 - 枚举描述 $$ 枚举项名称 , ... $# 枚举类型
       ↑           ↑        ↑            ↑              ↑       ↑
       |           |        |            |              |       |
   赋值运算符  字段/枚举  值/描述     枚举名称      枚举项    枚举类型
              分隔符    分隔符       分隔符        分隔符    分隔符
```

### 两种字段定义方式对比

#### 方式一：引用已定义的枚举
```ini
source_order_type==>$Ref$OrderTypeEnum
```
- 适用于复用已有枚举
- 简洁明了
- `$Ref$` 是固定关键字

#### 方式二：定义新枚举
```ini
status==>质检报告明细状态:10-草稿$$Draft,20-未核对$$Unchecked$#QualityReportItemStatus
```
- 适用于定义新的枚举类型
- 包含完整的枚举信息
- 支持多个枚举项

## 🐛 调试技巧

### 查看 Token Scope

1. 按 `Ctrl/Cmd + Shift + P`
2. 输入：`Developer: Inspect Editor Tokens and Scopes`
3. 点击要检查的文本

### 测试不同分隔符

```ini
# 测试所有支持的分隔符组合
field1==>描述:1-项目1$$Item1$#Type1
field2==>描述：2：项目2$$Item2$#Type2
field3==>描述;3-项目3$$Item3$#Type3
field4==>描述；4：项目4$$Item4$#Type4

# 测试中文逗号
field5==>描述:1-项目1$$Item1，2-项目2$$Item2$#Type5
```

## 📦 支持的文件扩展名

默认支持：
- `.conf`
- `.cfg`
- `.ini`

**添加更多扩展名**：修改 `package.json` 中的 `extensions` 数组。

## 🎯 快速参考

### 语法速查表

| 元素 | 符号 | 说明 |
|------|------|------|
| 注释 | `#` | 行首注释 |
| 表名 | `[]` | 包围表名 |
| 赋值 | `==>` | 字段赋值 |
| 引用 | `$Ref$` | 引用枚举类型 |
| 字段/枚举分隔 | `: : ; ;` | 灵活分隔 |
| 值/描述分隔 | `- : :` | 灵活分隔 |
| 枚举名分隔 | `$$` | 固定符号 |
| 枚举项分隔 | `, ，` | 灵活分隔 |
| 类型分隔 | `$#` | 固定符号 |

### 常见模式

```ini
# 模式1：引用类型
field==>$Ref$EnumType

# 模式2：简单枚举
field==>1-desc1$$Name1,2-desc2$$Name2$#EnumType

# 模式3：带字段描述
field==>字段说明:1-desc1$$Name1,2-desc2$$Name2$#EnumType

# 模式4：完整格式
field==>字段说明：1-枚举描述$$EnumName，2-枚举描述$$EnumName$#EnumType
```

需要添加更多功能吗？比如：
- 代码片段（Snippets）
- 语法验证
- 自动补全
- 格式化支持