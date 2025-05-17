import XCTest
@testable import WSOnBoarding

final class WSOnBoardingTests: XCTestCase {
    func testFeatureItemCreation() {
        // 测试创建一个完整的功能项目
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
    
    func testFeatureItemWithOptionalFields() {
        // 测试创建没有图标的功能项
        let featureNoIcon = FeatureItem(
            title: "无图标功能",
            description: "这个功能没有图标",
            color: .red
        )
        
        XCTAssertNil(featureNoIcon.icon)
        XCTAssertEqual(featureNoIcon.title, "无图标功能")
        XCTAssertEqual(featureNoIcon.description, "这个功能没有图标")
        
        // 测试创建没有描述的功能项
        let featureNoDescription = FeatureItem(
            icon: "gear",
            title: "无描述功能",
            color: .green
        )
        
        XCTAssertEqual(featureNoDescription.icon, "gear")
        XCTAssertEqual(featureNoDescription.title, "无描述功能")
        XCTAssertNil(featureNoDescription.description)
        
        // 测试只有标题的功能项
        let featureMinimal = FeatureItem(
            title: "最简功能",
            color: .blue
        )
        
        XCTAssertNil(featureMinimal.icon)
        XCTAssertEqual(featureMinimal.title, "最简功能")
        XCTAssertNil(featureMinimal.description)
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
        let introText = "这是一段介绍文本，用于说明应用的功能和数据使用情况。"
        let config = WSWelcomeConfig(
            appName: "完整测试",
            introText: introText,
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
        XCTAssertEqual(config.introText, introText)
        XCTAssertEqual(config.iconSymbol, "gear")
        XCTAssertEqual(config.iconName, "customIcon")
        XCTAssertEqual(config.continueButtonText, "开始使用")
        XCTAssertEqual(config.titleText, "全功能测试")
        XCTAssertEqual(config.privacyButtonText, "隐私条款")
        XCTAssertNotNil(config.privacyAction)
    }
}
