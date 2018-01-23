## iOS开发 swift 3dTouch实现 附代码 ##


----------

一、What？
-------

从iphone6s开始，苹果手机加入了3d touch技术，最简单的理解就是可以读取用户的点击屏幕力度大小，根据力度大小给予不同的反馈。
![手机qq的3dtouch截图](http://img.blog.csdn.net/20180123143906592?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)


----------

二、how? 实现方式？
------------

如果静态方式和动态方式同时使用，app默认调用静态方式中的设置。

2.1 静态方式
--------

在info.plist中直接添加，最多只能显示4个，超过4个只会显示前4个。
![这里写图片描述](http://img.blog.csdn.net/20180123145430405?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

【效果】
![这里写图片描述](http://img.blog.csdn.net/20180123160521691?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

2.2 动态方式
--------

使用代码注册。
【代码】

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
// Override point for customization after application launch.
let itemIcon1 = UIApplicationShortcutIcon(templateImageName: "AIcon")
let item1 = UIApplicationShortcutItem.init(type: "type1", localizedTitle: "short 兴", localizedSubtitle: "subTitle1", icon: itemIcon1, userInfo: nil)

let itemIcon2 = UIApplicationShortcutIcon.init(templateImageName: "rightIcon")
let item2 = UIApplicationShortcutItem.init(type: "type2", localizedTitle: "short 海", localizedSubtitle: "subTitle2", icon: itemIcon2, userInfo: nil)

let itemIcon3 = UIApplicationShortcutIcon.init(type: .add)
let item3 = UIApplicationShortcutItem.init(type: "type3", localizedTitle: "short 物", localizedSubtitle: "subTitle3", icon: itemIcon3, userInfo: nil)

let itemIcon4 = UIApplicationShortcutIcon(type: .add)
let item4 = UIApplicationShortcutItem.init(type: "type4", localizedTitle: "short 联", localizedSubtitle: "subTitle4", icon: itemIcon4, userInfo: nil)

UIApplication.shared.shortcutItems = [item4, item3, item2, item1]
return true
}
```
【效果】
![这里写图片描述](http://img.blog.csdn.net/20180123160551988?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)


----------

三、app内部3d Touch的使用
------------------

【步骤1】在需要使用3d Touch的VC中继承UIViewControllerPreviewingDelegate。
```
class ViewController: UIViewController, UIViewControllerPreviewingDelegate {
```

【步骤2】实现该delegate的方法。

```
//当用力按压的时候要预览的VC
func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
var iVC = UIViewController()
iVC.view.backgroundColor = UIColor.blue
return iVC
}
//当用力按压持续用力的时候，所要进行的操作
func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
var iVC = UIViewController()
iVC.view.backgroundColor = UIColor.yellow
self.navigationController?.pushViewController(iVC, animated: true)
}
```
【步骤3】给对应的view（按钮）注册3Dtouch事件

```
btn.frame = CGRect(x: x, y: y, width: w, height: h)
btn.backgroundColor = UIColor.orange
btn.setTitle("button "+"\(i+1)", for: .normal)
btn.addTarget(self, action: #selector(onBtn(sender:)), for: .touchUpInside)
if traitCollection.forceTouchCapability == .available{
registerForPreviewing(with: self, sourceView: btn)
//给对应的view（按钮）注册3Dtouch事件
}
view.addSubview(btn)
```
【步骤4 peek】
peek没有上滑显示按钮，但松开手指效果消失。
![这里写图片描述](http://img.blog.csdn.net/20180123160612237?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

【步骤5 pop】
pop上滑会在底部显示自定义按钮。要实现pop，在previewingContext中返回的VC需要
1、继承UIViewControllerPreviewingDelegate；
2、重写previewActionItems，即pop下方的按钮；
![这里写图片描述](http://img.blog.csdn.net/20180123160640705?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
```
extension ViewController{
//重写previewActionItems
override var previewActionItems: [UIPreviewActionItem] {
let action1 = UIPreviewAction(title: "跳转", style: .default) { (action, previewViewController) in
let showVC = ViewController()
showVC.hidesBottomBarWhenPushed = true
previewViewController.navigationController?.pushViewController(showVC, animated: true)
}
let action3 = UIPreviewAction(title: "取消", style: .destructive) { (action, previewViewController) in
print("我是取消按钮")
}
////该按钮可以是一个组，点击该组时，跳到组里面的按钮。
let subAction1 = UIPreviewAction(title: "测试1", style: .selected) { (action, previewViewController) in
print("我是测试按钮1")
}
let subAction2 = UIPreviewAction(title: "测试2", style: .selected) { (action, previewViewController) in
print("我是测试按钮2")
}
let subAction3 = UIPreviewAction(title: "测试3", style: .selected) { (action, previewViewController) in
print("我是测试按钮3")
}
let groupAction = UIPreviewActionGroup(title: "更多", style: .default, actions: [subAction1, subAction2, subAction3])
return [action1, action3, groupAction]
}

}
```

四、github代码
----------

如果本博客对您有帮助，希望可以得到您的赞赏！
完整代码附上：https://github.com/Liuyubao/LYB3DTouch
