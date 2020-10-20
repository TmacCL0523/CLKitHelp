#
# Be sure to run `pod lib lint CLKitHelp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CLKitHelp'
  s.version          = '1.1.1'
  s.summary          = '工具类'
  s.description      = '常年开早已习惯了自己写的一些类库、方法,所以就写了这个开发类库。为方便就有了它！！！'

  s.homepage         = 'https://github.com/TmacCL0523'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '工具人' => 'hongcl8114@hotmail.com' }
  s.source           = { :git => 'https://github.com/TmacCL0523/CLKitHelp.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'CLKitHelp/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CLKitHelp' => ['CLKitHelp/Assets/*.png']
  # }

   s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking'
   s.dependency 'CocoaAsyncSocket'
   s.dependency 'SocketRocket'
   s.dependency 'MBProgressHUD'
   s.dependency 'YYCache'
   s.dependency 'YYModel'
   s.dependency 'MJRefresh'
   s.dependency 'DZNEmptyDataSet'
   s.dependency 'Masonry'
end
