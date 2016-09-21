#
#  Be sure to run `pod spec lint SLBottomToastView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "SLBottomToastView"
    s.version      = "0.0.1"
    s.summary      = "show messgae"


    s.description  = <<-DESC
                        模仿IOS原生底部弹出框，进行相关信息展示
    DESC

    s.homepage     = "https://github.com/boilWater/SLBottomToastView"

    s.license      = "MIT"

    s.author       = { "liangbai" => "baill@adnonstop.com" }
    s.platform     = :ios, "7.0"

    s.source       = { :git => "https://github.com/boilWater/SLBottomToastView.git", :tag => "#{s.version}" }


    s.source_files  = "SLBottomToastView", "SLBottomToastView/**/*.{h,m}"

end
