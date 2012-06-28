indexing
    description: "A JSON converter for BOOK"
    author: "Paul Cohen"
    date: "$Date$"
    revision: "$Revision$"
    file: "$HeadURL: https://svn.origo.ethz.ch/ejson/branches/POC-converters-factory/test/json_book_converter.e $"

class JSON_BOOK_CONVERTER

inherit
    JSON_CONVERTER
    
create
    make
    
feature {NONE} -- Initialization
    
    make is
        local
            ucs: UC_STRING
            a: AUTHOR
        do
            create ucs.make_from_string ("")
            create a.make (ucs)
            create object.make (ucs, a, ucs)
        end
        
feature -- Access

    value: JSON_OBJECT
            
    object: BOOK
            
feature -- Conversion

    from_json (j: like value): like object is
        local
            ucs1, ucs2: UC_STRING
            a: AUTHOR
        do
            ucs1 ?= json.object (j.item (title_key), Void)
            check ucs1 /= Void end
            ucs2 ?= json.object (j.item (isbn_key), Void)
            check ucs2 /= Void end
            a ?= json.object (j.item (author_key), "AUTHOR")
            check a /= Void end
            create Result.make (ucs1, a, ucs2)
        end
        
    to_json (o: like object): like value is
        do
            create Result.make
            Result.put (json.value (o.title), title_key)
            Result.put (json.value (o.isbn), isbn_key)
            Result.put (json.value (o.author), author_key)
        end
  
feature    {NONE} -- Implementation

    title_key: JSON_STRING is
        once
            create Result.make_json ("title")
        end

    isbn_key: JSON_STRING is
        once
            create Result.make_json ("isbn")
        end

    author_key: JSON_STRING is
        once
            create Result.make_json ("author")
        end

end -- class JSON_BOOK_CONVERTER