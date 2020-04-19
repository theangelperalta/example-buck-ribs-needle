# Set the platform globally
platform :ios, '13.0'

# Only download the files, don't create Xcode projects
install! 'cocoapods', integrate_targets: false

target 'Example-Buck-RIBS-Needle' do
  pod 'CryptoSwift'
  pod 'Bugsnag'
  pod 'PromiseKit/CorePromise', '6.1.1'
  pod 'PromiseKit/CoreLocation', '6.1.1'
  pod 'Quick', '2.1.0'
  pod 'Nimble', '8.0.2'
  pod 'NeedleFoundation', :podspec => './LocalPods/NeedleFoundation/NeedleFoundation.podspec'
  pod 'RIBs', :podspec => './LocalPods/RIBs/RIBs.podspec'
  pod 'RxCocoa', '5.0.1'
  pod 'SnapKit', '~> 4.0.0'
end
