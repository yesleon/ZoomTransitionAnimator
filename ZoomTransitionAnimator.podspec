#
# Be sure to run `pod lib lint ZoomTransitionAnimator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZoomTransitionAnimator'
  s.version          = '0.1.0'
  s.summary          = 'For Pinterest-like zoom transition where the whole scene zoom with the cell.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A zoom transition animator, which lets you zoom between two view controllers. It zooms the whole scene, not just the image view or the cell.

It can zoom anything, because it depends on CGRect not UIView.
                       DESC

  s.homepage         = 'https://github.com/yesleon/ZoomTransitionAnimator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yesleon' => 'yesleon@me.com' }
  s.source           = { :git => 'https://github.com/yesleon/ZoomTransitionAnimator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZoomTransitionAnimator/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZoomTransitionAnimator' => ['ZoomTransitionAnimator/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
