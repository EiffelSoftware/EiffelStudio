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

    value: JSON_OBJECT

    object: DS_HASH_TABLE [ANY, HASHABLE]

feature -- Conversion

    from_json (j: like value): detachable like object
        local
            keys: ARRAY [JSON_STRING]
            i: INTEGER
            h: HASHABLE
            a: ANY
        do
            keys := j.current_keys
            create Result.make (keys.count)
            from
                i := 1
            until
                i > keys.count
            loop
                h ?= json.object (keys [i], void)
                check h /= Void end
                a := json.object (j.item (keys [i]), Void)
                Result.put (a, h)
                i := i + 1
            end
        end

    to_json (o: like object): like value
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

end -- class JSON_DS_HASH_TABLE_CONVERTER
