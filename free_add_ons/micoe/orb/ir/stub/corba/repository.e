class CORBA_REPOSITORY_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_REPOSITORY
        undefine
            implementation
        end;
    CORBA_CONTAINER_STUB
        undefine
            copy, is_equal, make,
            repoid, type_name,
            consume, valid_message_type,
            template
        end

creation
    make, make_with_peer

feature

    lookup_id (search_id : STRING) : CORBA_CONTAINED is

        local
            o : CORBA_OBJECT

        do
            begin_request ("lookup_id")
            stub_add_in_arg_string ("search_id", search_id)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_Contained_narrow (o)
            end_request
        end

    get_canonical_typecode (tc : CORBA_TYPECODE) : CORBA_TYPECODE is

        do
            begin_request ("get_canonical_typecode")
            stub_add_in_arg_typecode ("tc", tc)
            result_is_typecode
            invoke
            result := get_result_typecode
            end_request
        end

    get_primitive (kind : CORBA_PRIMITIVEKIND) : CORBA_PRIMITIVEDEF is

        local
            ca : CORBA_ANY
            o : CORBA_OBJECT

        do
            begin_request ("get_primitive")
            create ca.make1 (corba_primitivekind_tc)
            kind.enum_to_any (ca)
            stub_add_in_arg_any ("kind", ca)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_PrimitiveDef_narrow (o)
            end_request
        end

    create_string (bound : INTEGER) : CORBA_STRINGDEF is

        local
            o : CORBA_OBJECT

        do
            begin_request ("create_string")
            stub_add_in_arg_integer ("bound", bound)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_StringDef_narrow (o)
            end_request
        end

    create_wstring (bound : INTEGER) : CORBA_WSTRINGDEF is

        local
            o : CORBA_OBJECT

        do
            begin_request ("create_wstring")
            stub_add_in_arg_integer ("bound", bound)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_WstringDef_narrow (o)
            end_request
        end

    create_sequence (bound : INTEGER;
        element_type : CORBA_IDLTYPE) : CORBA_SEQUENCEDEF is

        local
            o : CORBA_OBJECT

        do
            begin_request ("create_sequence")
            stub_add_in_arg_integer ("bound", bound)
            stub_add_in_arg_ref ("element_type", element_type.type_name, element_type.implementation)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_SequenceDef_narrow (o)
            end_request
        end

    create_array (length : INTEGER;
        element_type : CORBA_IDLTYPE) : CORBA_ARRAYDEF is

        local
            o : CORBA_OBJECT

        do
            begin_request ("create_array")
            stub_add_in_arg_integer ("length", length)
            stub_add_in_arg_ref ("element_type", element_type.type_name, element_type.implementation)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_ArrayDef_narrow (o)
            end_request
        end

    create_fixed (digits : INTEGER;
        scale : INTEGER) : CORBA_FIXEDDEF is

        local
            o : CORBA_OBJECT

        do
            begin_request ("create_fixed")
            stub_add_in_arg_integer ("digits", digits)
            stub_add_in_arg_integer ("scale", scale)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_FixedDef_narrow (o)
            end_request
        end

end -- class CORBA_REPOSITORY_STUB
