#
# Be sure to run `pod lib lint Prestyler.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Prestyler'
  s.version          = '1.2.0'
  s.summary          = 'Elegant text formatting tool in Swift'
  s.homepage         = 'https://github.com/kruil/Prestyler'
  s.swift_version    = '4.2'
  s.license          = 'MIT'
  s.author           = 'Ilia Krupko'
  s.source           = { :git => 'https://github.com/kruil/Prestyler.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.documentation_url = 'https://kruil.github.io/Prestyler/'
  s.source_files = 'Prestyler/Classes/*.swift'
  s.frameworks = 'UIKit'
end
