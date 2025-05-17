# WSOnBoarding

基于纯SwiftUI构建，通过一行代码为应用添加符合Apple设计规范的欢迎页面。

## 核心亮点

- 纯SwiftUI实现，支持iOS/iPadOS/macOS
- 一行代码集成
- 自动管理显示逻辑
- 跨设备同步（即将推出）

## 截图预览

![](./Sources/images/Apple-Vision-Pro-Apple-Immersive-Video-Boundless-Arctic-Surfing_big.jpg.large_2x.jpg)

## 安装

### 通过 Swift Package Manager 安装

在 Xcode 中添加依赖项：
1. 选择菜单 `File` > `Add Packages...`
2. 输入仓库URL：`https://github.com/Jewel591/WSOnBoarding`
3. 保持默认选项，点击完成。

## 使用

### 基本用法（最佳实践）

为了更好地组织代码，我强烈建议创建一个独立的文件，专门用于设置用于欢迎页面显示的信息：

#### 1. 创建配置文件

> *你可以直接将下面这个模板文件复制到你的 Xcode 项目中。我一般会放在 OnBoarding 目录下。*

```swift
// WelcomeConfig.swift
import SwiftUI
import WSOnBoarding

// 扩展 WSOnBoarding 库中的 WSWelcomeConfig
extension WSWelcomeConfig {
    /// 应用的欢迎页配置
    static var welcomeInfo: WSWelcomeConfig {
        return WSWelcomeConfig(
            appName: "VLMind",
            introText: nil,
            features: [
                FeatureItem(
                    icon: "photo.on.rectangle",
                    title: "视觉识别",
                    description: "选取并识别图像中的内容。",
                    color: .blue
                ),
                FeatureItem(
                    icon: "bolt.fill",
                    title: "毫秒级响应",
                    description: "超快速分析，无需等待即可获得结果。",
                    color: .orange
                ),
                FeatureItem(
                    icon: "wifi.slash",
                    title: "离线支持",
                    description: "无需联网，在本地设备上完成所有处理。",
                    color: .green
                ),
            ],
            iconSymbol: "camera.viewfinder",
            iconName: "AppIcon",
            backgroundImageName: nil,
            primaryColor: .blue,
            continueButtonText: "继续",
            disclaimerText:
                "你的设备信息和使用数据将用于提供个性化体验、改进应用功能和防止欺诈。查看详细隐私政策了解更多信息。"
        )
    }
}
```

#### 2. 在 App 文件中应用

首先，在 App 文件中导入 `WSOnBoarding`：

```
import WSOnBoarding
```

然后在 WindowGroup 的 View 组件上添加 `.wsWelcomeView`修饰器：

```swift
// YourApp.swift
import SwiftUI
import WSOnBoarding

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .wsWelcomeView(
                    config: WSWelcomeConfig.welcomeInfo, // 要显示的应用信息
                    style: .standard // 预设的外观风格（.standard 或 .immersive）
                )
        }
    }
}
```

至此，就完成了所有配置工作，wsWelcomeView 会自动管理显示逻辑（默认仅显示一次）。当然，默认支持深色模式。

![](./Sources/images/411shots_so.png)

## 配置选项

`WSWelcomeConfig`提供多种配置选项来自定义欢迎页面：

### 基本配置

| 参数 | 类型 | 描述 |
|------|------|------|
| appName | String | 应用名称 |
| introText | String? | 介绍文本，显示在标题下方 |
| features | [FeatureItem] | 功能项数组 |
| customTitle | String? | 自定义标题，默认为"欢迎使用{appName}" |

### 图标配置

| 参数 | 类型 | 描述 |
|------|------|------|
| iconName | String? | Assets中的图标名称 (优先) |
| iconSymbol | String? | SF Symbol图标名称 |

### 样式配置

| 参数 | 类型 | 描述 |
|------|------|------|
| primaryColor | Color | 主要颜色，用于按钮等 |
| secondaryColor | Color | 次要颜色，用于默认图标背景 |

### 文本与隐私配置

| 参数 | 类型 | 描述 |
|------|------|------|
| continueButtonText | String | 继续按钮文字 |
| disclaimerText | String? | 底部声明文本 |
| privacyButtonText | String? | 隐私政策按钮文字 |
| privacyAction | (() -> Void)? | 点击隐私政策的回调 |

## 高级用法

### 欢迎页面样式选择

包支持两种不同风格的欢迎页面：

```swift
// 标准样式（默认）- 白底，图标+功能列表
.wsWelcomeView(
    config: myConfig,
    style: .standard  // 默认值，可省略
)

// 沉浸式样式 - 全屏背景图片，底部描述
.wsWelcomeView(
    config: myConfig,
    style: .immersive
)
```

标准样式适合展示多个功能项，而沉浸式样式更适合创建视觉冲击力强的欢迎页面。使用沉浸式样式时，建议在配置中提供`backgroundImageName`以设置背景图片。

### 自定义显示逻辑

```swift
// 使用自定义键控制显示逻辑
.wsWelcomeView(
    config: myConfig,
    welcomeKey: "customWelcomeKey"  // 默认为"hasSeenWelcomeView"
)
```

### 不同风格的功能项

```swift
// 带图标和描述
FeatureItem(
    icon: "star.fill", 
    title: "完整风格", 
    description: "包含所有元素", 
    color: .blue
)

// 不带图标
FeatureItem(
    title: "无图标风格", 
    description: "仅显示文本", 
    color: .green
)

// 不带描述
FeatureItem(
    icon: "gear", 
    title: "简洁风格", 
    color: .orange
)
```

## 系统要求

- iOS 15.0+
- iPadOS 15.0+
- macOS 12.0+
- Swift 5.5+
- Xcode 13.0+

## 许可证

MIT License 