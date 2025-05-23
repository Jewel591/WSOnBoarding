import SwiftUI

/// 欢迎页面的图标组件
///
/// 显示优先级:
/// 1. 首先尝试使用Assets中的图片(iconName)
/// 2. 其次使用SF Symbol图标(iconSymbol)
/// 3. 最后使用默认图标
public struct WSWelcomeIconView: View {
    let config: WSWelcomeConfig

    public init(config: WSWelcomeConfig) {
        self.config = config
    }

    public var body: some View {
        // 使用@ViewBuilder根据不同情况显示不同视图
        if let appIconName = config.iconName {
            // 优先使用Assets中的应用图标 - 无背景
            Image(appIconName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .cornerRadius(80*0.205)
        } else if let customSymbol = config.iconSymbol {
            // 其次使用SF Symbol图标 - 带背景
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(config.primaryColor)
                    .frame(width: 80, height: 80)
                
                Image(systemName: customSymbol)
                    .font(.system(size: 36))
                    .foregroundColor(.white)
            }
        } else {
            // 最后使用默认图标 - 带背景
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(config.primaryColor)
                    .frame(width: 80, height: 80)
                
                // 默认图标 - 视觉相关图标
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
    }
}

// 预览WSWelcomeIconView组件
#Preview("Icon Component") {
    VStack(spacing: 20) {
        // 使用SF Symbol
        WSWelcomeIconView(
            config: WSWelcomeConfig(
                appName: "测试",
                features: [],
                iconSymbol: "star.fill"
            )
        )

        // 使用默认图标
        WSWelcomeIconView(
            config: WSWelcomeConfig(
                appName: "测试",
                features: []
            )
        )

        Text("图标组件预览")
            .font(.headline)
    }
    .padding()
}
