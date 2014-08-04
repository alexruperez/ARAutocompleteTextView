Pod::Spec.new do |s|
  s.name         = 'ARAutocompleteTextView'
  s.version      = '0.0.1'
  s.summary      = "Subclass of UITextView that automatically displays text suggestions in real-time."
  s.homepage     = 'https://github.com/alexruperez/ARAutocompleteTextView'
  s.screenshots  = 'https://raw.githubusercontent.com/alexruperez/ARAutocompleteTextView/master/ARTextViewAutocompletion.png'
  s.license      = 'MIT'
  s.author       = { "alexruperez" => "contact@alexruperez.com" }
  s.social_media_url   = 'https://twitter.com/alexruperez'
  s.platform     = :ios
  s.source       = { :git => 'https://github.com/alexruperez/ARAutocompleteTextView.git', :tag => '0.0.1' }
  s.source_files  = 'ARAutocompleteTextView', "Classes/*.{h,m}"
  s.requires_arc = true
end