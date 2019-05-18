## **运行环境：**

### 安装CocoaPods

升级Ruby（非必须，出现报错后在执行）

`sudo gem update --system`

安装第三方库管理

`sudo gem install cocoapods`

`pod setup`

之后在项目的主目录（有Podfile和Podfile.lock文件的目录），执行`pod install`

打开后缀名为.xcworkspace文件

添加第三方库时，修改Podfile文件，然后再执行`pod install`

### FMDB数据库

已经使用cocoapods导入到工程中，可以直接引用头文件
