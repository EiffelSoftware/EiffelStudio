class CORBA_SEQUENCEDEF_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_SEQUENCEDEF
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

    element_type : CORBA_TYPECODE is

        do
            begin_request ("_get_element_type")
            result_is_typecode
            invoke
            result := get_result_typecode
            end_request
        end

    element_type_def : CORBA_IDLTYPE is

        local
            o : CORBA_OBJECT

        do
            begin_request ("_get_element_type_def")
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_IDLType_narrow (o)
            end_request
        end

    set_element_type_def (value : CORBA_IDLTYPE) is

        do
            begin_request ("_set_element_type_def")
            stub_add_in_arg_ref ("value", value.type_name, value.implementation)
            invoke
            end_request
        end

end -- class CORBA_SEQUENCEDEF_STUB
