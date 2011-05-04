module GrammarPolice
  class ParseOptions
    extend FFI::Library
    ffi_lib File.expand_path('../../c/link-grammar.so', File.dirname(__FILE__))
     
    #return Parse_Options with default settings (linkage_limit=10000, short_length=6)
    attach_function(:parse_options_create, [], :pointer)
    
    #free up mem used by Parse_Options
    attach_function(:parse_options_delete, [:pointer], :int)
    
    #set short_length which determines how long links are allowed 
    #to speed up parsing by not considering very long links for most connectors, since they're very rarely used
    attach_function(:parse_options_set_short_length, [:pointer, :int], :void) #pass in Parse_Options and int value
    attach_function(:parse_options_get_short_length, [:pointer], :int) #pass in Parse_Options
    
    #set max number of linkages considered in post-processing
    #pass in Parse_Options, return null
    attach_function(:parse_options_set_linkage_limit, [:pointer, :int], :void)
    attach_function(:parse_options_get_linkage_limit, [:pointer], :int) #passin Parse_Options
    
    #set this to force complete quickly after time expires
    #this applies for all sentence using this parse (basically they all share a single timer)
    #only useful for parsing 1 sentence at the time, or a doc that you want to impose a time limit
    attach_function(:parse_options_set_max_parse_time, [:pointer, :int], :void) #pass in PO and int seconds
    attach_function(:parse_options_get_max_parse_time, [:pointer], :int) #pass in PO
    
    #max memory set/get
    attach_function(:parse_options_set_max_memory, [:pointer, :int], :void) #pass in PO and mem limit, probably in bytes
    attach_function(:parse_options_get_max_memory, [:pointer], :int)
  end
end
