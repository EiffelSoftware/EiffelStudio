deferred class CORBA_ENUMDEF
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
    CORBA_TYPEDEFDEF
        redefine
            repoid, type_name, consume, valid_message_type
        end
feature

    members : CORBA_ENUMMEMBERSEQ is

        deferred
        end

    set_members (value : CORBA_ENUMMEMBERSEQ) is

        deferred
        end


feature { COURIER, CONSUMER }

    consume (msg : ANY; idl_type : INTEGER) is 

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
            x7  : CORBA_ENUMMEMBERSEQ
            x8  : CORBA_CONTAINER
            x9  : STRING
            x10  : STRING
            x11  : CORBA_ENUMMEMBERSEQ

        do
            req ?= msg
            create ca.make
            req.mico_set_result (ca)
            begin_invoke

            inspect idl_type

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
                x8 := CORBA_Container_narrow (o)
                x9 := nvl.get_string_value_by_name ("new_name")
                x10 := nvl.get_string_value_by_name ("new_version")
                move (x8, x9, x10)
            when 5 then
                x3 := id
                ca.put_string (x3, 0)
            when 6 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x9 := nvl.get_string_value_by_name ("val")
                set_id (x9)
            when 7 then
                x3 := name
                ca.put_string (x3, 0)
            when 8 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x9 := nvl.get_string_value_by_name ("val")
                set_name (x9)
            when 9 then
                x3 := version
                ca.put_string (x3, 0)
            when 10 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x9 := nvl.get_string_value_by_name ("val")
                set_version (x9)
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
                destroy
            when 15 then
                x1 := def_kind
                ca.make1 (corba_definitionkind_tc)
                x1.enum_to_any (ca)
            when 16 then
                x6 := type
                ca.put_typecode (x6)
            when 17 then
                x7 := members
                ca.make1 (corba_enummemberseq_tc)
                x7.sequence_to_any (ca)
            when 18 then
                add_in_arg_with_type ("val", corba_enummemberseq_tc)
                dum := req.set_params (nvl)
                create x11.make_default
                x11.sequence_from_any (nvl.get_any_value_by_name ("val"))
                set_members (x11)
                x11.sequence_to_any (nvl.get_any_value_by_name ("val"))
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; idl_type : INTEGER) : BOOLEAN is

        do
            result := (1 <= idl_type and then idl_type <= 18)
            result := result and then msg.conforms_to (template)
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/EnumDef:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "EnumDef"
        end

end -- class CORBA_ENUMDEF
