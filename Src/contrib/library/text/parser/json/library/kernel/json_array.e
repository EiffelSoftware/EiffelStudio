note
    description: "[
            JSON_ARRAY represent an array in JSON.
            An array in JSON is an ordered set of names.
            Examples
            array
                []
                [elements]
            ]"

    author: "Javier Velilla"
    date: "2008/08/24"
    revision: "Revision 0.1"

class
    JSON_ARRAY

inherit
    JSON_VALUE

    DEBUG_OUTPUT

create
    make_array

feature {NONE} -- Initialization

    make_array
            -- Initialize JSON Array
        do
            create values.make (10)
        end

feature -- Access

    i_th alias "[]" (i: INTEGER): JSON_VALUE
            -- Item at `i'-th position
        require
            is_valid_index: valid_index (i)
        do
            Result := values.i_th (i)
        end

    representation: STRING
        local
            i: INTEGER
        do
            Result := "["
            from
                i := 1
            until
                i > count
            loop
                Result.append (i_th (i).representation)
                i := i + 1
                if i <= count then
                    Result.append_character (',')
                end
            end
            Result.append_character (']')
        end

feature -- Visitor pattern

    accept (a_visitor: JSON_VISITOR)
            -- Accept `a_visitor'.
            -- (Call `visit_json_array' procedure on `a_visitor'.)
        do
            a_visitor.visit_json_array (Current)
        end

feature -- Mesurement

    count: INTEGER
            -- Number of items.
        do
            Result := values.count
        end

feature -- Status report

    valid_index (i: INTEGER): BOOLEAN
            -- Is `i' a valid index?
        do
            Result := (1 <= i) and (i <= count)
        end

feature -- Change Element

    add (value: JSON_VALUE)
        require
            value_not_null: value /= void
        do
            values.extend (value)
        ensure
            has_new_value: old values.count + 1 = values.count and
                              values.has (value)
        end

feature -- Report

    hash_code: INTEGER
            -- Hash code value
        do
            from
                values.start
                Result := values.item.hash_code
            until
                values.off
            loop
                Result:= ((Result \\ 8388593) |<< 8) + values.item.hash_code
                values.forth
            end
            Result := Result \\ values.count
        end

feature -- Conversion

    array_representation: ARRAYED_LIST [JSON_VALUE]
            -- Representation as a sequences of values
        do
            Result := values
        end

feature -- Status report

    debug_output: STRING
            -- String that should be displayed in debugger to represent `Current'.
        do
            Result := count.out
        end

feature {NONE} -- Implementation

    values: ARRAYED_LIST [JSON_VALUE]
            -- Value container

invariant
     value_not_void: values /= Void

end
