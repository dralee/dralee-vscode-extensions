
# TR 内容替换配置 - VSCode 语法高亮
### Dralee Content Replacement Config
内容替换配置语法

## 📁 文件结构

```
replace-config-syntax/
├── package.json
├── language-configuration.json
├── syntaxes/
│   └── tr.tmLanguage.json
└── README.md
```

## 🚀 安装步骤

### 1. 创建扩展目录

```bash
mkdir -p replace-config-syntax/syntaxes
cd replace-config-syntax
```

### 2. 创建文件

将以下文件保存到对应位置：
- `package.json` → 根目录
- `language-configuration.json` → 根目录  
- `configenum.tmLanguage.json` → `syntaxes/` 目录

### 3. 安装扩展

**Windows:**
```bash
xcopy /E /I replace-config-syntax "%USERPROFILE%\.vscode\extensions\replace-config-syntax"
```

**macOS/Linux:**
```bash
cp -r replace-config-syntax ~/.vscode/extensions/
```

### 4. 重启 VSCode

按 `Ctrl+Shift+P` (Windows/Linux) 或 `Cmd+Shift+P` (macOS)，输入 "Reload Window"

### 语法组成部分

#### 1. **注释**
```ini
# 这是备注
```
- 以 `#` 开头的行

#### 2. **配置项**
==>作为分隔
```ini
原始内容==>替换后内容
```

## 🎨 自定义颜色配置

在 VSCode 的 `settings.json` 中添加：

```json
{
    "editor.tokenColorCustomizations": {
      "textMateRules": [
        {
          "scope":"keyword.operator.assignment.config",
          "settings": {
            "foreground": "#C586C0",
            "fontStyle": "bold"
          }
        },
        {
          "scope":"string.unquoted.value.config",
          "settings": {
            "foreground": "#4FC1FF"
          }
        }
    ]
  }
}
```

### 示例
```bash
# 源数据==>目标数据
# 如将_dev_替换成_fat_
_dev_==>_fat_
_aas==>123423
asdf&sasdf==>1234123xxxasdf
as$dfasdf==>1234123xxxasdf
```