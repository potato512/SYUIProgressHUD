Pod::Spec.new do |s|
  s.name         = "SYProgressHUD"
  s.version      = "1.2.0"
  s.summary      = "SYProgressHUD used to show message which can be auto hide or while touch."
  s.homepage     = "https://github.com/potato512/SYProgressHUD"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "herman" => "zhangsy757@163.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/potato512/SYProgressHUD.git", :tag => "#{s.version}" }
  s.source_files  = "SYProgressHUD/*.{h,m}"
  s.frameworks   = "UIKit", "Foundation"
  s.requires_arc = true
end