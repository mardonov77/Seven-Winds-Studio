# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'Seven Winds Studio' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'SnapKit'
  pod 'Alamofire'
  pod 'Moya'
  pod 'YandexMapsMobile', '4.8.1-lite'
  pod 'FBSDKCoreKit', :inhibit_warnings => true
  pod 'Kingfisher'
  # Pods for todo-ios

post_install do |installer|
     installer.generated_projects.each do |project|
           project.targets.each do |target|
               target.build_configurations.each do |config|
                   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
                   config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
                end
           end
    end
 end
 
end
