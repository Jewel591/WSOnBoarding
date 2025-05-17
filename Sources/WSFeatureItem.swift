import SwiftUI

/// 欢迎页面中的功能项目
public struct FeatureItem: Identifiable {
    /// 唯一标识符
    public let id = UUID()
    
    /// SF Symbol图标名称 (可选)
    public let icon: String?
    
    /// 功能标题
    public let title: String
    
    /// 功能描述 (可选)
    public let description: String?
    
    /// 图标背景颜色
    public let color: Color
    
    /// 创建一个功能项
    /// - Parameters:
    ///   - icon: SF Symbol图标名称 (可选)
    ///   - title: 功能标题
    ///   - description: 功能描述 (可选)
    ///   - color: 图标背景颜色
    public init(icon: String? = nil, title: String, description: String? = nil, color: Color) {
        self.icon = icon
        self.title = title
        self.description = description
        self.color = color
    }
} 