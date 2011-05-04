module GrammarPolice
  class Linkage
    extend FFI::Library
    ffi_lib "#{File.dirname(__FILE__)}/../../c/link-grammar.so"
    
    attach_function(:linkage_create, [:int, :pointer, :pointer], :pointer) #(0, sentence, opts) return Linkage
    attach_function(:linkage_delete, [:pointer], :void) #(linkage)

    #return no. sublinkages for a linkage with conjunctions (1 otherwise)
    attach_function(:linkage_get_num_sublinkages, [:pointer], :int) #(Linkage)
    
    attach_function(:linkage_set_current_sublinkage, [:pointer, :int], :int) #(Linkage, index)
    
    #combine all links in all sublinkages if linkage has a conjunction, otherwise no effect
    attach_function(:linkage_compute_union, [:pointer], :int) #(Linkage)
    
    #get no. words in sentence for which this is a linkage
    attach_function(:linkage_get_num_words, [:pointer], :int) #(Linkage)
    
    #no. links used in current sublinkage
    attach_function(:linkage_get_num_links, [:pointer], :int) #(Linkage)
    
    attach_function(:linkage_print_diagram, [:pointer], :string) #(linkage) return string of link diagram
    attach_function(:linkage_free_diagram, [:string], :void) #(string diagram)
  end
end
