#
# Be sure to run `pod lib lint Prestyler.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Prestyler'
  s.version          = '0.1.0'
  s.summary          = 'Tiny attributedString creator.'
  s.homepage         = 'https://github.com/kruil/Prestyler'
  s.swift_version    = '4.2'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ilia Krupko' => '' }
  s.source           = { :git => 'https://github.com/kruil/Prestyler.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.0'
  s.source_files = 'Prestyler/Classes/*.swift'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
