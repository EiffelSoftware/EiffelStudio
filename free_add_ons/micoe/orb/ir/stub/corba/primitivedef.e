class CORBA_PRIMITIVEDEF_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_PRIMITIVEDEF
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

    kind : CORBA_PRIMITIVEKIND is

        do
            begin_request ("_get_kind")
            result_is_of_type (corba_primitivekind_tc)
            invoke
            create result.make_default
            result.enum_from_any (get_result_as_any)
            end_request
        end

end -- class CORBA_PRIMITIVEDEF_STUB
