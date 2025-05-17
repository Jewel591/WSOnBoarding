import XCTest
@testable import WSOnBoarding

final class WSOnBoardingTests: XCTestCase {
    func testFeatureItemCreation() {
        // 测试创建一个功能项目
        let feature = FeatureItem(
            icon: "star.fill",
            title: "测试功能",
            description: "这是一个测试功能描述",
            color: .blue
        )
        
        XCTAssertEqual(feature.icon, "star.fill")
        XCTAssertEqual(feature.title, "测试功能")
        XCTAssertEqual(feature.description, "这是一个测试功能描述")
    }
    
    func testWelcomeConfigDefaults() {
        // 测试欢迎页面配置的默认值
        let config = WSWelcomeConfig(appName: "测试App", features: [])
        
        XCTAssertEqual(config.appName, "测试App")
        XCTAssertEqual(config.titleText, "欢迎使用 \"测试App\"")
        XCTAssertEqual(config.continueButtonText, "继续")
        XCTAssertNil(config.customTitle)
    }
    
    func testWelcomeConfigCustomization() {
        // 测试初始化时设置属性
        let config = WSWelcomeConfig(
            appName: "测试App", 
            features: [],
            iconSymbol: "star.fill",
            customTitle: "自定义标题"
        )
            
        XCTAssertEqual(config.customTitle, "自定义标题")
        XCTAssertEqual(config.titleText, "自定义标题")
        XCTAssertEqual(config.iconSymbol, "star.fill")
    }
    
    func testWelcomeConfigWithAllParameters() {
        // 测试所有参数都设置的情况
        let config = WSWelcomeConfig(
            appName: "完整测试",
            features: [],
            iconSymbol: "gear",
            iconName: "customIcon",
            primaryColor: .red,
            secondaryColor: .green,
            continueButtonText: "开始使用",
            customTitle: "全功能测试",
            privacyButtonText: "隐私条款",
            privacyAction: {}
        )
        
        XCTAssertEqual(config.appName, "完整测试")
        XCTAssertEqual(config.iconSymbol, "gear")
        XCTAssertEqual(config.iconName, "customIcon")
        XCTAssertEqual(config.continueButtonText, "开始使用")
        XCTAssertEqual(config.titleText, "全功能测试")
        XCTAssertEqual(config.privacyButtonText, "隐私条款")
        XCTAssertNotNil(config.privacyAction)
    }
}
