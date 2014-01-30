note
    description: "A JSON converter for HASH_TABLE [ANY, HASHABLE]"
    author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
    file: "$HeadURL: $"

class JSON_HASH_TABLE_CONVERTER

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

    object: HASH_TABLE [ANY, HASHABLE]

feature -- Conversion

    from_json (j: attached like to_json): like object
        do
            create Result.make (j.count)
            across
            	j as ic
            loop
                if attached json.object (ic.item, Void) as l_object then
					if attached {HASHABLE} json.object (ic.key, Void) as h then
						Result.put (l_object, h)
					else
						check key_is_hashable: False end
					end
                else
                	check object_attached: False end
                end
            end
        end

    to_json (o: like object): detachable JSON_OBJECT
        local
        	c: HASH_TABLE_ITERATION_CURSOR [ANY, HASHABLE]
            js: JSON_STRING
            failed: BOOLEAN
        do
            create Result.make
            from
            	c := o.new_cursor
            until
                c.after
            loop
                if attached {JSON_STRING} json.value (c.key) as l_key then
                    js := l_key
                else
                    create js.make_json (c.key.out)
                end
                if attached json.value (c.item) as jv then
                    Result.put (jv, js)
                else
                    failed := True
                end
                c.forth
            end
            if failed then
                Result := Void
            end
        end

end -- class JSON_HASH_TABLE_CONVERTER
