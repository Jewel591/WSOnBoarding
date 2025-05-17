import SwiftUI
import os

private let logger = Logger(
    subsystem: "com.weisen.WSOnBoarding",
    category: "AppleWelcomeView"
)

public struct AppleTranslationStyleWelcomeView: View {
    @Environment(\.dismiss) private var dismiss

    /// 显示内容和样式配置
    var config: WSWelcomeConfig

    public init(config: WSWelcomeConfig) {
        self.config = config
    }

    public var body: some View {
        VStack(spacing: 0) {
            // 顶部App图标
            VStack {
                Spacer()
                    .frame(height: 40)

                // 使用独立的图标组件
                WSWelcomeIconView(config: config)

                Spacer()
                    .frame(height: 30)
            }

            // 标题区域
            VStack(spacing: 20) {
                Text(config.titleText)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                // 介绍文本 - 仅当提供时显示
                if let introText = config.introText {
                    Text(introText)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 24)
                        .padding(.top, 8)
                }
            }
            .padding(.bottom, 40)

            // 功能列表 - 根据条目数量采用不同的显示方式
            if config.features.count == 1,
                let singleFeature = config.features.first
            {
                // 单条功能项 - 采用大字体居中显示，不显示图标和标题
                if let description = singleFeature.description {
                    Text(description)
                        .font(.title3)
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                }
            } else {
                // 多条功能项 - 保持原有的显示方式
                VStack(alignment: .leading, spacing: 30) {
                    ForEach(config.features) { feature in
                        FeatureRow(feature: feature)
                    }
                }
                .padding(.horizontal, 24)
            }

            Spacer()

            // 底部声明文本 - 小字体说明
            if let disclaimerText = config.disclaimerText {
                VStack {
                    Text(disclaimerText)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 20)
                }
            }

            // 底部区域
            VStack(spacing: 16) {
                Button {
                    logger.info("用户点击了继续按钮，关闭欢迎页面")
                    dismiss()
                } label: {
                    Text(config.continueButtonText)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(config.primaryColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)

                if let privacyText = config.privacyText {
                    Button {
                        logger.info("用户点击了隐私政策链接")
                        config.privacyAction?()
                    } label: {
                        Text(privacyText)
                            .font(.footnote)
                            .foregroundColor(config.primaryColor)
                    }
                    .padding(.bottom, 20)
                }
            }

            // 底部指示器
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(2.5)
                .foregroundColor(.clear)
                .padding(.bottom, 8)
        }
    }
}

struct FeatureRow: View {
    let feature: FeatureItem

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // 图标容器 - 仅当有图标时显示
            if let iconName = feature.icon {
                Image(systemName: iconName)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(feature.color)
                    .cornerRadius(10)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(feature.title)
                    .font(.headline)
                    .fontWeight(.semibold)

                // 描述文本 - 仅当有描述时显示
                if let description = feature.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
        }
        .contentShape(Rectangle())
    }
}

// 用于Preview的示例数据
extension AppleTranslationStyleWelcomeView {
    fileprivate static var previewConfig: WSWelcomeConfig {
        let features: [FeatureItem] = [
            FeatureItem(
                icon: "photo.on.rectangle",
                title: "视觉识别",
                description: "选取并识别图像中的内容。",
                color: .blue
            ),
            // 不带图标的功能
            FeatureItem(
                icon: nil,
                title: "快速响应",
                description: "超快速分析，无需等待即可获得结果。",
                color: .orange
            ),
            // 不带描述的功能
            FeatureItem(
                icon: "wifi.slash",
                title: "离线支持",
                color: .green
            ),
        ]

        return WSWelcomeConfig(
            appName: "VLMind",
            introText: "VLMind 利用先进的视觉模型，在本地设备上提供高效准确的图像识别服务，保护您的隐私安全。",
            features: features,
            // 如果要测试iconName，可以取消下面这行的注释并提供一个Assets中存在的图片名称
            // iconName: "YourAppIcon",
            iconSymbol: "camera.viewfinder",
            disclaimerText: "您的设备信息和使用数据将用于提供个性化体验，改进应用功能和防止欺诈。查看详细隐私政策了解更多信息。"
                //            iconName: "AppIcon"
        )
    }
}

// 另一个使用iconName的预览示例
extension AppleTranslationStyleWelcomeView {
    fileprivate static var iconNamePreviewConfig: WSWelcomeConfig {
        return WSWelcomeConfig(
            appName: "图标示例",
            introText: "这个示例展示了使用Assets中图标的效果",
            features: [],
            iconName: "AppIconPreview"  // 需要在Assets中添加这个图标
        )
    }

    // 如需查看iconName效果，可以启用此预览
    static var iconNamePreview: some View {
        AppleTranslationStyleWelcomeView(
            config: iconNamePreviewConfig
        )
    }

    // 单条功能项的预览示例 - 复现Siri隐私页面
    fileprivate static var singleFeatureConfig: WSWelcomeConfig {
        return WSWelcomeConfig(
            appName: "Siri与听写",
            introText: nil,
            features: [
                FeatureItem(
                    title: "隐私声明",  // 标题不会显示，但需要提供
                    description:
                        "允许Apple储存并查看你在这台iPhone及其连接的Apple Watch、HomePod或支持Siri的配件上，与Siri、\"听写\"和\"翻译\"的音频交互和听写文本，帮助改进Siri和\"听写\"。你可以稍后在设置中更改。",
                    color: .blue  // 颜色不会显示，但需要提供
                )
            ],
            iconSymbol: "mic.circle.fill",
            primaryColor: .pink,
            continueButtonText: "继续",
            disclaimerText:
                "你的设备、搜索、服务、浏览、购买、Apple Store购物活动和设备信任状态可能被用于个性化你的体验、发送你通知、提供和改进商店，以及防止欺诈。"
        )
    }

    static var singleFeaturePreview: some View {
        AppleTranslationStyleWelcomeView(
            config: singleFeatureConfig
        )
    }
}

#Preview("默认样式") {
    AppleTranslationStyleWelcomeView(
        config: AppleTranslationStyleWelcomeView.previewConfig
    )
}

#Preview("单条功能项") {
    AppleTranslationStyleWelcomeView(
        config: AppleTranslationStyleWelcomeView.singleFeatureConfig
    )
}
