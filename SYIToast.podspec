Pod::Spec.new do |s|
  s.name         = "SYIToast"
  s.version      = "1.1.7"
  s.summary      = "SYIToast used to show message which can be auto hide or while touch."
  s.homepage     = "https://github.com/potato512/SYToast"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "herman" => "zhangsy757@163.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/potato512/SYToast.git", :tag => "#{s.version}" }
  s.source_files  = "SYIToast/*.{h,m}"
  s.frameworks   = "UIKit", "Foundation"
  s.requires_arc = true
end