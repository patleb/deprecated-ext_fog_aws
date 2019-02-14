$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ext_fog_aws/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ext_fog_aws"
  s.version     = ExtFogAws::VERSION
  s.authors     = ["Patrice Lebel"]
  s.email       = ["patleb@users.noreply.github.com"]
  s.homepage    = "https://github.com/patleb/ext_fog_aws"
  s.summary     = "ExtFogAws"
  s.description = "ExtFogAws"
  s.license     = "MIT"

  s.files = Dir["lib/**/*", "MIT-LICENSE", "README.md"]

  s.add_dependency "fog-aws"
  s.add_dependency 'mime-types'
end
