class CORBA_OPERATIONDEF_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_OPERATIONDEF
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

    idl_result : CORBA_TYPECODE is

        do
            begin_request ("_get_result")
            result_is_typecode
            invoke
            result := get_result_typecode
            end_request
        end

    result_def : CORBA_IDLTYPE is

        local
            o : CORBA_OBJECT

        do
            begin_request ("_get_result_def")
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_IDLType_narrow (o)
            end_request
        end

    set_result_def (value : CORBA_IDLTYPE) is

        do
            begin_request ("_set_result_def")
            stub_add_in_arg_ref ("value", value.type_name, value.implementation)
            invoke
            end_request
        end

    params : CORBA_PARDESCRIPTIONSEQ is

        do
            begin_request ("_get_params")
            result_is_of_type (corba_pardescriptionseq_tc)
            invoke
            create result.make_default
            result.sequence_from_any (get_result_as_any)
            end_request
        end

    set_params (value : CORBA_PARDESCRIPTIONSEQ) is

        local
            ca : CORBA_ANY

        do
            begin_request ("_set_params")
            create ca.make1 (corba_pardescriptionseq_tc)
            value.sequence_to_any (ca)
            stub_add_in_arg_any ("value", ca)
            invoke
            end_request
        end

    mode : CORBA_OPERATIONMODE is

        do
            begin_request ("_get_mode")
            result_is_of_type (corba_operationmode_tc)
            invoke
            create result.make_default
            result.enum_from_any (get_result_as_any)
            end_request
        end

    set_mode (value : CORBA_OPERATIONMODE) is

        local
            ca : CORBA_ANY

        do
            begin_request ("_set_mode")
            create ca.make1 (corba_operationmode_tc)
            value.enum_to_any (ca)
            stub_add_in_arg_any ("value", ca)
            invoke
            end_request
        end

    contexts : CORBA_CONTEXTIDSEQ is

        do
            begin_request ("_get_contexts")
            result_is_of_type (corba_contextidseq_tc)
            invoke
            create result.make_default
            result.sequence_from_any (get_result_as_any)
            end_request
        end

    set_contexts (value : CORBA_CONTEXTIDSEQ) is

        local
            ca : CORBA_ANY

        do
            begin_request ("_set_contexts")
            create ca.make1 (corba_contextidseq_tc)
            value.sequence_to_any (ca)
            stub_add_in_arg_any ("value", ca)
            invoke
            end_request
        end

    exceptions : CORBA_EXCEPTIONDEFSEQ is

        do
            begin_request ("_get_exceptions")
            result_is_of_type (corba_exceptiondefseq_tc)
            invoke
            create result.make_default
            result.sequence_from_any (get_result_as_any)
            end_request
        end

    set_exceptions (value : CORBA_EXCEPTIONDEFSEQ) is

        local
            ca : CORBA_ANY

        do
            begin_request ("_set_exceptions")
            create ca.make1 (corba_exceptiondefseq_tc)
            value.sequence_to_any (ca)
            stub_add_in_arg_any ("value", ca)
            invoke
            end_request
        end

end -- class CORBA_OPERATIONDEF_STUB
