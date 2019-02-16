#
#  Be sure to run 'pod spec lint ColorKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # 1 - general information
  s.name         = "ColorKit"
  s.summary      = "A short description"
  s.description  = <<-DESC
			Description of the framework ColorKit
                   DESC
  # 2 - framework version
  s.version      = "0.0.1"


  # 3 - license
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  # 4 - author information
  s.author       = { "Lorenzo Bernaschina" => "lorenzo.bernaschina@mail.polimi.it" }
  s.homepage     = "http://EXAMPLE/ColorKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  # 5 - Git URL
  s.source = { :path => '.' }
  #  s.source = { :git => "http://EXAMPLE/ColorKit.git", :tag => "#{s.version}" }
   

  # 6 - Source files position
  s.source_files  = "ColorKit/**/**"
  # s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Classes/**/*.h"


  # 7 - Xconfig
  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
end
