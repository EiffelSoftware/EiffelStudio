class CORBA_MODULEDEF_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_MODULEDEF
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
        end

creation
    make, make_with_peer

feature

end -- class CORBA_MODULEDEF_STUB
