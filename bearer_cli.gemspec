require_relative 'lib/bearer_cli/version'
require_relative 'lib/bearer_cli/update_cli_service'

Gem.pre_install do
  puts "Installing bearer-cli to #{Gem.bindir}"
  BearerCli::UpdateCliService.run(Gem.bindir)
end

Gem::Specification.new do |spec|
  spec.name          = "bearer_cli"
  spec.version       = BearerCli::VERSION
  spec.authors       = ["Radek Molenda"]
  spec.email         = ["radek@bearer.sh", "engineering@bearer.sh"]

  spec.summary       = "Bearer cli gem downloads bearer-cli binary and provides executable path"
  spec.description   = "Bearer cli gem downloads bearer-cli binary and provides executable path"
  spec.homepage      = "https://github.com/Bearer/bearer-cli-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Bearer/bearer-cli-ruby"
  spec.add_runtime_dependency 'open3', '~> 0.1.1'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
