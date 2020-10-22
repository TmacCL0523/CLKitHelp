# CLKitHelp

[![CI Status](https://img.shields.io/travis/hongcl8114@hotmail.com/CLKitHelp.svg?style=flat)](https://travis-ci.org/hongcl8114@hotmail.com/CLKitHelp)
[![Version](https://img.shields.io/cocoapods/v/CLKitHelp.svg?style=flat)](https://cocoapods.org/pods/CLKitHelp)
[![License](https://img.shields.io/cocoapods/l/CLKitHelp.svg?style=flat)](https://cocoapods.org/pods/CLKitHelp)
[![Platform](https://img.shields.io/cocoapods/p/CLKitHelp.svg?style=flat)](https://cocoapods.org/pods/CLKitHelp)

## 安装
支持cocoapods
```ruby
pod 'CLKitHelp'
```
## 使用方法
导入头文件

```
#import <CLKitHelp.h>
```
所有方法添加clkit前缀,调用直接适用CLKit就可以了。（~~NSDate除外~~）

## 更新
*  2020年10月22日 修改Button分类添加图片位置方法,修改colletctionLayout无法获取到真实高度问题,暂时用屏幕宽度解决。 
*  2020年10月22日 添加自定义瀑布流类CLCollectionLayout,修改NSDate分类。
*  2020年10月20日 更新文件格式添加NSDate分类。


## 项目文件目录

```
CLKitHelp
├─ .DS_Store
├─ BaseClass
│    ├─ .DS_Store
│    ├─ CollectionViewCell
│    │    ├─ CLBaseCollectionViewCell.h
│    │    └─ CLBaseCollectionViewCell.m
│    ├─ TableViewCell
│    │    ├─ CLBaseTableViewCell.h
│    │    └─ CLBaseTableViewCell.m
│    ├─ View
│    │    ├─ CLBaseView.h
│    │    └─ CLBaseView.m
│    └─ ViewController
│           ├─ CLBaseViewController.h
│           └─ CLBaseViewController.m
├─ CLKitHelp.h
├─ Category
│    ├─ .DS_Store
│    ├─ NSArrary
│    │    ├─ NSArray+CLKit.h
│    │    └─ NSArray+CLKit.m
│    ├─ NSDate
│    │    ├─ NSDate+CLKit.h
│    │    └─ NSDate+CLKit.m
│    ├─ NSDictionary
│    │    ├─ NSDictionary+CLKit.h
│    │    └─ NSDictionary+CLKit.m
│    ├─ NSObject
│    │    ├─ NSObject+CLKit.h
│    │    └─ NSObject+CLKit.m
│    ├─ NSString
│    │    ├─ NSString+Check.h
│    │    ├─ NSString+Check.m
│    │    ├─ NSString+Encryption.h
│    │    ├─ NSString+Encryption.m
│    │    ├─ NSString+Formatter.h
│    │    └─ NSString+Formatter.m
│    ├─ UIButton
│    │    ├─ UIButton+CLKit.h
│    │    └─ UIButton+CLKit.m
│    ├─ UIColor
│    │    ├─ UIColor+CLKit.h
│    │    └─ UIColor+CLKit.m
│    ├─ UIImage
│    │    ├─ UIImage+CLKit.h
│    │    └─ UIImage+CLKit.m
│    ├─ UILabel
│    │    ├─ UILabel+CLKit.h
│    │    └─ UILabel+CLKit.m
│    ├─ UIScrollView
│    │    ├─ UIScrollView+CLKit.h
│    │    └─ UIScrollView+CLKit.m
│    ├─ UITableView
│    │    ├─ UITableView+CLKit.h
│    │    └─ UITableView+CLKit.m
│    └─ UIView
│           ├─ UIView+CLKit.h
│           └─ UIView+CLKit.m
├─ Custom
│    ├─ .DS_Store
│    ├─ CLCollectionFallLayout
│    │    ├─ CLCollectionLayout.h
│    │    └─ CLCollectionLayout.m
│    ├─ CLTableView
│    │    ├─ CLTableView.h
│    │    └─ CLTableView.m
│    └─ CLTextFiled
│           ├─ CLTextField.h
│           └─ CLTextField.m
├─ Macro
│    └─ CLKitHelpMacro.h
└─ NetWork
       ├─ .DS_Store
       ├─ NetWroking
       │    ├─ NetWorkCache.h
       │    ├─ NetWorkCache.m
       │    ├─ NetWorkTools.h
       │    └─ NetWorkTools.m
       ├─ Socket
       │    ├─ SocketTools.h
       │    └─ SocketTools.m
       └─ WebSocket
              ├─ WebSocketTools.h
              └─ WebSocketTools.m

```
              
## 系统要求
该项目最低支持iOS9.0.

## 许可证
CLKitHelp  使用 MIT 许可证，详情见 LICENSE 文件。

