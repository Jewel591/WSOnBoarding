import SwiftUI

/// 欢迎页面的配置对象，专注于内容和样式的配置
public struct WSWelcomeConfig {
    // 基本内容
    public var appName: String
    public var features: [FeatureItem]
    
    // 图标配置
    public var iconSymbol: String?
    public var iconName: String?
    
    // 样式配置
    public var primaryColor: Color = .blue
    public var secondaryColor: Color = .indigo
    
    // 文本配置
    public var continueButtonText: String = "继续"
    public var privacyButtonText: String? = nil
    
    // 自定义标题(可选，默认为 "欢迎使用 \"[appName]\"")
    public var customTitle: String? = nil
    
    // 回调
    public var privacyAction: (() -> Void)? = nil
    
    /// 创建基本配置
    /// - Parameters:
    ///   - appName: 应用名称
    ///   - features: 功能列表
    public init(appName: String, features: [FeatureItem]) {
        self.appName = appName
        self.features = features
    }
    
    /// 获取显示的标题文本
    public var titleText: String {
        return customTitle ?? "欢迎使用 \"\(appName)\""
    }
    
    /// 获取隐私政策文本（如果有）
    public var privacyText: String? {
        return privacyButtonText ?? (privacyAction != nil ? "关于\(appName)与隐私..." : nil)
    }
}

// 便于使用的扩展方法
public extension WSWelcomeConfig {
    /// 设置自定义SF符号图标
    func withSymbol(_ symbol: String) -> Self {
        var config = self
        config.iconSymbol = symbol
        return config
    }
    
    /// 设置Assets中的图片图标
    func withIcon(_ name: String) -> Self {
        var config = self
        config.iconName = name
        return config
    }
    
    /// 设置主要颜色
    func withPrimaryColor(_ color: Color) -> Self {
        var config = self
        config.primaryColor = color
        return config
    }
    
    /// 设置自定义标题
    func withTitle(_ title: String) -> Self {
        var config = self
        config.customTitle = title
        return config
    }
    
    /// 设置隐私政策相关
    func withPrivacyButton(text: String, action: @escaping () -> Void) -> Self {
        var config = self
        config.privacyButtonText = text
        config.privacyAction = action
        return config
    }
} 