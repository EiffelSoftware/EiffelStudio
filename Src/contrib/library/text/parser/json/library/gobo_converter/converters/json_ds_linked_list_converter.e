note
    description: "A JSON converter for DS_LINKED_LIST [ANY]"
    author: "Paul Cohen"
    date: "$Date$"
    revision: "$Revision$"
    file: "$HeadURL: $"

class JSON_DS_LINKED_LIST_CONVERTER

inherit
    JSON_CONVERTER

create
    make

feature {NONE} -- Initialization

    make
        do
            create object.make
        end

feature -- Access

    value: JSON_ARRAY

    object: DS_LINKED_LIST [ANY]

feature -- Conversion

    from_json (j: like value): detachable like object
        local
            i: INTEGER
        do
            create Result.make
            from
                i := 1
            until
                i > j.count
            loop
                Result.put_last (json.object (j [i], Void))
                i := i + 1
            end
        end

    to_json (o: like object): like value
        local
            c: DS_LIST_CURSOR [ANY]
        do
            create Result.make_array
            from
                c := o.new_cursor
                c.start
            until
                c.after
            loop
                Result.add (json.value (c.item))
                c.forth
            end
        end

end -- class JSON_DS_LINKED_LIST_CONVERTER
