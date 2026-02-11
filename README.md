# dralee-vscode-extensions
dralee daily vscode extensions

### enum-config-syntax
自定义的枚举配置语法高亮

### export-query-syntax
自定义的导出表配置语法高亮

### file-replace-rule-syntax
自定义的配置式替换文件内容语法高亮

### generator-rule-syntax
自定义的生成器文件拷贝语法高亮

### replace-config-syntax
自定义的文本内容替换语法高亮


### 打包
```bash
npm install -g @vscode/vsce  # 安装工具
cd xxxx-syntax               # 进入对应扩展根目录
vsce package                 # 打包成.vsix文件
```
安装：
```bash
code --install-extension xxxx.0.0.1.vsix
```
或直接从vscode左侧扩展图标，“...”菜单，选择“Install from VSIX”

### 使用图标主题的方式，必须要提供所有的图标
由于只是扩展不存在的图标，而非替换现有所有其他文件扩展图标
因此，使用最简单的文件关联，而不是图标主题，即不需要icon-theme.json与package.json中的iconThemes配置
```json
,
    "iconThemes": [
      {
        "id": "dralee-file-replace-rule-icons",
        "label": "Dralee File Replace Rule Icons",
        "path": "./fileicons/dralee-file-replace-rule-icon-theme.json"
      }
    ]
```
而使用：
vscode设置json
### 为 .drp 文件添加图标

#### 方法 1: 使用 Material Icon Theme

1. 安装 [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
2. 打开 VSCode 设置 (JSON)
3. 添加：
https://fonts.google.com/icons
https://pictogrammers.com/library/mdi/
```json
{
  "material-icon-theme.files.associations": {
    "*.drp": "swap_horiz"
  }
}
```

#### 方法 2: 使用 VSCode Icons

1. 安装 [VSCode Icons](https://marketplace.visualstudio.com/items?itemName=vscode-icons-team.vscode-icons)
2. 打开 VSCode 设置 (JSON)
3. 添加：

```json
{
  "vsicons.associations.files": [
    {
      "icon": "config",
      "extensions": ["drp"],
      "format": "svg"
    }
  ]
}
```

### 选择Material Icons
安装好Material Icons后，并通过Ctrl+Shift+P 选择Preferences: File Icon Theme 后，选择“Material Icon Theme”
并设置对应扩展文件图标，选择后默认会添加workbench.iconTheme项
关联的扩展文件名称可从"fileIcons.png"中查找所需要的文件扩展名称
~/.config/Code/User/settings.json
```json
  ...
  "workbench.iconTheme": "material-icon-theme",
  "material-icon-theme.files.associations": {
    "*.drp": "Remark",
    "*.dec": "Dinophp",
    "*.dr": "Craco",
    "*.q": "QSharp",
    "*.deq": "QSharp",
    "*.tr": "Purescript",
    "*.dl": "Stencil",
  }
```

#### vscode settings.json
```json
{
//....
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
      },
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
      },
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
      },
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
  },
  "material-icon-theme.files.associations": {
    "*.drp": "Remark",
    "*.dec": "Dinophp",
    "*.dr": "Craco",
    "*.q": "QSharp",
    "*.deq": "QSharp",
    "*.tr": "Purescript",
    "*.dl": "Stencil",
  },
  "material-icon-theme.folders.color": "#90a4ae",
  "material-icon-theme.files.color": "#ef5350",
  "material-icon-theme.opacity": 0.8,
  "material-icon-theme.saturation": 1,
  "workbench.iconTheme": "material-icon-theme"
}
```