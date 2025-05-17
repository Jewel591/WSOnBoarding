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

                // 图标容器
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.black)
                        .frame(width: 80, height: 80)

                    if let customSymbol = config.iconSymbol {
                        // 使用提供的SF符号
                        Image(systemName: customSymbol)
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    } else if let appIconName = config.iconName {
                        // 使用提供的图标名称(来自Assets)
                        Image(appIconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    } else {
                        // 默认图标 - VLMind视觉相关图标
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(config.secondaryColor.opacity(0.9))
                                .frame(width: 44, height: 44)

                            Image(systemName: "eyes")
                                .font(.system(size: 24))
                                .symbolVariant(.fill)
                                .foregroundColor(.white)
                        }
                    }
                }

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
            }
            .padding(.bottom, 40)

            // 功能列表
            VStack(alignment: .leading, spacing: 30) {
                ForEach(config.features) { feature in
                    FeatureRow(feature: feature)
                }
            }
            .padding(.horizontal, 24)

            Spacer()

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
                .foregroundColor(.secondary.opacity(0.3))
                .padding(.bottom, 8)
        }
    }
}

struct FeatureRow: View {
    let feature: FeatureItem

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // 图标容器
            Image(systemName: feature.icon)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(feature.color)
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(feature.title)
                    .font(.headline)
                    .fontWeight(.semibold)

                Text(feature.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
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
        ]

        return WSWelcomeConfig(
            appName: "VLMind",
            features: features,
            iconSymbol: "camera.viewfinder"
        )
    }
}

#Preview {
    AppleTranslationStyleWelcomeView(
        config: AppleTranslationStyleWelcomeView.previewConfig
    )
}
