#
# Be sure to run `pod lib lint CustomAlertKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CustomAlertKit'
  s.version          = '1.1.1'
  s.summary          = 'CustomAlertKit provides a customizable bottomsheet, snackbar and alert for any SwiftUI View'

  s.description      = 'CustomAlertKit provides a customizable bottomsheet, snackbar and alert for any SwiftUI View. Custom content with fluid animations.'

  s.homepage         = 'https://github.com/bence-t0th/CustomAlertKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bence-t0th' => 'bence.toth.work@icloud.com' }
  s.source           = { :git => 'https://github.com/bence-t0th/CustomAlertKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'
  s.swift_version = '5.0'

  s.source_files = 'Sources/CustomAlertKit/**/*'
end
