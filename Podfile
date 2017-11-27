# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'Dizzy Play' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Advance', :git => 'https://github.com/steadicat/Advance.git' #swift3 fork for Advance
  pod 'BiometricAuth', '~> 2.0.0'
  pod 'Pastel'
  pod 'Spruce', '~> 1.0.0'
  pod 'SwiftySound'
  pod 'anim'
  pod 'ImagePicker'
  pod 'Lightbox'
  pod 'PeekPop', '~> 1.0'
  # Pods for Dizzy Play
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0.2'
        end
    end
end
