class CORBA_CONSTANTDEF_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_CONSTANTDEF
        undefine
            implementation
        end;
    CORBA_CONTAINED_STUB
        undefine
            copy, is_equal, make,
            repoid, type_name,
            consume, valid_message_type,
            template
        end

creation
    make, make_with_peer

feature

    type : CORBA_TYPECODE is

        do
            begin_request ("_get_type")
            result_is_typecode
            invoke
            result := get_result_typecode
            end_request
        end

    type_def : CORBA_IDLTYPE is

        local
            o : CORBA_OBJECT

        do
            begin_request ("_get_type_def")
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_IDLType_narrow (o)
            end_request
        end

    set_type_def (idl_value : CORBA_IDLTYPE) is

        do
            begin_request ("_set_type_def")
            stub_add_in_arg_ref ("value", idl_value.type_name, idl_value.implementation)
            invoke
            end_request
        end

    value : CORBA_ANY is

        do
            begin_request ("_get_value")
            result_is_any
            invoke
            result := get_result_as_any
            end_request
        end

    set_value (idl_value : CORBA_ANY) is

        do
            begin_request ("_set_value")
            stub_add_in_arg_any ("value", idl_value)
            invoke
            end_request
        end

end -- class CORBA_CONSTANTDEF_STUB
