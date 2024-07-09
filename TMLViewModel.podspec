$version = "0.0.1"

Pod::Spec.new do |s|
  s.name         = "TMLViewModel" 
  s.version      = $version
  s.summary      = "TMLViewModel."
  s.description  = "TMLViewModel."
  s.homepage     = "https://github.com/tang4595/TMLViewModel"
  
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "tang" => "tang@apple.com" }
  s.source       = { :git => "https://github.com/tang4595/", :tag => $version }
  s.source_files = "TMLViewModel/Classes/**/*"
  s.resource_bundles = {
    'TMLViewModelResource' => ['TMLViewModel/Assets/*.{xcassets,json,plist}']
  }

  s.platform = :ios, "11.0"
  s.swift_versions = ['5.0', '5.1', '5.2', '5.3', '5.4']
  s.pod_target_xcconfig = { 'c' => '-Owholemodule' }
end