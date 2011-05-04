module GrammarPolice
  #can't move location of dictionary, it's a dirty hack (../../data/)
  #only reason it works is data is 2 levels up from this ruby file and also 2 levels up from its C code
  class Dictionary
    extend FFI::Library
    ffi_lib "#{File.dirname(__FILE__)}/../../c/link-grammar.so"
    #set locale ensure utf8 data in dictionary can be read
    #attach_function(:setlocale, [LC_ALL, "])
    
    #specify dictionary directory
    attach_function(:dictionary_set_data_dir, [:string], :void)
    
    #("en") for english, return Dictionary
    attach_function(:dictionary_create_lang, [:string], :pointer)
    
    #like above function but no language specification (default to "en"), return Dictionary
    attach_function(:dictionary_create_default_lang, [], :pointer) 
    
    #free up all space used by Dictionary object and close associated post-processor, pass in Dictionary
    attach_function(:dictionary_delete, [:pointer], :int) 
    
    def self.create(lang)
      dictionary_create_lang(lang)
    end
    
    def self.destroy(dictionary)
      dictionary_delete(dictionary)
    end
  end
end
