class CORBA_UNIONDEF_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_UNIONDEF
        undefine
            implementation
        end;
    CORBA_TYPEDEFDEF_STUB
        undefine
            copy, is_equal, make,
            repoid, type_name,
            consume, valid_message_type,
            template
        end;
    CORBA_CONTAINER_STUB
        undefine
            copy, is_equal, make,
            repoid, type_name,
            consume, valid_message_type,
            template, make_with_peer, implementation
        end

creation
    make, make_with_peer

feature

    discriminator_type : CORBA_TYPECODE is

        do
            begin_request ("_get_discriminator_type")
            result_is_typecode
            invoke
            result := get_result_typecode
            end_request
        end

    discriminator_type_def : CORBA_IDLTYPE is

        local
            o : CORBA_OBJECT

        do
            begin_request ("_get_discriminator_type_def")
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_IDLType_narrow (o)
            end_request
        end

    set_discriminator_type_def (value : CORBA_IDLTYPE) is

        do
            begin_request ("_set_discriminator_type_def")
            stub_add_in_arg_ref ("value", value.type_name, value.implementation)
            invoke
            end_request
        end

    members : CORBA_UNIONMEMBERSEQ is

        do
            begin_request ("_get_members")
            result_is_of_type (corba_unionmemberseq_tc)
            invoke
            create result.make_default
            result.sequence_from_any (get_result_as_any)
            end_request
        end

    set_members (value : CORBA_UNIONMEMBERSEQ) is

        local
            ca : CORBA_ANY

        do
            begin_request ("_set_members")
            create ca.make1 (corba_unionmemberseq_tc)
            value.sequence_to_any (ca)
            stub_add_in_arg_any ("value", ca)
            invoke
            end_request
        end

end -- class CORBA_UNIONDEF_STUB
