class CORBA_ATTRIBUTEDEF_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_ATTRIBUTEDEF
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

    mode : CORBA_ATTRIBUTEMODE is

        do
            begin_request ("_get_mode")
            result_is_of_type (corba_attributemode_tc)
            invoke
            create result.make_default
            result.enum_from_any (get_result_as_any)
            end_request
        end

    set_mode (value : CORBA_ATTRIBUTEMODE) is

        local
            ca : CORBA_ANY

        do
            begin_request ("_set_mode")
            create ca.make1 (corba_attributemode_tc)
            value.enum_to_any (ca)
            stub_add_in_arg_any ("value", ca)
            invoke
            end_request
        end

end -- class CORBA_ATTRIBUTEDEF_STUB
