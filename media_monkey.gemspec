# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "media_monkey/version"

Gem::Specification.new do |s|
  s.name        = "media_monkey"
  s.version     = MediaMonkey::VERSION
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.authors     = ["Patrick Paul-Hus", "David Cornu"]
  s.email       = ["pat@artfox.com", "david@artfox.com"]
  s.homepage    = "https://github.com/Artfox/MediaMonkey"
  s.summary     = "CDN and thumbnail generator for web apps."
  s.description = <<-description
    MediaMonkey is a Sinatra and Nginx powered CDN and thumbnail generator
    for web applications. 
      
    Simply POST your file, and MediaMonkey will jump through hoops to generate
    the necessary thumbnails, place them in the appropriate folder and return
    a URL so you can access it in the future. You can also DELETE that url to
    remove the file.
    
    All GET requests are served by Nginx, including a manifest.json file in each
    directory allowing for easy access via JavaScript.
    
    You can also define defaults, which Nginx will serve should the file not exist.
    This can be extremely useful for avatars where you don't necessarily want to
    query your database to show an image or the avatar.
  description

  s.rubyforge_project = "media_monkey"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
