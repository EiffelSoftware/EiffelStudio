class CORBA_INTERFACEDEF_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_INTERFACEDEF
        undefine
            implementation
        end;
    CORBA_CONTAINER_STUB
        undefine
            copy, is_equal, make,
            repoid, type_name,
            consume, valid_message_type,
            template
        end;
    CORBA_CONTAINED_STUB
        undefine
            copy, is_equal, make,
            repoid, type_name,
            consume, valid_message_type,
            template, make_with_peer, implementation
        end;
    CORBA_IDLTYPE_STUB
        undefine
            copy, is_equal, make,
            repoid, type_name,
            consume, valid_message_type,
            template, make_with_peer, implementation
        end

creation
    make, make_with_peer

feature

    base_interfaces : CORBA_INTERFACEDEFSEQ is

        do
            begin_request ("_get_base_interfaces")
            result_is_of_type (corba_interfacedefseq_tc)
            invoke
            create result.make_default
            result.sequence_from_any (get_result_as_any)
            end_request
        end

    set_base_interfaces (value : CORBA_INTERFACEDEFSEQ) is

        local
            ca : CORBA_ANY

        do
            begin_request ("_set_base_interfaces")
            create ca.make1 (corba_interfacedefseq_tc)
            value.sequence_to_any (ca)
            stub_add_in_arg_any ("value", ca)
            invoke
            end_request
        end

    is_abstract : BOOLEAN is

        do
            begin_request ("_get_is_abstract")
            result_is_boolean
            invoke
            result := get_result_boolean
            end_request
        end

    set_is_abstract (value : BOOLEAN) is

        do
            begin_request ("_set_is_abstract")
            stub_add_in_arg_boolean ("value", value)
            invoke
            end_request
        end

    idl_is_a (interface_id : STRING) : BOOLEAN is

        do
            begin_request ("is_a")
            stub_add_in_arg_string ("interface_id", interface_id)
            result_is_boolean
            invoke
            result := get_result_boolean
            end_request
        end

    describe_interface : CORBA_INTERFACEDEF_FULLINTERFACEDESCRIPTION is

        do
            begin_request ("describe_interface")
            result_is_of_type (corba_interfacedef_fullinterfacedescription_tc)
            invoke
            create result.make_default
            result.struct_from_any (get_result_as_any)
            end_request
        end

    create_attribute (idl_id : STRING;
        idl_name : STRING;
        idl_version : STRING;
        idl_type : CORBA_IDLTYPE;
        mode : CORBA_ATTRIBUTEMODE) : CORBA_ATTRIBUTEDEF is

        local
            ca : CORBA_ANY
            o : CORBA_OBJECT

        do
            begin_request ("create_attribute")
            stub_add_in_arg_string ("id", idl_id)
            stub_add_in_arg_string ("name", idl_name)
            stub_add_in_arg_string ("version", idl_version)
            stub_add_in_arg_ref ("type", idl_type.type_name, idl_type.implementation)
            create ca.make1 (corba_attributemode_tc)
            mode.enum_to_any (ca)
            stub_add_in_arg_any ("mode", ca)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_AttributeDef_narrow (o)
            end_request
        end

    create_operation (idl_id : STRING;
        idl_name : STRING;
        idl_version : STRING;
        idl_result : CORBA_IDLTYPE;
        mode : CORBA_OPERATIONMODE;
        params : CORBA_PARDESCRIPTIONSEQ;
        exceptions : CORBA_EXCEPTIONDEFSEQ;
        contexts : CORBA_CONTEXTIDSEQ) : CORBA_OPERATIONDEF is

        local
            ca : CORBA_ANY
            o : CORBA_OBJECT

        do
            begin_request ("create_operation")
            stub_add_in_arg_string ("id", idl_id)
            stub_add_in_arg_string ("name", idl_name)
            stub_add_in_arg_string ("version", idl_version)
            stub_add_in_arg_ref ("result", idl_result.type_name, idl_result.implementation)
            create ca.make1 (corba_operationmode_tc)
            mode.enum_to_any (ca)
            stub_add_in_arg_any ("mode", ca)
            create ca.make1 (corba_pardescriptionseq_tc)
            params.sequence_to_any (ca)
            stub_add_in_arg_any ("params", ca)
            create ca.make1 (corba_exceptiondefseq_tc)
            exceptions.sequence_to_any (ca)
            stub_add_in_arg_any ("exceptions", ca)
            create ca.make1 (corba_contextidseq_tc)
            contexts.sequence_to_any (ca)
            stub_add_in_arg_any ("contexts", ca)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_OperationDef_narrow (o)
            end_request
        end

end -- class CORBA_INTERFACEDEF_STUB
