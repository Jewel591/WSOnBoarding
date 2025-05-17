import SwiftUI

/// 示例代码，展示如何使用 WSOnBoarding 包
public struct WSOnBoardingExamples {
    
    /// 基本用法示例
    public static func basicExample() -> some View {
        ExampleContentView()
            .wsWelcomeView(config: createBasicConfig())
    }
    
    /// 创建基本配置
    public static func createBasicConfig() -> WSWelcomeConfig {
        let features: [FeatureItem] = [
            FeatureItem(
                icon: "star.fill",
                title: "核心功能",
                description: "应用的核心功能介绍。",
                color: .orange
            ),
            FeatureItem(
                icon: "lock.shield",
                title: "安全保障",
                description: "您的数据安全受到保护。",
                color: .blue
            ),
            FeatureItem(
                icon: "hand.thumbsup.fill",
                title: "用户体验",
                description: "精心设计的用户界面与交互。",
                color: .green
            )
        ]
        
        // 使用增强的初始化器
        return WSWelcomeConfig(
            appName: "示例应用",
            features: features,
            iconSymbol: "app.gift.fill",
            primaryColor: .blue
        )
    }
    
    /// 自定义配置示例
    public static func customizedExample() -> some View {
        // 使用增强的初始化器设置所有自定义属性
        let config = WSWelcomeConfig(
            appName: "示例应用",
            features: createBasicConfig().features,
            iconSymbol: "app.gift.fill",
            primaryColor: .blue,
            customTitle: "欢迎使用我们的应用",
            privacyButtonText: "查看隐私政策",
            privacyAction: {
                // 处理隐私政策点击
                print("用户点击了隐私政策按钮")
            }
        )
        
        return ExampleContentView()
            .wsWelcomeView(
                config: config,
                welcomeKey: "customWelcome"
            )
    }
}

/// 示例内容视图
private struct ExampleContentView: View {
    var body: some View {
        VStack {
            Text("主应用内容")
                .font(.title)
            Text("欢迎页面将在应用首次启动时显示")
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    WSOnBoardingExamples.basicExample()
} 