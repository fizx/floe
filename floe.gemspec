# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'floe/version'

Gem::Specification.new do |spec|
  spec.name          = "floe"
  spec.version       = Floe::VERSION
  spec.authors       = ["Kyle Maxwell"]
  spec.email         = ["kyle@kylemaxwell.com"]
  spec.description   = %q{The command-line issues client}
  spec.summary       = %q{A quirky github issues client}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.post_install_message = <<-STR
#{"="*80}
You probably should add .floe to your global .gitignore. Try something like:
  
  # Create a global .gitignore
  :$ git config --global core.excludesfile '~/.gitignore' 

  # Append to the file
  :$ echo .floe >> ~/.gitignore
  
#{"="*80}
STR

  spec.add_dependency "octokit"
  spec.add_dependency "trollop"
  spec.add_dependency "colorize"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end
