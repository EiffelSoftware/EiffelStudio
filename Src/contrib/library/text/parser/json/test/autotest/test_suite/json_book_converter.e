note
    description: "A JSON converter for BOOK"
    author: "Paul Cohen"
    date: "$Date$"
    revision: "$Revision$"

class JSON_BOOK_CONVERTER

inherit
    JSON_CONVERTER

create
    make

feature {NONE} -- Initialization

    make
        local
            ucs: STRING_32
            a: AUTHOR
        do
            create ucs.make_from_string ("")
            create a.make (ucs)
            create object.make (ucs, a, ucs)
        end

feature -- Access

    object: BOOK

feature -- Conversion

    from_json (j: like to_json): detachable like object
        local
            ucs1, ucs2: detachable STRING_32
            a: detachable AUTHOR
        do
            ucs1 ?= json.object (j.item (title_key), Void)
            check ucs1 /= Void end
            ucs2 ?= json.object (j.item (isbn_key), Void)
            check ucs2 /= Void end
            a ?= json.object (j.item (author_key), "AUTHOR")
            check a /= Void end
            create Result.make (ucs1, a, ucs2)
        end

    to_json (o: like object): JSON_OBJECT
        do
            create Result.make
            Result.put (json.value (o.title), title_key)
            Result.put (json.value (o.isbn), isbn_key)
            Result.put (json.value (o.author), author_key)
        end

feature    {NONE} -- Implementation

    title_key: JSON_STRING
        once
            create Result.make_json ("title")
        end

    isbn_key: JSON_STRING
        once
            create Result.make_json ("isbn")
        end

    author_key: JSON_STRING
        once
            create Result.make_json ("author")
        end

end -- class JSON_BOOK_CONVERTER
