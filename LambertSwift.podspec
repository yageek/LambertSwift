Pod::Spec.new do |s|

  s.name         = "LambertSwift"
  s.version      = "1.0.0"
  s.summary      = "A lightweight library to convert Lambert coordinates to WGS84."
  s.homepage     = "https://github.com/yageek/LambertSwift"
  s.license      = "MIT"
  s.author             = { "Yannick Heinrich" => "yannick.heinrich@gmail.com" }
  s.social_media_url   = "http://twitter.com/yageek"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/yageek/LambertSwift.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/*.swift"
end
