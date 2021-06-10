#
# Be sure to run `pod lib lint TappableLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TappableLabel'
  s.version          = '0.1.0'
  s.summary          = 'Add links detection on UILabel, no subclasses.'

  s.description      = <<-DESC
TappableLabel is an extension on UILabel, which adds link detection.CocoaPods
In order to use it, just `import TappableLabel` and then use `label.addLinkDetection { url in ... }` in your code.
There are no subclasses to substitue your UILabels with, it works with existing labels automagically.
                       DESC

  s.homepage         = 'https://github.com/tadelv/TappableLabel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tadelv' => 'vid@tadel.net' }
  s.source           = { :git => 'https://github.com/tadelv/TappableLabel.git', :tag => s.version.to_s }
  s.swift_version    = '5.3'

  s.ios.deployment_target = '12.1'

  s.source_files = 'TappableLabel/Classes/**/*'
  s.frameworks = 'UIKit'
end
