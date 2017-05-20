note
    description: "A JSON converter for DS_HASH_TABLE [ANY, HASHABLE]"
    author: "Paul Cohen"
    date: "$Date$"
    revision: "$Revision$"
    file: "$HeadURL: $"

class JSON_DS_HASH_TABLE_CONVERTER

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

    object: DS_HASH_TABLE [ANY, HASHABLE]

feature -- Conversion

    from_json (j: JSON_OBJECT): detachable like object
        local
            keys: ARRAY [JSON_STRING]
            i: INTEGER
        do
            keys := j.current_keys
            create Result.make (keys.count)
            from
                i := 1
            until
                i > keys.count
            loop
                if attached {HASHABLE} json.object (keys [i], void) as h then
	                if attached json.object (j.item (keys [i]), Void) as o then
	                	Result.put (o, h)
	                end
				else
					check key_hashable: False end
				end
                i := i + 1
            end
        end

    to_json (o: like object): detachable JSON_OBJECT
        local
            c: DS_HASH_TABLE_CURSOR [ANY, HASHABLE]
            js: JSON_STRING
            jv: JSON_VALUE
            failed: BOOLEAN
        do
            create Result.make
            from
                c := o.new_cursor
                c.start
            until
                c.after
            loop
                if attached {JSON_STRING} json.value (c.key) as l_key then
                    js := l_key
                else
                    create js.make_from_string_general (c.key.out)
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

note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end -- class JSON_DS_HASH_TABLE_CONVERTER
