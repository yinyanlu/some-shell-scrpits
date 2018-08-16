# 简介

## 需求背景
开启存储空间的默认首页功能后，需要上传一个index.html文件。如果希望制作一个简单的index.html文件，能显示当前空间的文件即可。

## 当前功能
- 获取指定bucket文件列表，仅仅展示文件名
- 生成文件超链接

## roadmap
- 添加所有文件信息，比如mimeType、时间戳、大小、哈希值。
- 形成一张列表
- 表头支持排序：字母数字混合按照Ascii码排序、时间按照先后排序

## 使用方法
### 输入
```bash
$ bash list2md.sh <bucket-name> <domain-host>
```
### 输出
```
<bucket-name>.md
```
