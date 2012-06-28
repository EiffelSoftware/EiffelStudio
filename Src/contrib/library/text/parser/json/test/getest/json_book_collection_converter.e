indexing
    description: "A JSON converter for BOOK_COLLECTION"
    author: "Paul Cohen"
    date: "$Date$"
    revision: "$Revision$"
    file: "$HeadURL: https://svn.origo.ethz.ch/ejson/branches/POC-converters-factory/test/json_book_collection_converter.e $"

class JSON_BOOK_COLLECTION_CONVERTER

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
            
    object: BOOK_COLLECTION
            
feature -- Conversion

    from_json (j: like value): like object is
        local
            ucs: UC_STRING
            ll: DS_LINKED_LIST [BOOK]
            b: BOOK
            ja: JSON_ARRAY
            i: INTEGER
        do
            ucs ?= json.object (j.item (name_key), Void)
            check ucs /= Void end
            create Result.make (ucs)
            ja ?= j.item (books_key)
            check ja /= Void end
            from
                i := 1
                create ll.make
            until
                i > ja.count
            loop
                b ?= json.object (ja [i], "BOOK")
                check b /= Void end
                ll.put_last (b)
                i := i + 1
            end
            check ll /= Void end
            Result.add_books (ll)
        end
        
    to_json (o: like object): like value is
        do
            create Result.make
            Result.put (json.value (o.name), name_key)
            Result.put (json.value (o.books), books_key)
        end
  
feature    {NONE} -- Implementation

    name_key: JSON_STRING is
        once
            create Result.make_json ("name")
        end

    books_key: JSON_STRING is
        once
            create Result.make_json ("books")
        end

end -- class JSON_BOOK_COLLECTION_CONVERTER