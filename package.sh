#!/bin/bash
# package all the syntaxes
# 2026.01.19 by dralee
# $1: install it for input y

opt=$1
echo "if need to install it automatically, please input y/Y"

if [[ "$opt" =~ ^[y|Y]$ ]]; then
    export INSTALL
    echo after packing it, auto to install
fi

rm -rf dist
mkdir -p dist
cd enum-config-syntax
vsce package -o ../dist
$INSTALL && code --uninstall-extension dralee.dralee-enum-config-syntax
$INSTALL && code --install-extension ../dist/dralee-enum-config-syntax-0.0.1.vsix

cd ../generator-rule-syntax
vsce package -o ../dist
$INSTALL && code --uninstall-extension dralee.dralee-generator-rule-syntax
$INSTALL && code --install-extension ../dist/dralee-generator-rule-syntax-0.0.1.vsix

cd ../export-query-syntax
vsce package -o ../dist
$INSTALL && code --uninstall-extension dralee.dralee-export-query-syntax
$INSTALL && code --install-extension ../dist/dralee-export-query-syntax-0.0.1.vsix

cd ../file-replace-rule-syntax
vsce package -o ../dist
$INSTALL && code --uninstall-extension dralee.dralee-file-replace-rule-syntax
$INSTALL && code --install-extension ../dist/dralee-file-replace-rule-syntax-0.0.1.vsix

cd ../replace-config-syntax
vsce package -o ../dist
$INSTALL && code --uninstall-extension dralee.dralee-content-replace-config-syntax
$INSTALL && code --install-extension ../dist/dralee-content-replace-config-syntax-0.0.1.vsix

cd ../key-value-config-syntax
vsce package -o ../dist
$INSTALL && code --uninstall-extension dralee.dralee-key-value-config-syntax
$INSTALL && code --install-extension ../dist/dralee-key-value-config-syntax-0.0.1.vsix

cd ../line-split-config-syntax
vsce package -o ../dist
$INSTALL && code --uninstall-extension dralee.dralee-line-split-config-syntax
$INSTALL && code --install-extension ../dist/dralee-line-split-config-syntax-0.0.1.vsix

cd ..
