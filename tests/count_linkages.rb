require 'ffi'
require "#{File.dirname(__FILE__)}/../lib/grammar_police/dictionary"
require "#{File.dirname(__FILE__)}/../lib/grammar_police/sentence"
require "#{File.dirname(__FILE__)}/../lib/grammar_police/parse_options"

text = "Grammar is useless because there's nothing to say -- Gertrude Stein."
puts GrammarPolice::Sentence.number_of_linkages(text)

dict = GrammarPolice::Dictionary.dictionary_create_lang("en")
opts = GrammarPolice::ParseOptions.parse_options_create
puts num = GrammarPolice::Sentence.count_linkages(text, dict, opts)
GrammarPolice::ParseOptions.parse_options_delete(opts)
GrammarPolice::Dictionary.dictionary_delete(dict)

#run test on real sentences to see how accurate the linkages number with respect to correct grammar
dict = GrammarPolice::Dictionary.create("en")
opts = GrammarPolice::ParseOptions.parse_options_create
GrammarPolice::ParseOptions.parse_options_set_linkage_limit(opts, 10)
puts GrammarPolice::ParseOptions.parse_options_get_linkage_limit(opts)
GrammarPolice::ParseOptions.parse_options_set_short_length(opts, 5)
puts GrammarPolice::ParseOptions.parse_options_get_short_length(opts)
File.open('sentences.txt', 'r') do |f|
  while line = f.gets
    count = GrammarPolice::Sentence.count_linkages(line, dict, opts)
    puts "#{count} #{line.split(' ').size} #{line}"
  end
end
GrammarPolice::ParseOptions.parse_options_delete(opts)
GrammarPolice::Dictionary.destroy(dict)