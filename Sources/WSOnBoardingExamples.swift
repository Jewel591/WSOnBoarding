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
            // 不带图标的功能项
            FeatureItem(
                title: "简洁设计",
                description: "专注于内容，无额外干扰。",
                color: .blue
            ),
            // 不带描述的功能项
            FeatureItem(
                icon: "hand.thumbsup.fill",
                title: "用户体验",
                color: .green
            )
        ]
        
        // 使用增强的初始化器
        return WSWelcomeConfig(
            appName: "示例应用",
            introText: "这是一款集简洁、高效、智能于一体的应用，为您提供最佳的用户体验和功能体验。",
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
            introText: "为了给您提供个性化的体验，我们将收集并使用有关您设备和使用情况的数据。您可以随时在设置中调整隐私选项。",
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
    
    /// 极简风格的示例
    public static func minimalExample() -> some View {
        // 创建一个极简的特性列表
        let features: [FeatureItem] = [
            FeatureItem(
                title: "极简设计",
                color: .gray
            ),
            FeatureItem(
                title: "专注内容",
                color: .gray
            )
        ]
        
        let config = WSWelcomeConfig(
            appName: "极简应用",
            features: features,
            primaryColor: .black
        )
        
        return ExampleContentView()
            .wsWelcomeView(config: config)
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