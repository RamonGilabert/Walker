Pod::Spec.new do |s|
  s.name             = "Walker"
  s.summary          = "A travel companion for your animations."
  s.version          = "0.10.0"
  s.homepage         = "https://github.com/RamonGilabert/Walker"
  s.license          = 'MIT'
  s.author           = { "Ramon Gilabert" => "ramon.gilabert.llop@gmail.com" }
  s.source           = { :git => "https://github.com/RamonGilabert/Walker.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/RamonGilabert'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Source/**/*'
  s.frameworks = 'AVFoundation'
end
