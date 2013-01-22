note
    description: "A JSON converter for BOOK_COLLECTION"
    author: "Paul Cohen"
    date: "$Date$"
    revision: "$Revision$"

class JSON_BOOK_COLLECTION_CONVERTER

inherit
    JSON_CONVERTER

create
    make

feature {NONE} -- Initialization

    make
        local
            ucs: STRING_32
        do
            create ucs.make_from_string ("")
            create object.make (ucs)
        end

feature -- Access

    object: BOOK_COLLECTION

feature -- Conversion

    from_json (j: like to_json): detachable like object
        local
            ucs: detachable STRING_32
            ll: LINKED_LIST [BOOK]
            b: detachable BOOK
            ja: detachable JSON_ARRAY
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
                ll.force (b)
                i := i + 1
            end
            check ll /= Void end
            Result.add_books (ll)
        end

    to_json (o: like object): JSON_OBJECT
        do
            create Result.make
            Result.put (json.value (o.name), name_key)
            Result.put (json.value (o.books), books_key)
        end

feature    {NONE} -- Implementation

    name_key: JSON_STRING
        once
            create Result.make_json ("name")
        end

    books_key: JSON_STRING
        once
            create Result.make_json ("books")
        end

end -- class JSON_BOOK_COLLECTION_CONVERTER
