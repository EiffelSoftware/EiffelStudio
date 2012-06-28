note
    description: "A JSON converter for LINKED_LIST [ANY]"
    author: "Paul Cohen"
    date: "$Date$"
    revision: "$Revision$"
    file: "$HeadURL: $"

class JSON_LINKED_LIST_CONVERTER

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

    object: LINKED_LIST [detachable ANY]

feature -- Conversion

    from_json (j: like to_json): detachable like object
        local
            i: INTEGER
        do
            create Result.make
            from
                i := 1
            until
                i > j.count
            loop
                Result.extend (json.object (j [i], Void))
                i := i + 1
            end
        end

    to_json (o: like object): JSON_ARRAY
        local
            c: ITERATION_CURSOR [detachable ANY]
        do
            create Result.make_array
            from
            	c := o.new_cursor
            until
                c.after
            loop
            	if attached json.value (c.item) as v then
            		Result.add (v)
            	else
            		check attached_value: False end
            	end
				c.forth
            end
        end

end -- class JSON_LINKED_LIST_CONVERTER
