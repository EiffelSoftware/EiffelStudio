deferred class CORBA_OPERATIONDEF
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_CORBA_CONSTANTS
        undefine
            copy, is_equal
        end;
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_CONTAINED
        redefine
            repoid, type_name, consume, valid_message_type
        end
feature

    idl_result : CORBA_TYPECODE is

        deferred
        end

    result_def : CORBA_IDLTYPE is

        deferred
        end

    set_result_def (value : CORBA_IDLTYPE) is

        deferred
        end

    params : CORBA_PARDESCRIPTIONSEQ is

        deferred
        end

    set_params (value : CORBA_PARDESCRIPTIONSEQ) is

        deferred
        end

    mode : CORBA_OPERATIONMODE is

        deferred
        end

    set_mode (value : CORBA_OPERATIONMODE) is

        deferred
        end

    contexts : CORBA_CONTEXTIDSEQ is

        deferred
        end

    set_contexts (value : CORBA_CONTEXTIDSEQ) is

        deferred
        end

    exceptions : CORBA_EXCEPTIONDEFSEQ is

        deferred
        end

    set_exceptions (value : CORBA_EXCEPTIONDEFSEQ) is

        deferred
        end


feature { COURIER, CONSUMER }

    consume (msg : ANY; type : INTEGER) is 

        local
            req : CORBA_SERVER_REQUEST
            ca  : CORBA_ANY
            o   : CORBA_OBJECT
            dum : BOOLEAN
            x1  : CORBA_DEFINITIONKIND
            x2  : CORBA_CONTAINED_DESCRIPTION
            x3  : STRING
            x4  : CORBA_CONTAINER
            x5  : CORBA_REPOSITORY
            x6  : CORBA_TYPECODE
            x7  : CORBA_IDLTYPE
            x8  : CORBA_PARDESCRIPTIONSEQ
            x9  : CORBA_OPERATIONMODE
            x10  : CORBA_CONTEXTIDSEQ
            x11  : CORBA_EXCEPTIONDEFSEQ
            x12  : CORBA_CONTAINER
            x13  : STRING
            x14  : STRING
            x15  : CORBA_IDLTYPE
            x16  : CORBA_PARDESCRIPTIONSEQ
            x17  : CORBA_OPERATIONMODE
            x18  : CORBA_CONTEXTIDSEQ
            x19  : CORBA_EXCEPTIONDEFSEQ

        do
            req ?= msg
            create ca.make
            req.mico_set_result (ca)
            begin_invoke

            inspect type

            when 1 then
                destroy
            when 2 then
                x1 := def_kind
                ca.make1 (corba_definitionkind_tc)
                x1.enum_to_any (ca)
            when 3 then
                x2 := describe
                ca.make1 (corba_contained_description_tc)
                x2.struct_to_any (ca)
            when 4 then
                add_in_arg_ref ("new_container")
                add_in_arg_string ("new_name")
                add_in_arg_string ("new_version")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Container", "new_container")
                x12 := CORBA_Container_narrow (o)
                x13 := nvl.get_string_value_by_name ("new_name")
                x14 := nvl.get_string_value_by_name ("new_version")
                move (x12, x13, x14)
            when 5 then
                x3 := id
                ca.put_string (x3, 0)
            when 6 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x13 := nvl.get_string_value_by_name ("val")
                set_id (x13)
            when 7 then
                x3 := name
                ca.put_string (x3, 0)
            when 8 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x13 := nvl.get_string_value_by_name ("val")
                set_name (x13)
            when 9 then
                x3 := version
                ca.put_string (x3, 0)
            when 10 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x13 := nvl.get_string_value_by_name ("val")
                set_version (x13)
            when 11 then
                x4 := defined_in
                ca.put_object ("corba_container", x4)
            when 12 then
                x3 := absolute_name
                ca.put_string (x3, 0)
            when 13 then
                x5 := containing_repository
                ca.put_object ("corba_repository", x5)
            when 14 then
                x6 := idl_result
                ca.put_typecode (x6)
            when 15 then
                x7 := result_def
                ca.put_object ("corba_idltype", x7)
            when 16 then
                add_in_arg_ref ("val")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("IDLType", "val")
                x15 := CORBA_IDLType_narrow (o)
                set_result_def (x15)
            when 17 then
                x8 := params
                ca.make1 (corba_pardescriptionseq_tc)
                x8.sequence_to_any (ca)
            when 18 then
                add_in_arg_with_type ("val", corba_pardescriptionseq_tc)
                dum := req.set_params (nvl)
                create x16.make_default
                x16.sequence_from_any (nvl.get_any_value_by_name ("val"))
                set_params (x16)
                x16.sequence_to_any (nvl.get_any_value_by_name ("val"))
            when 19 then
                x9 := mode
                ca.make1 (corba_operationmode_tc)
                x9.enum_to_any (ca)
            when 20 then
                add_in_arg_with_type ("val", corba_operationmode_tc)
                dum := req.set_params (nvl)
                create x17.make_default
                x17.enum_from_any (nvl.get_any_value_by_name ("val"))
                set_mode (x17)
                x17.enum_to_any (nvl.get_any_value_by_name ("val"))
            when 21 then
                x10 := contexts
                ca.make1 (corba_contextidseq_tc)
                x10.sequence_to_any (ca)
            when 22 then
                add_in_arg_with_type ("val", corba_contextidseq_tc)
                dum := req.set_params (nvl)
                create x18.make_default
                x18.sequence_from_any (nvl.get_any_value_by_name ("val"))
                set_contexts (x18)
                x18.sequence_to_any (nvl.get_any_value_by_name ("val"))
            when 23 then
                x11 := exceptions
                ca.make1 (corba_exceptiondefseq_tc)
                x11.sequence_to_any (ca)
            when 24 then
                add_in_arg_with_type ("val", corba_exceptiondefseq_tc)
                dum := req.set_params (nvl)
                create x19.make_default
                x19.sequence_from_any (nvl.get_any_value_by_name ("val"))
                set_exceptions (x19)
                x19.sequence_to_any (nvl.get_any_value_by_name ("val"))
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; type : INTEGER) : BOOLEAN is

        do
            result := (1 <= type and then type <= 24)
            result := result and then msg.conforms_to (template)
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/OperationDef:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "OperationDef"
        end

end -- class CORBA_OPERATIONDEF
