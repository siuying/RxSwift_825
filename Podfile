# Uncomment this line to define a global platform for your project
platform :ios, '10.0'

target 'RxDataSourcesExample' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # RxSwift is a functional reactive programming framework
  pod 'RxSwift', git: 'https://github.com/ReactiveX/RxSwift.git', branch: 'swift-3.0'

  # RxCocoa is Cocoa extension to RxSwift
  pod 'RxCocoa', git: 'https://github.com/ReactiveX/RxSwift.git', branch: 'swift-3.0'

  # RxDataSources is UITableView/UICollectionView datasource extension for RxSwift
  pod 'RxDataSources', git: 'https://github.com/siuying/RxDataSources.git', branch: 'swift-3.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            # slience Xcode for asking us migrate to Swift 3
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
