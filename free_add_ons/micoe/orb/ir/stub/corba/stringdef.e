class CORBA_STRINGDEF_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_STRINGDEF
        undefine
            implementation
        end;
    CORBA_IDLTYPE_STUB
        undefine
            copy, is_equal, make,
            repoid, type_name,
            consume, valid_message_type,
            template
        end

creation
    make, make_with_peer

feature

    bound : INTEGER is

        do
            begin_request ("_get_bound")
            result_is_integer
            invoke
            result := get_result_integer
            end_request
        end

    set_bound (value : INTEGER) is

        do
            begin_request ("_set_bound")
            stub_add_in_arg_integer ("value", value)
            invoke
            end_request
        end

end -- class CORBA_STRINGDEF_STUB
