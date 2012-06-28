indexing
    description: "A JSON converter for AUTHOR"
    author: "Paul Cohen"
    date: "$Date$"
    revision: "$Revision$"
    file: "$HeadURL: https://svn.origo.ethz.ch/ejson/branches/POC-converters-factory/test/json_author_converter.e $"

class JSON_AUTHOR_CONVERTER

inherit
    JSON_CONVERTER
    
create
    make
    
feature {NONE} -- Initialization
    
    make is
        local
            ucs: UC_STRING
        do
            create ucs.make_from_string ("")
            create object.make (ucs)
        end
        
feature -- Access

    value: JSON_OBJECT
            
    object: AUTHOR
            
feature -- Conversion

    from_json (j: like value): like object is
        local
            ucs: UC_STRING
        do
            ucs ?= json.object (j.item (name_key), Void)
            check ucs /= Void end
            create Result.make (ucs)
        end
        
    to_json (o: like object): like value is
        do
            create Result.make
            Result.put (json.value (o.name), name_key)
        end
  
feature    {NONE} -- Implementation

    name_key: JSON_STRING is
        once
            create Result.make_json ("name")
        end

end -- class JSON_AUTHOR_CONVERTER