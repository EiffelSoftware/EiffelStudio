class CORBA_VALUEMEMBERDEF_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_VALUEMEMBERDEF
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

    set_type_def (value : CORBA_IDLTYPE) is

        do
            begin_request ("_set_type_def")
            stub_add_in_arg_ref ("value", value.type_name, value.implementation)
            invoke
            end_request
        end

    access : INTEGER is

        do
            begin_request ("_get_access")
            result_is_INTEGER
            invoke
            result := get_result_INTEGER
            end_request
        end

    set_access (value : INTEGER) is

        do
            begin_request ("_set_access")
            stub_add_in_arg_integer ("value", value)
            invoke
            end_request
        end

end -- class CORBA_VALUEMEMBERDEF_STUB
