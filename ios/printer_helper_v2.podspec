#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint printer_helper_v2.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'printer_helper_v2'
  s.version          = '0.0.1'
  s.summary          = 'plugin connect printer'
  s.description      = <<-DESC
plugin connect printer
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  # s.ios.vendored_library = 'libZSDK_API.a'
  s.swift_version = '5.0'
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386', :modular_headers => true }

end
