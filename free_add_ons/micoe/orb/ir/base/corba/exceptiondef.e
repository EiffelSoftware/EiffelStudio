deferred class CORBA_EXCEPTIONDEF
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
        end;
    CORBA_CONTAINER
        undefine
            repoid, type_name, consume, valid_message_type, template
        end
feature

    type : CORBA_TYPECODE is

        deferred
        end

    members : CORBA_STRUCTMEMBERSEQ is

        deferred
        end

    set_members (value : CORBA_STRUCTMEMBERSEQ) is

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
            x6  : CORBA_CONTAINED
            x7  : CORBA_CONTAINEDSEQ
            x8  : CORBA_CONTAINER_DESCRIPTIONSEQ
            x9  : CORBA_MODULEDEF
            x10  : CORBA_CONSTANTDEF
            x11  : CORBA_STRUCTDEF
            x12  : CORBA_UNIONDEF
            x13  : CORBA_ENUMDEF
            x14  : CORBA_ALIASDEF
            x15  : CORBA_INTERFACEDEF
            x16  : CORBA_VALUEDEF
            x17  : CORBA_VALUEBOXDEF
            x18  : CORBA_EXCEPTIONDEF
            x19  : CORBA_NATIVEDEF
            x20  : CORBA_TYPECODE
            x21  : CORBA_STRUCTMEMBERSEQ
            x22  : CORBA_CONTAINER
            x23  : STRING
            x24  : STRING
            x25  : STRING
            x26  : CORBA_DEFINITIONKIND
            x27  : BOOLEAN
            x28  : BOOLEAN
            x29  : BOOLEAN
            x30  : INTEGER
            x31  : CORBA_IDLTYPE
            x32  : CORBA_ANY
            x33  : CORBA_STRUCTMEMBERSEQ
            x34  : CORBA_UNIONMEMBERSEQ
            x35  : CORBA_ENUMMEMBERSEQ
            x36  : CORBA_INTERFACEDEFSEQ
            x37  : CORBA_VALUEDEF
            x38  : CORBA_VALUEDEFSEQ
            x39  : CORBA_INITIALIZERSEQ
            x40  : CORBA_CONTAINED

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
                x22 := CORBA_Container_narrow (o)
                x23 := nvl.get_string_value_by_name ("new_name")
                x24 := nvl.get_string_value_by_name ("new_version")
                move (x22, x23, x24)
            when 5 then
                x3 := id
                ca.put_string (x3, 0)
            when 6 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("val")
                set_id (x23)
            when 7 then
                x3 := name
                ca.put_string (x3, 0)
            when 8 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("val")
                set_name (x23)
            when 9 then
                x3 := version
                ca.put_string (x3, 0)
            when 10 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("val")
                set_version (x23)
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
                add_in_arg_string ("search_name")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("search_name")
                x6 := lookup (x23)
                ca.put_object ("corba_contained", x6)
            when 17 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                create x26.make_default
                x26.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x27 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x7 := contents (x26, x27)
                x26.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x7.sequence_to_any (ca)
            when 18 then
                add_in_arg_string ("search_name")
                add_in_arg_integer ("levels_to_search")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("search_name")
                x30 := nvl.get_integer_value_by_name ("levels_to_search")
                create x26.make_default
                x26.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x27 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x7 := lookup_name (x23, x30, x26, x27)
                x26.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x7.sequence_to_any (ca)
            when 19 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                add_in_arg_integer ("max_returned_objs")
                dum := req.set_params (nvl)
                create x26.make_default
                x26.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x27 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x30 := nvl.get_integer_value_by_name ("max_returned_objs")
                x8 := describe_contents (x26, x27, x30)
                x26.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_container_descriptionseq_tc)
                x8.sequence_to_any (ca)
            when 20 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                x9 := create_module (x23, x24, x25)
                ca.put_object ("corba_moduledef", x9)
            when 21 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("type")
                add_in_arg_ref ("value")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "type")
                x31 := CORBA_IDLType_narrow (o)
                x10 := create_constant (x23, x24, x25, x31, x32)
                ca.put_object ("corba_constantdef", x10)
            when 22 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                create x33.make_default
                x33.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x11 := create_struct (x23, x24, x25, x33)
                x33.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_structdef", x11)
            when 23 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("discriminator_type")
                add_in_arg_with_type ("members", corba_unionmemberseq_tc)
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "discriminator_type")
                x31 := CORBA_IDLType_narrow (o)
                create x34.make_default
                x34.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x12 := create_union (x23, x24, x25, x31, x34)
                x34.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_uniondef", x12)
            when 24 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_enummemberseq_tc)
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                create x35.make_default
                x35.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x13 := create_enum (x23, x24, x25, x35)
                x35.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_enumdef", x13)
            when 25 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type")
                x31 := CORBA_IDLType_narrow (o)
                x14 := create_alias (x23, x24, x25, x31)
                ca.put_object ("corba_aliasdef", x14)
            when 26 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("base_interfaces", corba_interfacedefseq_tc)
                add_in_arg_boolean ("is_abstract")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                create x36.make_default
                x36.sequence_from_any (nvl.get_any_value_by_name ("base_interfaces"))
                x27 := nvl.get_boolean_value_by_name ("is_abstract")
                x15 := create_interface (x23, x24, x25, x36, x27)
                x36.sequence_to_any (nvl.get_any_value_by_name ("base_interfaces"))
                ca.put_object ("corba_interfacedef", x15)
            when 27 then
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
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                x27 := nvl.get_boolean_value_by_name ("is_custom")
                x28 := nvl.get_boolean_value_by_name ("is_abstract")
                o := nvl.get_ref_value_by_name ("ValueDef", "base_value")
                x37 := CORBA_ValueDef_narrow (o)
                x29 := nvl.get_boolean_value_by_name ("is_truncatable")
                create x38.make_default
                x38.sequence_from_any (nvl.get_any_value_by_name ("abstract_base_values"))
                create x36.make_default
                x36.sequence_from_any (nvl.get_any_value_by_name ("supported_interfaces"))
                create x39.make_default
                x39.sequence_from_any (nvl.get_any_value_by_name ("initializers"))
                x16 := create_value (x23, x24, x25, x27, x28, x37, x29, x38, x36, x39)
                x38.sequence_to_any (nvl.get_any_value_by_name ("abstract_base_values"))
                x36.sequence_to_any (nvl.get_any_value_by_name ("supported_interfaces"))
                x39.sequence_to_any (nvl.get_any_value_by_name ("initializers"))
                ca.put_object ("corba_valuedef", x16)
            when 28 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type_def")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type_def")
                x31 := CORBA_IDLType_narrow (o)
                x17 := create_value_box (x23, x24, x25, x31)
                ca.put_object ("corba_valueboxdef", x17)
            when 29 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                create x33.make_default
                x33.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x18 := create_exception (x23, x24, x25, x33)
                x33.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_exceptiondef", x18)
            when 30 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                x19 := create_native (x23, x24, x25)
                ca.put_object ("corba_nativedef", x19)
            when 31 then
                add_in_arg_string ("search_name")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("search_name")
                x6 := find (x23)
                ca.put_object ("corba_contained", x6)
            when 32 then
                add_in_arg_string ("search_name")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("search_name")
                create x26.make_default
                x26.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x7 := find_name (x23, x26)
                x26.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x7.sequence_to_any (ca)
            when 33 then
                add_in_arg_string ("id")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x6 := locate_id (x23)
                ca.put_object ("corba_contained", x6)
            when 34 then
                add_in_arg_string ("name")
                add_in_arg_boolean ("include_enclosing_scopes")
                add_in_arg_boolean ("is_first_level")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("name")
                x27 := nvl.get_boolean_value_by_name ("include_enclosing_scopes")
                x28 := nvl.get_boolean_value_by_name ("is_first_level")
                x6 := locate_name (x23, x27, x28)
                ca.put_object ("corba_contained", x6)
            when 35 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x40 := CORBA_Contained_narrow (o)
                remove_contained (x40)
            when 36 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x40 := CORBA_Contained_narrow (o)
                add_contained (x40)
            when 37 then
                x20 := type
                ca.put_typecode (x20)
            when 38 then
                x21 := members
                ca.make1 (corba_structmemberseq_tc)
                x21.sequence_to_any (ca)
            when 39 then
                add_in_arg_with_type ("val", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                create x33.make_default
                x33.sequence_from_any (nvl.get_any_value_by_name ("val"))
                set_members (x33)
                x33.sequence_to_any (nvl.get_any_value_by_name ("val"))
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; idl_type : INTEGER) : BOOLEAN is

        do
            result := (1 <= idl_type and then idl_type <= 39)
            result := result and then msg.conforms_to (template)
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/ExceptionDef:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "ExceptionDef"
        end

end -- class CORBA_EXCEPTIONDEF
