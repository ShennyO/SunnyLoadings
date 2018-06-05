#
# Be sure to run `pod lib lint SunnyLoadings.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SunnyLoadings'
  s.version          = '0.1.0'
  s.summary          = 'SunnyLoadings is a smooth, simple to use loading indicator.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'SunnyLoadings makes it easy to create a beautiful loading animation indicator. Developers can use this library when they need an indicator for loading'
                       DESC

  s.homepage         = 'https://github.com/ShennyO/SunnyLoadings'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ShennyO' => 'ShenOuyang.work@gmail.com' }
  s.source           = { :git => 'https://github.com/ShennyO/SunnyLoadings.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.0'
  s.source_files = 'SunnyLoadings/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SunnyLoadings' => ['SunnyLoadings/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
