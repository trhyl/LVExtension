#
# Be sure to run `pod lib lint LVExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LVExtension'
  s.version          = '0.0.1'
  s.summary          = 'A Extension Tools'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/trhyl/LVExtension.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'newhl' => 'lhy@011@foxmail.com' }
  s.source           = { :git => 'https://github.com/trhyl/LVExtension.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'LVExtension/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LVExtension' => ['LVExtension/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
