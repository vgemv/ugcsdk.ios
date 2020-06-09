#
# Be sure to run `pod lib lint JSPLayerSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'jsugcsdk'
  s.version          = "0.1.2 "
  s.summary          = 'JSUGCSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
JSUGCSDK for JS live platform.
                       DESC

  s.homepage         = 'https://github.com/vgemv/ugcsdk.ios'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ssddawei' => '/' }
  s.source           = { :git => 'https://github.com/vgemv/ugcsdk.ios.git', :tag => s.version.to_s }

  s.platform         = :ios
  s.ios.deployment_target = '10.0'
  s.ios.vendored_frameworks = 'ugcsdk.framework'
  s.resources = 'ugcsdk.bundle'

end
