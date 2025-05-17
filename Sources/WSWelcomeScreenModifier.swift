import SwiftUI
import os

private let logger = Logger(
    subsystem: "com.weisen.WSOnBoarding",
    category: "WelcomeScreen"
)

/// 欢迎页面样式
public enum WSWelcomeStyle {
    /// 标准样式（默认）- 白底，图标+功能列表
    case standard
    /// 沉浸式样式 - 全屏背景图片，底部描述
    case immersive
}

public struct WSWelcomeScreenModifier: ViewModifier {
    @State private var showStandardWelcome: Bool = false
    @State private var showImmersiveWelcome: Bool = false

    // 内容和样式配置
    let config: WSWelcomeConfig

    // 欢迎页面样式
    let style: WSWelcomeStyle

    // 欢迎页面标识符，可以为不同类型的欢迎页面设置不同的键
    let welcomeKey: String

    public init(
        config: WSWelcomeConfig,
        style: WSWelcomeStyle = .standard,
        welcomeKey: String = "hasSeenWelcomeView"
    ) {
        self.config = config
        self.style = style
        self.welcomeKey = welcomeKey
    }

    public func body(content: Content) -> some View {
        content
            .task {
                checkAndShowWelcome()
            }
            // 标准样式使用sheet展示
            .sheet(
                isPresented: $showStandardWelcome,
                onDismiss: {
                    markWelcomeAsSeen()
                }
            ) {
                StandardWelcomeView(config: config)
            }
            // 沉浸式样式使用fullScreenCover展示
            .fullScreenCover(
                isPresented: $showImmersiveWelcome,
                onDismiss: {
                    markWelcomeAsSeen()
                }
            ) {
                ImmersiveWelcomeView(config: config)
            }
    }

    private func checkAndShowWelcome() {
        let hasSeenWelcome = UserDefaults.standard.bool(forKey: welcomeKey)
        if !hasSeenWelcome {
            logger.info("首次启动应用，显示欢迎页面")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // 根据样式选择适当的展示方式
                switch style {
                case .standard:
                    showStandardWelcome = true
                case .immersive:
                    showImmersiveWelcome = true
                }
            }
        } else {
            logger.info("用户已经看过欢迎页面，不再显示")
        }
    }

    private func markWelcomeAsSeen() {
        UserDefaults.standard.set(true, forKey: welcomeKey)
        logger.info("欢迎页面已关闭，标记为已查看")
    }
}

// 便捷使用扩展
extension View {
    /// 添加欢迎页面
    /// - Parameters:
    ///   - config: 欢迎页面配置
    ///   - style: 欢迎页面样式 (.standard 或 .immersive)
    ///   - welcomeKey: UserDefaults键，用于跟踪是否已显示过欢迎页面
    /// - Returns: 修改后的视图
    public func wsWelcomeView(
        config: WSWelcomeConfig,
        style: WSWelcomeStyle = .standard,
        welcomeKey: String = "hasSeenWelcomeView"
    ) -> some View {
        self.modifier(
            WSWelcomeScreenModifier(
                config: config,
                style: style,
                welcomeKey: welcomeKey
            )
        )
    }
}
