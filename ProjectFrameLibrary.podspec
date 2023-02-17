#
# Be sure to run `pod lib lint ProjectFrameLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ProjectFrameLibrary'
  s.version          = '0.1.30'
  s.summary          = 'iOS项目框架封装。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lifaqi/ProjectFrameLibrary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '神无月' => 'lfqswy@gmail.com' }
  s.source           = { :git => 'https://github.com/lifaqi/ProjectFrameLibrary.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'ProjectFrameLibrary/Classes/**/*'
  
  # s.resources = ['ProjectFrameLibrary/Assets/*.png']
  s.resource_bundles = {
    'ProjectFrameLibrary' => ['ProjectFrameLibrary/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  # 自动布局
  s.dependency 'SnapKit'
  # 刷新
  s.dependency 'MJRefresh'
  # 加载进度条
  s.dependency 'SVProgressHUD'
  # 数据解析
  s.dependency 'ObjectMapper'
  # 网路请求
  s.dependency 'Moya'
  # 获取设备信息
  s.dependency 'FCUUID'
  # Async
  s.dependency "AsyncSwift"
  # 对NSUserDefaults的封装
  s.dependency 'SwiftyUserDefaults'
  # 检查应用当前的网络连接状况
  s.dependency 'ReachabilitySwift'
end
  

