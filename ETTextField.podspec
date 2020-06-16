Pod::Spec.new do |s|
  s.name         = "ETTextField"
  s.version      = "0.1"
  s.summary      = "ETTextField is an extension of traditional UITextField which simplifies its customization and event handling."
  s.description  = <<-DESC
    ETTextField is an extension of traditional UITextField which simplifies its customization and event handling.
  DESC
  s.homepage     = "https://github.com/EtneteraMobile/ETTextField"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Miroslav Beles" => "miroslav.beles@etnetera.cz" }
  s.social_media_url   = ""
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => ".git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
