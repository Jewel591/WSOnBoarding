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

    /// 创建欢迎页面配置
    /// - Parameters:
    ///   - appName: 应用名称
    ///   - features: 功能列表
    ///   - iconSymbol: SF Symbol图标名称 (可选)
    ///   - iconName: Assets中的图片名称 (可选)
    ///   - primaryColor: 主要颜色 (默认为蓝色)
    ///   - secondaryColor: 次要颜色 (默认为靛蓝色)
    ///   - continueButtonText: 继续按钮文字 (默认为"继续")
    ///   - customTitle: 自定义标题 (可选)
    ///   - privacyButtonText: 隐私政策按钮文字 (可选)
    ///   - privacyAction: 隐私政策按钮点击回调 (可选)
    public init(
        appName: String, 
        features: [FeatureItem],
        iconSymbol: String? = nil,
        iconName: String? = nil,
        primaryColor: Color = .blue,
        secondaryColor: Color = .indigo,
        continueButtonText: String = "继续",
        customTitle: String? = nil,
        privacyButtonText: String? = nil,
        privacyAction: (() -> Void)? = nil
    ) {
        self.appName = appName
        self.features = features
        self.iconSymbol = iconSymbol
        self.iconName = iconName
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.continueButtonText = continueButtonText
        self.customTitle = customTitle
        self.privacyButtonText = privacyButtonText
        self.privacyAction = privacyAction
    }

    /// 获取显示的标题文本
    public var titleText: String {
        return customTitle ?? "欢迎使用 \"\(appName)\""
    }

    /// 获取隐私政策文本（如果有）
    public var privacyText: String? {
        return privacyButtonText
            ?? (privacyAction != nil ? "关于\(appName)与隐私..." : nil)
    }
}
