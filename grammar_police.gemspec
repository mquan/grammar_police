# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "grammar_police/version"

Gem::Specification.new do |s|
  s.name        = "grammar_police"
  s.version     = GrammarPolice::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Quan Nguyen"]
  s.email       = ["mquannie@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{grammar_police is a ruby wrapper for the link-grammar code}
  s.description = %q{Unlike the other wrapper of the same library, this gem contains the c code and dictionary data, making it a standalone gem. This is good for deployment on platforms such as heroku where you can't install native libraries to your environment}

  s.rubyforge_project = "grammar_police"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency(%q<ffi>)  
end
