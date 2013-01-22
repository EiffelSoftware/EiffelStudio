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
        local
            keys: ARRAY [JSON_STRING]
            i: INTEGER
            h: detachable HASHABLE
            jv: detachable JSON_VALUE
            a: detachable ANY
        do
            keys := j.current_keys
            create Result.make (keys.count)
            from
                i := 1
            until
                i > keys.count
            loop
                h ?= json.object (keys [i], Void)
                check h /= Void end
                jv := j.item (keys [i])
                if jv /= Void then
	                a := json.object (jv, Void)
	                if a /= Void then
	                	Result.put (a, h)
	                else
	                	check a_attached: a /= Void end
	                end
				else
					check j_has_item: False end
                end
                i := i + 1
            end
        end

    to_json (o: like object): detachable JSON_OBJECT
        local
        	c: HASH_TABLE_ITERATION_CURSOR [ANY, HASHABLE]
            js: JSON_STRING
            jv: detachable JSON_VALUE
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
                jv := json.value (c.item)
                if jv /= Void then
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
