# dralee-vscode-extensions
dralee daily vscode extensions


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
    "*.deq": "QSharp"
  }
```