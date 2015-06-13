Gem::Specification.new do |spec|
  spec.name          = "nhk-easy-ruby"
  spec.version       = "0.0.0"
  spec.authors       = ["Zachary Scott"]
  spec.email         = ["e@zzak.io"]

  spec.summary       = %q{Ruby client library for NHK News Web Easy.}
  spec.description   = %q{Read the news with this Ruby interface for NHK's public API.}
  spec.homepage      = "https://rubygems.org/gems/nhk-easy-ruby"
  spec.license       = "MIT"

  spec.files         = Dir.glob(["lib/**/*", "nhk-easy-ruby.gemspec"])

  spec.require_paths = ["lib"]
end
