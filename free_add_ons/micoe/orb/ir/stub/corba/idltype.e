class CORBA_IDLTYPE_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_IDLTYPE
        undefine
            implementation
        end;
    CORBA_IROBJECT_STUB
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

end -- class CORBA_IDLTYPE_STUB
