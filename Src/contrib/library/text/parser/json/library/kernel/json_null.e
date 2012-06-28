note
    description: "JSON Null Values"
    author: "Javier Velilla"
    date: "2008/08/24"
    revision: "Revision 0.1"

class
    JSON_NULL

inherit
    JSON_VALUE

feature --Access

    hash_code: INTEGER
            -- Hash code value
        do
            Result := null_value.hash_code
        end

    representation: STRING
        do
            Result := "null"
        end
        
feature -- Visitor pattern

    accept (a_visitor: JSON_VISITOR)
            -- Accept `a_visitor'.
            -- (Call `visit_element_a' procedure on `a_visitor'.)
        do
            a_visitor.visit_json_null (Current)
        end

feature -- Status report

    debug_output: STRING
            -- String that should be displayed in debugger to represent `Current'.
        do
            Result := null_value
        end

feature {NONE}-- Implementation        

    null_value: STRING = "null"

end
