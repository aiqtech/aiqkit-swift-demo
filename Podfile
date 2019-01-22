# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'aiq-swift-demo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for aiq-swift-demo
  pod 'AIQKit', '~>0.9'
  
  pod 'SVProgressHUD', '~> 2.0'
  pod 'SVWebViewController', '~> 1.0'
  pod 'NFAllocInit', '~> 1.0'
  pod 'FBSDKCoreKit'
  pod 'FBSDKLoginKit'
  pod 'FBSDKShareKit'
  
  target 'aiq-swift-demoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'aiq-swift-demoUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts "POSTINSTALL #{target.name}"
  end
end
