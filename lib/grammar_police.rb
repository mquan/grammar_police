$: << File.dirname(__FILE__)
require 'ffi'
require 'grammar_police/sentence'
require 'grammar_police/dictionary'
require 'grammar_police/linkage'
require 'grammar_police/parse_options'

module GrammarPolice
  #set dictionary path based on the installed gem path
  GrammarPolice::Dictionary.dictionary_set_data_dir("#{Gem.loaded_specs['grammar_police'].full_gem_path}/data/")
end
