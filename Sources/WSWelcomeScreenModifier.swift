import SwiftUI
import os

private let logger = Logger(
    subsystem: "com.weisen.WSOnBoarding",
    category: "WelcomeScreen"
)

public struct WSWelcomeScreenModifier: ViewModifier {
    @State private var showWelcome: Bool = false
    
    // 内容和样式配置
    let config: WSWelcomeConfig
    
    // 欢迎页面标识符，可以为不同类型的欢迎页面设置不同的键
    let welcomeKey: String

    public init(config: WSWelcomeConfig, welcomeKey: String = "hasSeenWelcomeView") {
        self.config = config
        self.welcomeKey = welcomeKey
    }

    public func body(content: Content) -> some View {
        content
            .task {
                checkAndShowWelcome()
            }
            .sheet(
                isPresented: $showWelcome,
                onDismiss: {
                    markWelcomeAsSeen()
                }
            ) {
                AppleTranslationStyleWelcomeView(config: config)
            }
    }

    private func checkAndShowWelcome() {
        let hasSeenWelcome = UserDefaults.standard.bool(forKey: welcomeKey)
        if !hasSeenWelcome {
            logger.info("首次启动应用，显示欢迎页面")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showWelcome = true
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
public extension View {
    /// 添加欢迎页面
    /// - Parameters:
    ///   - config: 欢迎页面配置
    ///   - welcomeKey: UserDefaults键，用于跟踪是否已显示过欢迎页面
    /// - Returns: 修改后的视图
    func wsWelcomeView(
        config: WSWelcomeConfig,
        welcomeKey: String = "hasSeenWelcomeView"
    ) -> some View {
        self.modifier(WSWelcomeScreenModifier(config: config, welcomeKey: welcomeKey))
    }
} 