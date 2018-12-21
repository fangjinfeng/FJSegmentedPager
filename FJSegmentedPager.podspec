Pod::Spec.new do |s|
  s.name         = "FJSegmentedPager"
  s.version      = "1.1.2"
  s.summary      = "Segmented pager with Parallax header"
  s.homepage     = "http://www.jianshu.com/p/bea2bfed3f3f"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'fangjinfeng' => '116418179@qq.com' }
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.source       = { :git => "https://github.com/fangjinfeng/FJSegmentedPager.git", :tag => "1.1.2" }
  s.source_files = "FJSegmentedPager/**/*.{h,m}"
  s.requires_arc = true
  s.framework  = 'UIKit'
end
