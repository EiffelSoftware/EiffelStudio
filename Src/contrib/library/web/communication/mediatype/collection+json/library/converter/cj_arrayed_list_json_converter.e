note
    description: "A JSON converter for ARRAYED_LIST [ANY]"
    date: "$Date$"
    revision: "$Revision$"

class
	CJ_ARRAYED_LIST_JSON_CONVERTER

inherit
    JSON_CONVERTER

create
    make

feature {NONE} -- Initialization

    make
        do
            create object.make (0)
        end

feature -- Access

    object: ARRAYED_LIST [detachable ANY]

feature -- Conversion

    from_json (j: attached like to_json): detachable like object
        local
            i: INTEGER
        do
            create Result.make (j.count)
            from
                i := 1
            until
                i > j.count
            loop
                Result.extend (json.object (j [i], Void))
                i := i + 1
            end
        end

    to_json (o: like object): detachable JSON_ARRAY
        local
			failed: BOOLEAN
        do
            create Result.make_empty
            across
            	o as c
            loop
            	if attached json.value (c.item) as jv then
            		Result.add (jv)
            	else
					failed := True
            	end
            end
			if failed then
				Result := Void
			end
        end

note
	copyright: "2011-2017, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end -- class CJ_JSON_ARRAYED_LIST_CONVERTER

