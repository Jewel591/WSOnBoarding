# WSOnBoarding

基于纯SwiftUI构建，通过一行代码为应用添加符合Apple设计规范的欢迎页面。

## 核心亮点

- 纯SwiftUI实现，支持iOS/iPadOS/macOS
- 一行代码集成
- 自动管理显示逻辑
- 跨设备同步（即将推出）

## 截图预览

*添加你的截图*

## 安装方法

### Swift Package Manager

在Xcode中添加依赖项：
1. 选择菜单 `File` > `Add Packages...`
2. 输入仓库URL：`https://github.com/Jewel591/WSOnBoarding`
3. 选择 "Up to Next Major Version"


## 使用方法

只需几行代码即可在您的应用中添加精美的欢迎页面：

```swift
import SwiftUI
import WSOnBoarding

struct ContentView: View {
    var body: some View {
        MainAppContent()
            .wsWelcomeView(config: createWelcomeConfig())
    }
    
    func createWelcomeConfig() -> WSWelcomeConfig {
        let features = [
            FeatureItem(
                icon: "star.fill", 
                title: "核心功能", 
                description: "功能描述", 
                color: .blue
            ),
            FeatureItem(
                icon: "lock.shield", 
                title: "安全保障", 
                description: "隐私与安全", 
                color: .green
            )
        ]
        
        return WSWelcomeConfig(
            appName: "我的应用",
            introText: "欢迎使用这个应用，它将为您提供...",
            features: features,
            iconSymbol: "app.gift"
        )
    }
}
```

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