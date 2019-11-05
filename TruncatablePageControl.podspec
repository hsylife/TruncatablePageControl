Pod::Spec.new do |s|
  s.name         = "TruncatablePageControl"
  s.version      = "0.1.3"
  s.summary      = "Truncatable page control."
  s.license      = "MIT"
  s.homepage     = "https://github.com/hsylife/TruncatablePageControl"
  s.author       = { "Yuta Hoshino" => "ythshn@gmail.com" }
  s.source       = { :git => "https://github.com/hsylife/TruncatablePageControl.git", :tag => s.version }
  s.platform     = :ios, '11.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.source_files = "TruncatablePageControl/*.swift"
  s.resources    = "TruncatablePageControl/*.xib"
end
