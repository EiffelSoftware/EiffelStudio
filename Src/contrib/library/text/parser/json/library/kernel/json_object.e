note

    description: "[
            An JSON_OBJECT represent an object in JSON.
            An object is an unordered set of name/value pairs

                        Examples:

                        object
                        {}
                        {"key": "value"}

            ]"
    author: "Javier Velilla"
    date: "2008/08/24"
    revision: "Revision 0.1"
    license:"MIT (see http://www.opensource.org/licenses/mit-license.php)"

class
    JSON_OBJECT

inherit
    JSON_VALUE

    TABLE_ITERABLE [JSON_VALUE, JSON_STRING]

    DEBUG_OUTPUT

create
    make

feature {NONE} -- Initialization

    make
            -- Initialize
        do
            create object.make (10)
        end

feature -- Change Element

    put (value: detachable JSON_VALUE; key: JSON_STRING)
            -- Assuming there is no item of key `key',
            -- insert `value' with `key'.
        require
            key_not_present: not has_key (key)
        local
            l_value: like value
        do
            l_value := value
            if l_value = Void then
                create {JSON_NULL} l_value
            end
            object.extend (l_value, key)
        end

    put_string (value: READABLE_STRING_GENERAL; key: JSON_STRING)
            -- Assuming there is no item of key `key',
            -- insert `value' with `key'.
        require
            key_not_present: not has_key (key)
        local
            l_value: JSON_STRING
        do
            create l_value.make_json_from_string_32 (value.as_string_32)
            put (l_value, key)
        end


    put_integer (value: INTEGER_64; key: JSON_STRING)
            -- Assuming there is no item of key `key',
            -- insert `value' with `key'.
        require
            key_not_present: not has_key (key)
        local
            l_value: JSON_NUMBER
        do
            create l_value.make_integer (value)
            put (l_value, key)
        end

    put_natural (value: NATURAL_64; key: JSON_STRING)
            -- Assuming there is no item of key `key',
            -- insert `value' with `key'.
        require
            key_not_present: not has_key (key)
        local
            l_value: JSON_NUMBER
        do
            create l_value.make_natural (value)
            put (l_value, key)
        end

    put_real (value: DOUBLE; key: JSON_STRING)
            -- Assuming there is no item of key `key',
            -- insert `value' with `key'.
        require
            key_not_present: not has_key (key)
        local
            l_value: JSON_NUMBER
        do
            create l_value.make_real (value)
            put (l_value, key)
        end

    put_boolean (value: BOOLEAN; key: JSON_STRING)
            -- Assuming there is no item of key `key',
            -- insert `value' with `key'.
        require
            key_not_present: not has_key (key)
        local
            l_value: JSON_BOOLEAN
        do
            create l_value.make_boolean (value)
            put (l_value, key)
        end

    replace (value: detachable JSON_VALUE; key: JSON_STRING)
            -- Assuming there is no item of key `key',
            -- insert `value' with `key'.
        local
            l_value: like value
        do
            l_value := value
            if l_value = Void then
                create {JSON_NULL} l_value
            end
            object.force (l_value, key)
        end

    replace_with_string (value: READABLE_STRING_GENERAL; key: JSON_STRING)
            -- Assuming there is no item of key `key',
            -- insert `value' with `key'.
        local
            l_value: JSON_STRING
        do
            create l_value.make_json_from_string_32 (value.as_string_32)
            replace (l_value, key)
        end

    replace_with_integer (value: INTEGER_64; key: JSON_STRING)
            -- Assuming there is no item of key `key',
            -- insert `value' with `key'.
        local
            l_value: JSON_NUMBER
        do
            create l_value.make_integer (value)
            replace (l_value, key)
        end

    replace_with_with_natural (value: NATURAL_64; key: JSON_STRING)
            -- Assuming there is no item of key `key',
            -- insert `value' with `key'.
        local
            l_value: JSON_NUMBER
        do
            create l_value.make_natural (value)
            replace (l_value, key)
        end

    replace_with_real (value: DOUBLE; key: JSON_STRING)
            -- Assuming there is no item of key `key',
            -- insert `value' with `key'.
        local
            l_value: JSON_NUMBER
        do
            create l_value.make_real (value)
            replace (l_value, key)
        end

    replace_with_boolean (value: BOOLEAN; key: JSON_STRING)
            -- Assuming there is no item of key `key',
            -- insert `value' with `key'.
        local
            l_value: JSON_BOOLEAN
        do
            create l_value.make_boolean (value)
            replace (l_value, key)
        end

	remove (key: JSON_STRING)
			-- Remove item indexed by `key' if any.
		do
			object.remove (key)
		end

	wipe_out
			-- Reset all items to default values; reset status.	
		do
			object.wipe_out
		end

feature -- Access

    has_key (key: JSON_STRING): BOOLEAN
            -- has the JSON_OBJECT contains a specific key 'key'.
        do
            Result := object.has (key)
        end

    has_item (value: JSON_VALUE): BOOLEAN
            -- has the JSON_OBJECT contain a specfic item 'value'
        do
            Result := object.has_item (value)
        end

    item (key: JSON_STRING): detachable JSON_VALUE
            -- the json_value associated with a key.
        do
            Result := object.item (key)
        end

    current_keys: ARRAY [JSON_STRING]
            -- array containing actually used keys
        do
            Result := object.current_keys
        end

    representation: STRING
        local
            t: HASH_TABLE [JSON_VALUE, JSON_STRING]
        do
            create Result.make (2)
            Result.append_character ('{')
            from
                t := map_representation
                t.start
            until
                t.after
            loop
                Result.append (t.key_for_iteration.representation)
                Result.append_character (':')
                Result.append (t.item_for_iteration.representation)
                t.forth
                if not t.after then
                    Result.append_character (',')
                end
            end
            Result.append_character ('}')
        end

feature -- Mesurement

	count: INTEGER
			-- Number of field
		do
			Result := object.count
		end

feature -- Access

	new_cursor: TABLE_ITERATION_CURSOR [JSON_VALUE, JSON_STRING]
			-- Fresh cursor associated with current structure
		do
			Result := object.new_cursor
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty object?
		do
			Result := object.is_empty
		end

feature -- Visitor pattern

    accept (a_visitor: JSON_VISITOR)
            -- Accept `a_visitor'.
            -- (Call `visit_json_object' procedure on `a_visitor'.)
        do
            a_visitor.visit_json_object (Current)
        end

feature -- Conversion

    map_representation: HASH_TABLE [JSON_VALUE, JSON_STRING]
            --A representation that maps keys to values
        do
            Result := object
        end

feature -- Report

    hash_code: INTEGER
            -- Hash code value
        do
            from
                object.start
                Result := object.out.hash_code
            until
                object.off
            loop
                Result := ((Result \\ 8388593) |<< 8)  + object.item_for_iteration.hash_code
                object.forth
            end
            -- Ensure it is a positive value.
            Result := Result.hash_code
        end

feature -- Status report

    debug_output: STRING
            -- String that should be displayed in debugger to represent `Current'.
        do
            Result := count.out + " item(s)"
        end

feature {NONE} -- Implementation

    object: HASH_TABLE [JSON_VALUE, JSON_STRING]
            -- Value container

invariant
    object_not_void: object /= Void

end
