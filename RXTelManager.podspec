

Pod::Spec.new do |s|
  s.name     = "RXTelManager"
  s.version  = "0.2"
  s.license  = "MIT"
  s.summary  = "RXTelManager is a normal call tel”
  s.homepage = "https://github.com/xzjxylophone/RXTelManager"
  s.author   = { 'Rush.D.Xzj' => 'xzjxylophoe@gmail.com' }
  s.social_media_url = "http://weibo.com/xzjxylophone"
  s.source   = { :git => 'https://github.com/xzjxylophone/RXTelManager.git', :tag => "v#{s.version}" }
  s.description = %{
      RXTelManager is a normal call tel.
  }
  s.source_files = 'RXTelManager/*.{h,m}'
  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true
  s.platform = :ios, '7.0'
end






