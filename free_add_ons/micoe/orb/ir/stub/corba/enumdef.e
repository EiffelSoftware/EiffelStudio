class CORBA_ENUMDEF_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_ENUMDEF
        undefine
            implementation
        end;
    CORBA_TYPEDEFDEF_STUB
        undefine
            copy, is_equal, make,
            repoid, type_name,
            consume, valid_message_type,
            template
        end

creation
    make, make_with_peer

feature

    members : CORBA_ENUMMEMBERSEQ is

        do
            begin_request ("_get_members")
            result_is_of_type (corba_enummemberseq_tc)
            invoke
            create result.make_default
            result.sequence_from_any (get_result_as_any)
            end_request
        end

    set_members (value : CORBA_ENUMMEMBERSEQ) is

        local
            ca : CORBA_ANY

        do
            begin_request ("_set_members")
            create ca.make1 (corba_enummemberseq_tc)
            value.sequence_to_any (ca)
            stub_add_in_arg_any ("value", ca)
            invoke
            end_request
        end

end -- class CORBA_ENUMDEF_STUB
