Pod::Spec.new do |s|
  s.name             = 'Petal'
  s.version          = '2.0.0'
  s.license          = 'MIT'
  s.summary          = 'Petal is a beautiful activity indicator to show that a task is in progress'
  s.homepage         = 'https://github.com/yannickl/Petal.git'
  s.social_media_url = 'https://twitter.com/yannickloriot'
  s.authors          = { 'Yannick Loriot' => 'contact@yannickloriot.com' }
  s.source           = { :git => 'https://github.com/yannickl/Petal.git', :tag => s.version }
  s.screenshot       = 'http://yannickloriot.com/resources/petal-anim.gif'

  s.ios.deployment_target  = '8.0'
  s.ios.frameworks         = 'UIKit', 'QuartzCore'

  s.source_files = 'Sources/*.swift'
  s.requires_arc = true
end
