# TestAppIcon

須注意之處：
1. info.plist的寫法
2. Icon檔案不要放在Assets.xcassets裡面
3. 使用
```
UIApplication.shared.setAlternateIconName("iconName") //換成info.plist裡面寫的icon name，或傳入nil使用預設的icon
```
