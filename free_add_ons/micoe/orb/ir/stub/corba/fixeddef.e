class CORBA_FIXEDDEF_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_FIXEDDEF
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

    digits : INTEGER is

        do
            begin_request ("_get_digits")
            result_is_integer
            invoke
            result := get_result_integer
            end_request
        end

    set_digits (value : INTEGER) is

        do
            begin_request ("_set_digits")
            stub_add_in_arg_integer ("value", value)
            invoke
            end_request
        end

    scale : INTEGER is

        do
            begin_request ("_get_scale")
            result_is_integer
            invoke
            result := get_result_integer
            end_request
        end

    set_scale (value : INTEGER) is

        do
            begin_request ("_set_scale")
            stub_add_in_arg_integer ("value", value)
            invoke
            end_request
        end

end -- class CORBA_FIXEDDEF_STUB
