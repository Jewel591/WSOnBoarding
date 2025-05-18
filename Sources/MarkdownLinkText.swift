import SwiftUI

/// 支持Markdown链接的文本视图
struct MarkdownLinkText: View {
    let text: String
    @Environment(\.openURL) private var openURL

    var body: some View {
        if let (beforeLink, linkText, linkURL, afterLink) = parseMarkdownLink(
            from: text
        ) {
            HStack(spacing: 0) {
                Text(beforeLink)
                Link(
                    linkText,
                    destination: URL(string: linkURL) ?? URL(
                        string: "https://apple.com"
                    )!
                )
                .foregroundColor(.blue)
                Text(afterLink)
            }
        } else {
            Text(text)
        }
    }

    /// 简单解析Markdown风格的链接： [linkText](linkURL)
    private func parseMarkdownLink(from text: String) -> (
        String, String, String, String
    )? {
        // 查找 [linkText](linkURL) 格式的链接
        let pattern = "\\[([^\\]]+)\\]\\(([^\\)]+)\\)"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])

        guard let regex = regex,
            let match = regex.firstMatch(
                in: text,
                options: [],
                range: NSRange(location: 0, length: text.utf16.count)
            )
        else {
            return nil
        }

        guard let linkTextRange = Range(match.range(at: 1), in: text),
            let linkURLRange = Range(match.range(at: 2), in: text)
        else {
            return nil
        }

        let linkText = String(text[linkTextRange])
        let linkURL = String(text[linkURLRange])

        let fullMatchRange = Range(match.range, in: text)!
        let beforeLink = text.prefix(upTo: fullMatchRange.lowerBound)
        let afterLink = text.suffix(from: fullMatchRange.upperBound)

        return (String(beforeLink), linkText, linkURL, String(afterLink))
    }
}
