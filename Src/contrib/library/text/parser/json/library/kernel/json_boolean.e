note
    description: "JSON Truth values"
    author: "Javier Velilla"
    date: "2008/08/24"
    revision: "Revision 0.1"

class
    JSON_BOOLEAN

inherit
    JSON_VALUE

create
    make_boolean

feature {NONE} -- Initialization

    make_boolean (an_item: BOOLEAN)
            --Initialize.
        do
            item := an_item
        end

feature -- Access

    item: BOOLEAN
        -- Content

    hash_code: INTEGER
            -- Hash code value
        do
            Result := item.hash_code
        end

    representation: STRING
        do
            if item then
                Result := "true"
            else
                Result := "false"
            end
        end
        
feature -- Visitor pattern

    accept (a_visitor: JSON_VISITOR)
            -- Accept `a_visitor'.
            -- (Call `visit_json_boolean' procedure on `a_visitor'.)
        do
            a_visitor.visit_json_boolean (Current)
        end

feature -- Status report

    debug_output: STRING
            -- String that should be displayed in debugger to represent `Current'.
        do
            Result := item.out
        end

end
