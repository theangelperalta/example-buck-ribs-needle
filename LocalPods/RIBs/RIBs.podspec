Pod::Spec.new do |s|
  s.name             = 'RIBs'
  s.version          = '0.9.2'
  s.summary          = 'Uber\'s cross-platform mobile architecture.'
  s.description      = <<-DESC
RIBs is the cross-platform architecture behind many mobile apps at Uber. This architecture framework is designed for mobile apps with a large number of engineers and nested states.
                       DESC
  s.homepage         = 'https://github.com/uber/RIBs'
  s.license          = { :type => 'Apache License, Version 2.0', :file => 'LICENSE.txt' }
  s.author           = { 'uber' => 'mobile-open-source@uber.com' }
  s.source           = { :git => 'https://github.com/uber/RIBs.git', :tag => s.version.to_s }
  s.source_files = 'ios/RIBs/Classes/**/*'
  s.ios.frameworks = 'Foundation', 'UIKit'
  s.dependency 'RxSwift', '~> 5.0'
  s.dependency 'RxRelay', '~> 5.0'
  s.swift_version    = '5'
end
