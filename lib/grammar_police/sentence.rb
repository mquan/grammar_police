module GrammarPolice
  class Sentence
    extend FFI::Library
    ffi_lib "#{File.dirname(__FILE__)}/../../c/link-grammar.so"
    #this requires initializing dictionary everytime and is very slow (probably has mem leakage too)
    attach_function(:number_of_linkages, [:string], :int)
    
    attach_function(:sentence_create, [:string, :pointer], :pointer) #(sentence, dict) return sentence
    attach_function(:sentence_parse, [:pointer, :pointer], :int) #(sentence, opts) return num_linkages
    attach_function(:sentence_delete, [:pointer], :void) #(sentence)
    
    #returns number of tokenized words including boundary words and punctuations
    attach_function(:sentence_length, [:pointer], :int) #(Sentence)
    
    #following must be called after invoking sentence_parse
    #get number of linkages found
    attach_function(:sentence_num_linkages_found, [:pointer], :int) #(Sentence)
    
    #no. linkages having no post-processing violations
    attach_function(:sentence_num_valid_linkages, [:pointer], :int) #(Sentence)
    
    #no. linkages actually post-processed
    attach_function(:sentence_num_linkages_post_processed, [:pointer], :int) #(Sentence)
    
    #split up the text by punctuation (make the sentence shorter ==> processing faster)
    def self.count_linkages(text, dictionary, options)
      count = 0
      #split them up by punctuation to reduce processing time
      text.split(/[\!?,;:']+/).each do |clause|
        c = sentence_create(clause, dictionary)
        count += sentence_parse(c, options)
        sentence_delete(c)
      end
      
      #however, sometimes the split results in all incomplete clause so check one more time in those cases
      if count == 0
        sentence = sentence_create(text, dictionary)
        count = sentence_parse(sentence, options) if count == 0
        sentence_delete(sentence)
      end
      count
    end
  end
end
