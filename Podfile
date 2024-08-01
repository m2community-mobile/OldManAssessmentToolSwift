target 'OldManAssessmentToolSwift' do

    use_frameworks!

 inhibit_all_warnings!
 
 pod 'Alamofire'
 pod 'FontAwesome.swift'
 pod 'SDWebImage', '~> 4.0'
 pod 'Firebase/Core'
 pod 'Firebase/Messaging'
 pod 'SDWebImage/GIF'
 pod 'KeychainSwift', '~> 13.0'
    
end




target 'OldManAssessmentToolSwift Enter' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!


platform :ios, '11.0'


    inhibit_all_warnings!

     pod 'Alamofire'
pod 'FontAwesome.swift'
 pod 'SDWebImage', '~> 4.0'
 pod 'Firebase/Core'
 pod 'Firebase/Messaging'
 pod 'SDWebImage/GIF'
 pod 'KeychainSwift', '~> 13.0'
    
end






post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
               end
          end
   end
end
