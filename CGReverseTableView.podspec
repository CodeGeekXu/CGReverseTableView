#
# Be sure to run `pod lib lint CGReverseTableView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CGReverseTableView'
  s.version          = '0.1.0'
  s.summary          = 'A tableview refreshed from the bottom to top,just like WeChat.类似于微信聊天页面一样从底部开始刷新的tableView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

#  s.description      = <<-DESC
# TODO: Add long description of the pod here.
#                       DESC

  s.homepage         = 'https://github.com/CodeGeekXu/CGReverseTableView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'codegeekxu@gmail.com' => 'codegeekxu@gmail.com' }
  s.source           = { :git => 'https://github.com/CodeGeekXu/CGReverseTableView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CGReverseTableView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CGReverseTableView' => ['CGReverseTableView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
