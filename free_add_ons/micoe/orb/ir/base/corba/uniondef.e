deferred class CORBA_UNIONDEF
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
        end;
    CORBA_CONTAINER
        undefine
            repoid, type_name, consume, valid_message_type, template
        end
feature

    discriminator_type : CORBA_TYPECODE is

        deferred
        end

    discriminator_type_def : CORBA_IDLTYPE is

        deferred
        end

    set_discriminator_type_def (value : CORBA_IDLTYPE) is

        deferred
        end

    members : CORBA_UNIONMEMBERSEQ is

        deferred
        end

    set_members (value : CORBA_UNIONMEMBERSEQ) is

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
            x7  : CORBA_CONTAINED
            x8  : CORBA_CONTAINEDSEQ
            x9  : CORBA_CONTAINER_DESCRIPTIONSEQ
            x10  : CORBA_MODULEDEF
            x11  : CORBA_CONSTANTDEF
            x12  : CORBA_STRUCTDEF
            x13  : CORBA_UNIONDEF
            x14  : CORBA_ENUMDEF
            x15  : CORBA_ALIASDEF
            x16  : CORBA_INTERFACEDEF
            x17  : CORBA_VALUEDEF
            x18  : CORBA_VALUEBOXDEF
            x19  : CORBA_EXCEPTIONDEF
            x20  : CORBA_NATIVEDEF
            x21  : CORBA_IDLTYPE
            x22  : CORBA_UNIONMEMBERSEQ
            x23  : CORBA_CONTAINER
            x24  : STRING
            x25  : STRING
            x26  : STRING
            x27  : CORBA_DEFINITIONKIND
            x28  : BOOLEAN
            x29  : BOOLEAN
            x30  : BOOLEAN
            x31  : INTEGER
            x32  : CORBA_IDLTYPE
            x33  : CORBA_ANY
            x34  : CORBA_STRUCTMEMBERSEQ
            x35  : CORBA_UNIONMEMBERSEQ
            x36  : CORBA_ENUMMEMBERSEQ
            x37  : CORBA_INTERFACEDEFSEQ
            x38  : CORBA_VALUEDEF
            x39  : CORBA_VALUEDEFSEQ
            x40  : CORBA_INITIALIZERSEQ
            x41  : CORBA_CONTAINED

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
                x23 := CORBA_Container_narrow (o)
                x24 := nvl.get_string_value_by_name ("new_name")
                x25 := nvl.get_string_value_by_name ("new_version")
                move (x23, x24, x25)
            when 5 then
                x3 := id
                ca.put_string (x3, 0)
            when 6 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("val")
                set_id (x24)
            when 7 then
                x3 := name
                ca.put_string (x3, 0)
            when 8 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("val")
                set_name (x24)
            when 9 then
                x3 := version
                ca.put_string (x3, 0)
            when 10 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("val")
                set_version (x24)
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
                destroy
            when 18 then
                x1 := def_kind
                ca.make1 (corba_definitionkind_tc)
                x1.enum_to_any (ca)
            when 19 then
                add_in_arg_string ("search_name")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("search_name")
                x7 := lookup (x24)
                ca.put_object ("corba_contained", x7)
            when 20 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                create x27.make_default
                x27.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x28 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x8 := contents (x27, x28)
                x27.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x8.sequence_to_any (ca)
            when 21 then
                add_in_arg_string ("search_name")
                add_in_arg_integer ("levels_to_search")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("search_name")
                x31 := nvl.get_integer_value_by_name ("levels_to_search")
                create x27.make_default
                x27.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x28 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x8 := lookup_name (x24, x31, x27, x28)
                x27.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x8.sequence_to_any (ca)
            when 22 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                add_in_arg_integer ("max_returned_objs")
                dum := req.set_params (nvl)
                create x27.make_default
                x27.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x28 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x31 := nvl.get_integer_value_by_name ("max_returned_objs")
                x9 := describe_contents (x27, x28, x31)
                x27.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_container_descriptionseq_tc)
                x9.sequence_to_any (ca)
            when 23 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("id")
                x25 := nvl.get_string_value_by_name ("name")
                x26 := nvl.get_string_value_by_name ("version")
                x10 := create_module (x24, x25, x26)
                ca.put_object ("corba_moduledef", x10)
            when 24 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("type")
                add_in_arg_ref ("value")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("id")
                x25 := nvl.get_string_value_by_name ("name")
                x26 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "type")
                x32 := CORBA_IDLType_narrow (o)
                x11 := create_constant (x24, x25, x26, x32, x33)
                ca.put_object ("corba_constantdef", x11)
            when 25 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("id")
                x25 := nvl.get_string_value_by_name ("name")
                x26 := nvl.get_string_value_by_name ("version")
                create x34.make_default
                x34.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x12 := create_struct (x24, x25, x26, x34)
                x34.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_structdef", x12)
            when 26 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("discriminator_type")
                add_in_arg_with_type ("members", corba_unionmemberseq_tc)
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("id")
                x25 := nvl.get_string_value_by_name ("name")
                x26 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "discriminator_type")
                x32 := CORBA_IDLType_narrow (o)
                create x35.make_default
                x35.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x13 := create_union (x24, x25, x26, x32, x35)
                x35.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_uniondef", x13)
            when 27 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_enummemberseq_tc)
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("id")
                x25 := nvl.get_string_value_by_name ("name")
                x26 := nvl.get_string_value_by_name ("version")
                create x36.make_default
                x36.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x14 := create_enum (x24, x25, x26, x36)
                x36.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_enumdef", x14)
            when 28 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("id")
                x25 := nvl.get_string_value_by_name ("name")
                x26 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type")
                x32 := CORBA_IDLType_narrow (o)
                x15 := create_alias (x24, x25, x26, x32)
                ca.put_object ("corba_aliasdef", x15)
            when 29 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("base_interfaces", corba_interfacedefseq_tc)
                add_in_arg_boolean ("is_abstract")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("id")
                x25 := nvl.get_string_value_by_name ("name")
                x26 := nvl.get_string_value_by_name ("version")
                create x37.make_default
                x37.sequence_from_any (nvl.get_any_value_by_name ("base_interfaces"))
                x28 := nvl.get_boolean_value_by_name ("is_abstract")
                x16 := create_interface (x24, x25, x26, x37, x28)
                x37.sequence_to_any (nvl.get_any_value_by_name ("base_interfaces"))
                ca.put_object ("corba_interfacedef", x16)
            when 30 then
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
                x24 := nvl.get_string_value_by_name ("id")
                x25 := nvl.get_string_value_by_name ("name")
                x26 := nvl.get_string_value_by_name ("version")
                x28 := nvl.get_boolean_value_by_name ("is_custom")
                x29 := nvl.get_boolean_value_by_name ("is_abstract")
                o := nvl.get_ref_value_by_name ("ValueDef", "base_value")
                x38 := CORBA_ValueDef_narrow (o)
                x30 := nvl.get_boolean_value_by_name ("is_truncatable")
                create x39.make_default
                x39.sequence_from_any (nvl.get_any_value_by_name ("abstract_base_values"))
                create x37.make_default
                x37.sequence_from_any (nvl.get_any_value_by_name ("supported_interfaces"))
                create x40.make_default
                x40.sequence_from_any (nvl.get_any_value_by_name ("initializers"))
                x17 := create_value (x24, x25, x26, x28, x29, x38, x30, x39, x37, x40)
                x39.sequence_to_any (nvl.get_any_value_by_name ("abstract_base_values"))
                x37.sequence_to_any (nvl.get_any_value_by_name ("supported_interfaces"))
                x40.sequence_to_any (nvl.get_any_value_by_name ("initializers"))
                ca.put_object ("corba_valuedef", x17)
            when 31 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type_def")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("id")
                x25 := nvl.get_string_value_by_name ("name")
                x26 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type_def")
                x32 := CORBA_IDLType_narrow (o)
                x18 := create_value_box (x24, x25, x26, x32)
                ca.put_object ("corba_valueboxdef", x18)
            when 32 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("id")
                x25 := nvl.get_string_value_by_name ("name")
                x26 := nvl.get_string_value_by_name ("version")
                create x34.make_default
                x34.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x19 := create_exception (x24, x25, x26, x34)
                x34.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_exceptiondef", x19)
            when 33 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("id")
                x25 := nvl.get_string_value_by_name ("name")
                x26 := nvl.get_string_value_by_name ("version")
                x20 := create_native (x24, x25, x26)
                ca.put_object ("corba_nativedef", x20)
            when 34 then
                add_in_arg_string ("search_name")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("search_name")
                x7 := find (x24)
                ca.put_object ("corba_contained", x7)
            when 35 then
                add_in_arg_string ("search_name")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("search_name")
                create x27.make_default
                x27.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x8 := find_name (x24, x27)
                x27.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x8.sequence_to_any (ca)
            when 36 then
                add_in_arg_string ("id")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("id")
                x7 := locate_id (x24)
                ca.put_object ("corba_contained", x7)
            when 37 then
                add_in_arg_string ("name")
                add_in_arg_boolean ("include_enclosing_scopes")
                add_in_arg_boolean ("is_first_level")
                dum := req.set_params (nvl)
                x24 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_boolean_value_by_name ("include_enclosing_scopes")
                x29 := nvl.get_boolean_value_by_name ("is_first_level")
                x7 := locate_name (x24, x28, x29)
                ca.put_object ("corba_contained", x7)
            when 38 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x41 := CORBA_Contained_narrow (o)
                remove_contained (x41)
            when 39 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x41 := CORBA_Contained_narrow (o)
                add_contained (x41)
            when 40 then
                x6 := discriminator_type
                ca.put_typecode (x6)
            when 41 then
                x21 := discriminator_type_def
                ca.put_object ("corba_idltype", x21)
            when 42 then
                add_in_arg_ref ("val")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("IDLType", "val")
                x32 := CORBA_IDLType_narrow (o)
                set_discriminator_type_def (x32)
            when 43 then
                x22 := members
                ca.make1 (corba_unionmemberseq_tc)
                x22.sequence_to_any (ca)
            when 44 then
                add_in_arg_with_type ("val", corba_unionmemberseq_tc)
                dum := req.set_params (nvl)
                create x35.make_default
                x35.sequence_from_any (nvl.get_any_value_by_name ("val"))
                set_members (x35)
                x35.sequence_to_any (nvl.get_any_value_by_name ("val"))
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; idl_type : INTEGER) : BOOLEAN is

        do
            result := (1 <= idl_type and then idl_type <= 44)
            result := result and then msg.conforms_to (template)
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/UnionDef:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "UnionDef"
        end

end -- class CORBA_UNIONDEF
