deferred class CORBA_MODULEDEF
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
    CORBA_CONTAINER
        redefine
            repoid, type_name, consume, valid_message_type
        end;
    CORBA_CONTAINED
        undefine
            repoid, type_name, consume, valid_message_type, template
        end

feature { COURIER, CONSUMER }

    consume (msg : ANY; type : INTEGER) is 

        local
            req : CORBA_SERVER_REQUEST
            ca  : CORBA_ANY
            o   : CORBA_OBJECT
            dum : BOOLEAN
            x1  : CORBA_DEFINITIONKIND
            x2  : CORBA_CONTAINED
            x3  : CORBA_CONTAINEDSEQ
            x4  : CORBA_CONTAINER_DESCRIPTIONSEQ
            x5  : CORBA_MODULEDEF
            x6  : CORBA_CONSTANTDEF
            x7  : CORBA_STRUCTDEF
            x8  : CORBA_UNIONDEF
            x9  : CORBA_ENUMDEF
            x10  : CORBA_ALIASDEF
            x11  : CORBA_INTERFACEDEF
            x12  : CORBA_VALUEDEF
            x13  : CORBA_VALUEBOXDEF
            x14  : CORBA_EXCEPTIONDEF
            x15  : CORBA_NATIVEDEF
            x16  : CORBA_CONTAINED_DESCRIPTION
            x17  : STRING
            x18  : CORBA_CONTAINER
            x19  : CORBA_REPOSITORY
            x20  : STRING
            x21  : STRING
            x22  : STRING
            x23  : CORBA_DEFINITIONKIND
            x24  : BOOLEAN
            x25  : BOOLEAN
            x26  : BOOLEAN
            x27  : INTEGER
            x28  : CORBA_IDLTYPE
            x29  : CORBA_ANY
            x30  : CORBA_STRUCTMEMBERSEQ
            x31  : CORBA_UNIONMEMBERSEQ
            x32  : CORBA_ENUMMEMBERSEQ
            x33  : CORBA_INTERFACEDEFSEQ
            x34  : CORBA_VALUEDEF
            x35  : CORBA_VALUEDEFSEQ
            x36  : CORBA_INITIALIZERSEQ
            x37  : CORBA_CONTAINED
            x38  : CORBA_CONTAINER

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
                add_in_arg_string ("search_name")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("search_name")
                x2 := lookup (x20)
                ca.put_object ("corba_contained", x2)
            when 4 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                create x23.make_default
                x23.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x24 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x3 := contents (x23, x24)
                x23.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 5 then
                add_in_arg_string ("search_name")
                add_in_arg_integer ("levels_to_search")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("search_name")
                x27 := nvl.get_integer_value_by_name ("levels_to_search")
                create x23.make_default
                x23.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x24 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x3 := lookup_name (x20, x27, x23, x24)
                x23.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 6 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                add_in_arg_integer ("max_returned_objs")
                dum := req.set_params (nvl)
                create x23.make_default
                x23.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x24 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x27 := nvl.get_integer_value_by_name ("max_returned_objs")
                x4 := describe_contents (x23, x24, x27)
                x23.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_container_descriptionseq_tc)
                x4.sequence_to_any (ca)
            when 7 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("id")
                x21 := nvl.get_string_value_by_name ("name")
                x22 := nvl.get_string_value_by_name ("version")
                x5 := create_module (x20, x21, x22)
                ca.put_object ("corba_moduledef", x5)
            when 8 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("type")
                add_in_arg_ref ("value")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("id")
                x21 := nvl.get_string_value_by_name ("name")
                x22 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "type")
                x28 := CORBA_IDLType_narrow (o)
                x6 := create_constant (x20, x21, x22, x28, x29)
                ca.put_object ("corba_constantdef", x6)
            when 9 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("id")
                x21 := nvl.get_string_value_by_name ("name")
                x22 := nvl.get_string_value_by_name ("version")
                create x30.make_default
                x30.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x7 := create_struct (x20, x21, x22, x30)
                x30.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_structdef", x7)
            when 10 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("discriminator_type")
                add_in_arg_with_type ("members", corba_unionmemberseq_tc)
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("id")
                x21 := nvl.get_string_value_by_name ("name")
                x22 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "discriminator_type")
                x28 := CORBA_IDLType_narrow (o)
                create x31.make_default
                x31.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x8 := create_union (x20, x21, x22, x28, x31)
                x31.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_uniondef", x8)
            when 11 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_enummemberseq_tc)
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("id")
                x21 := nvl.get_string_value_by_name ("name")
                x22 := nvl.get_string_value_by_name ("version")
                create x32.make_default
                x32.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x9 := create_enum (x20, x21, x22, x32)
                x32.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_enumdef", x9)
            when 12 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("id")
                x21 := nvl.get_string_value_by_name ("name")
                x22 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type")
                x28 := CORBA_IDLType_narrow (o)
                x10 := create_alias (x20, x21, x22, x28)
                ca.put_object ("corba_aliasdef", x10)
            when 13 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("base_interfaces", corba_interfacedefseq_tc)
                add_in_arg_boolean ("is_abstract")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("id")
                x21 := nvl.get_string_value_by_name ("name")
                x22 := nvl.get_string_value_by_name ("version")
                create x33.make_default
                x33.sequence_from_any (nvl.get_any_value_by_name ("base_interfaces"))
                x24 := nvl.get_boolean_value_by_name ("is_abstract")
                x11 := create_interface (x20, x21, x22, x33, x24)
                x33.sequence_to_any (nvl.get_any_value_by_name ("base_interfaces"))
                ca.put_object ("corba_interfacedef", x11)
            when 14 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_boolean ("is_custom")
                add_in_arg_boolean ("is_abstract")
                add_in_arg_ref ("base_value")
                add_in_arg_boolean ("is_truncatable")
                add_in_arg_with_type ("abstract_base_values", corba_valuedefseq_tc)
                add_in_arg_with_type ("supported_interfaces", corba_interfacedefseq_tc)
                add_in_arg_with_type ("initializers", corba_initializerseq_tc)
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("id")
                x21 := nvl.get_string_value_by_name ("name")
                x22 := nvl.get_string_value_by_name ("version")
                x24 := nvl.get_boolean_value_by_name ("is_custom")
                x25 := nvl.get_boolean_value_by_name ("is_abstract")
                o := nvl.get_ref_value_by_name ("ValueDef", "base_value")
                x34 := CORBA_ValueDef_narrow (o)
                x26 := nvl.get_boolean_value_by_name ("is_truncatable")
                create x35.make_default
                x35.sequence_from_any (nvl.get_any_value_by_name ("abstract_base_values"))
                create x33.make_default
                x33.sequence_from_any (nvl.get_any_value_by_name ("supported_interfaces"))
                create x36.make_default
                x36.sequence_from_any (nvl.get_any_value_by_name ("initializers"))
                x12 := create_value (x20, x21, x22, x24, x25, x34, x26, x35, x33, x36)
                x35.sequence_to_any (nvl.get_any_value_by_name ("abstract_base_values"))
                x33.sequence_to_any (nvl.get_any_value_by_name ("supported_interfaces"))
                x36.sequence_to_any (nvl.get_any_value_by_name ("initializers"))
                ca.put_object ("corba_valuedef", x12)
            when 15 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type_def")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("id")
                x21 := nvl.get_string_value_by_name ("name")
                x22 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type_def")
                x28 := CORBA_IDLType_narrow (o)
                x13 := create_value_box (x20, x21, x22, x28)
                ca.put_object ("corba_valueboxdef", x13)
            when 16 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("id")
                x21 := nvl.get_string_value_by_name ("name")
                x22 := nvl.get_string_value_by_name ("version")
                create x30.make_default
                x30.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x14 := create_exception (x20, x21, x22, x30)
                x30.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_exceptiondef", x14)
            when 17 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("id")
                x21 := nvl.get_string_value_by_name ("name")
                x22 := nvl.get_string_value_by_name ("version")
                x15 := create_native (x20, x21, x22)
                ca.put_object ("corba_nativedef", x15)
            when 18 then
                add_in_arg_string ("search_name")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("search_name")
                x2 := find (x20)
                ca.put_object ("corba_contained", x2)
            when 19 then
                add_in_arg_string ("search_name")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("search_name")
                create x23.make_default
                x23.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x3 := find_name (x20, x23)
                x23.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 20 then
                add_in_arg_string ("id")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("id")
                x2 := locate_id (x20)
                ca.put_object ("corba_contained", x2)
            when 21 then
                add_in_arg_string ("name")
                add_in_arg_boolean ("include_enclosing_scopes")
                add_in_arg_boolean ("is_first_level")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("name")
                x24 := nvl.get_boolean_value_by_name ("include_enclosing_scopes")
                x25 := nvl.get_boolean_value_by_name ("is_first_level")
                x2 := locate_name (x20, x24, x25)
                ca.put_object ("corba_contained", x2)
            when 22 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x37 := CORBA_Contained_narrow (o)
                remove_contained (x37)
            when 23 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x37 := CORBA_Contained_narrow (o)
                add_contained (x37)
            when 24 then
                destroy
            when 25 then
                x1 := def_kind
                ca.make1 (corba_definitionkind_tc)
                x1.enum_to_any (ca)
            when 26 then
                x16 := describe
                ca.make1 (corba_contained_description_tc)
                x16.struct_to_any (ca)
            when 27 then
                add_in_arg_ref ("new_container")
                add_in_arg_string ("new_name")
                add_in_arg_string ("new_version")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Container", "new_container")
                x38 := CORBA_Container_narrow (o)
                x20 := nvl.get_string_value_by_name ("new_name")
                x21 := nvl.get_string_value_by_name ("new_version")
                move (x38, x20, x21)
            when 28 then
                x17 := id
                ca.put_string (x17, 0)
            when 29 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("val")
                set_id (x20)
            when 30 then
                x17 := name
                ca.put_string (x17, 0)
            when 31 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("val")
                set_name (x20)
            when 32 then
                x17 := version
                ca.put_string (x17, 0)
            when 33 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x20 := nvl.get_string_value_by_name ("val")
                set_version (x20)
            when 34 then
                x18 := defined_in
                ca.put_object ("corba_container", x18)
            when 35 then
                x17 := absolute_name
                ca.put_string (x17, 0)
            when 36 then
                x19 := containing_repository
                ca.put_object ("corba_repository", x19)
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; type : INTEGER) : BOOLEAN is

        do
            result := (1 <= type and then type <= 36)
            result := result and then msg.conforms_to (template)
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/ModuleDef:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "ModuleDef"
        end

end -- class CORBA_MODULEDEF
