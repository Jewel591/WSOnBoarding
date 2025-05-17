import SwiftUI
import os

private let logger = Logger(
    subsystem: "com.weisen.WSOnBoarding",
    category: "FinalCutWelcomeView"
)

/// 采用沉浸式风格的欢迎页面
/// 特点：
/// - 全屏背景图片
/// - 大标题位于顶部
/// - 详细描述位于底部
/// - 底部渐变背景增强文字可读性
public struct WSFinalCutStyleWelcomeView: View {
    @Environment(\.dismiss) private var dismiss

    /// 显示内容和样式配置
    var config: WSWelcomeConfig

    public init(config: WSWelcomeConfig) {
        self.config = config
    }

    public var body: some View {
        // 主内容
        VStack(spacing: 16) {
            Spacer()
            
            // 顶部标题区域
            titleArea

            // 描述文本区域
            descriptionText
                .padding(.horizontal, 32)
                .padding(.bottom, 20)

            // 底部声明文本
            if let disclaimerText = config.disclaimerText {
                Text(disclaimerText)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
            }

            // 继续按钮
            Button {
                logger.info("用户点击了继续按钮，关闭欢迎页面")
                dismiss()
            } label: {
                Text(config.continueButtonText)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // 渐变层 - 作为主内容的背景
        .background(
            LinearGradient(
                colors: [
                    .clear, .black.opacity(0.6), .black.opacity(0.8),
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        // 背景图片层 - 作为渐变层的背景
        .background(
            Group {
                if let imageName = config.backgroundImageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(Color.black.opacity(0.2)) // 半透明覆盖提高文本可读性
                } else {
                    Color.black // 默认背景色
                }
            }
        )
        .ignoresSafeArea() // 忽略安全区域，实现全屏效果
    }

    // 标题区域
    private var titleArea: some View {
        VStack(spacing: 4) {
            Text("欢迎使用")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 60)

            Text(config.appName)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .foregroundStyle(.white)
    }

    // 描述文本
    private var descriptionText: some View {
        VStack {
            if config.features.isEmpty, let introText = config.introText {
                // 如果没有功能项但有介绍文本，直接显示介绍文本
                Text(introText)
                    .font(.title3)
                    .multilineTextAlignment(.center)

            } else if let feature = config.features.first {
                // 只展示第一个功能项的描述
                if let description = feature.description {
                    Text(description)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                }
            }
        }
        .foregroundStyle(.white)
    }
}

// MARK: - 预览
#Preview("Final Cut Style") {
    WSFinalCutStyleWelcomeView(
        config: finalCutPreviewConfig
    )
}

// 预览配置
private var finalCutPreviewConfig: WSWelcomeConfig {
    WSWelcomeConfig(
        appName: "Final Cut Camera",
        features: [
            FeatureItem(
                title: "功能介绍",
                description:
                    "完全掌控你的素材以录制专业视频，连接到iPad版Final Cut Pro以通过实时多机位一次拍摄多个角度。",
                color: .blue
            )
        ],
        backgroundImageName: "FinalCutBackground",  // 需要在Assets中添加
        continueButtonText: "继续"
    )
}
