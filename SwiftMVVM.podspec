Pod::Spec.new do |s|
  s.name = 'SwiftMVVM'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'MVVM implementation in swift for iOS'
  s.homepage = 'https://github.com/swiftmvvm/mvvm'
  #s.social_media_url = 'http://twitter.com/AlamofireSF'
  s.authors = { 'Swiftmvvm Software Foundation' => 'yayanyang@gmail.com' }
  s.source = { :git => 'https://github.com/swiftmvvm/mvvm.git', :tag => "develop" }
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'SwiftMVVM/SwiftMVVM/*'

  s.dependency 'RxSwift','~> 2.0'
  s.dependency 'Action', '~> 1.2.2'
  s.dependency 'RxCocoa', '~> 2.5.0'
end