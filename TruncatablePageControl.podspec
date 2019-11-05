Pod::Spec.new do |s|
  s.name         = "TruncatablePageControl"
  s.version      = "0.1.0"
  s.summary      = "Truncatable page control."
  s.license      = "MIT"
  s.homepage     = "https://github.com/hsylife/TruncatablePageControl"
  s.author       = { "Yuta Hoshino" => "ythshn@gmail.com" }
  s.source       = { :git => "https://github.com/hsylife/TruncatablePageControl.git", :tag => "0.1.0" }
  s.platform     = :ios, '11.0'
  s.swift_version = '5.0'
  s.requires_arc = true
  s.source_files = 'TruncatablePageControl/**/*.{h,m}'
  s.resources    = 'TruncatablePageControl/**/*.xib'
end
