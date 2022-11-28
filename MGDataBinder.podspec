#
# Be sure to run `pod lib lint MGDataBinder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MGDataBinder'
  s.version          = '1.0.0.3'
  s.summary          = 'A lightweight data binding that uses KVO to listen for changes in data and KVC to modify data.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  链式绑定数据
                       DESC

  s.homepage         = 'https://github.com/Maling1255/MGDataBinder'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Maling1255' => '951684507@qq.com' }
  s.source           = { :git => 'https://github.com/Maling1255/MGDataBinder.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'MGDataBinder/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MGDataBinder' => ['MGDataBinder/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
