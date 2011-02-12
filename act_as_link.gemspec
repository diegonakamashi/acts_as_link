Gem::Specification.new do |s|
  s.name        = "act_as_link"
  s.version     = "0.0.1"
  s.author      = "Fabrício Ferrari de Campos"
  s.email       = "fabricio@vizir.com.br"
  s.homepage    = "http://github.com/fabricioffc/act_as_link"
  s.summary     = "An easy way to make your link act as link"
  s.description = "For now only is_broken? method."

  s.files        = Dir["{lib,spec}/**/*"]
  s.require_path = "lib"

  s.add_development_dependency 'rspec', '~> 1.3.0'

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end
