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
