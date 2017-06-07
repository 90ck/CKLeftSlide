#### 目的

最近看到快手的侧滑菜单，之前也没有自己写过，于是打算从零开始写一遍抽屉效果。

#### 效果图

![LefeSlide](/Users/caike/workSpace/iOS/CKLeftSlide/LefeSlide.gif)

#### 使用

1.初始化

```objective-c
//主控制器
UINavigationController *main = [[UINavigationController alloc]initWithRootViewController:[MainViewController new]];
//左侧菜单控制器
LeftViewController *left = [[LeftViewController  alloc]init];
//创建抽屉控制器
CKLeftSlideViewController *root = [[CKLeftSlideViewController alloc]initWithLeftVc:left mainVc:main];
self.window.rootViewController = root;
```

2.打开菜单视图  `  -(void)openLeftView; `

3.关闭菜单视图 `-(void)closeLeftView;`

4.左侧视图中push操作

```objective-c
//先获取到leftSlide控制器
CKLeftSlideViewController *leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];

//关闭菜单视图
[leftSlide closeLeftView];
//push新的控制器
[leftSlide.navigationController pushViewController:[NextViewController new] animated:NO];

```

