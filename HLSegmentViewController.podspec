#
# Be sure to run `pod lib lint HLSegmentViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HLSegmentViewController'
  s.version          = '1.3.0'
  s.summary          = '简单易用的SegmentViewController，可以快速实现网易新闻，今日头像类似的主页效果'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  简单易用的SegmentViewController，可以快速实现网易新闻，今日头像类似的主页效果
  使用简单 方便易用 对项目无浸入性
                       DESC

  s.homepage         = 'https://github.com/DargonLee/HLSegmentViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DargonLee' => '2461414445@qq.com' }
  s.source           = { :git => 'https://github.com/DargonLee/HLSegmentViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HLSegmentViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HLSegmentViewController' => ['HLSegmentViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
