deferred class CORBA_REPOSITORY
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
        end
feature

    lookup_id (search_id : STRING) : CORBA_CONTAINED is

        deferred
        end

    get_canonical_typecode (tc : CORBA_TYPECODE) : CORBA_TYPECODE is

        deferred
        end

    get_primitive (kind : CORBA_PRIMITIVEKIND) : CORBA_PRIMITIVEDEF is

        deferred
        end

    create_string (bound : INTEGER) : CORBA_STRINGDEF is

        deferred
        end

    create_wstring (bound : INTEGER) : CORBA_WSTRINGDEF is

        deferred
        end

    create_sequence (bound : INTEGER;
        element_type : CORBA_IDLTYPE) : CORBA_SEQUENCEDEF is

        deferred
        end

    create_array (length : INTEGER;
        element_type : CORBA_IDLTYPE) : CORBA_ARRAYDEF is

        deferred
        end

    create_fixed (digits : INTEGER;
        scale : INTEGER) : CORBA_FIXEDDEF is

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
            x16  : CORBA_TYPECODE
            x17  : CORBA_PRIMITIVEDEF
            x18  : CORBA_STRINGDEF
            x19  : CORBA_WSTRINGDEF
            x20  : CORBA_SEQUENCEDEF
            x21  : CORBA_ARRAYDEF
            x22  : CORBA_FIXEDDEF
            x23  : STRING
            x24  : STRING
            x25  : STRING
            x26  : CORBA_DEFINITIONKIND
            x27  : BOOLEAN
            x28  : BOOLEAN
            x29  : BOOLEAN
            x30  : INTEGER
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
            x42  : CORBA_TYPECODE
            x43  : CORBA_PRIMITIVEKIND

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
                x23 := nvl.get_string_value_by_name ("search_name")
                x2 := lookup (x23)
                ca.put_object ("corba_contained", x2)
            when 4 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                create x26.make_default
                x26.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x27 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x3 := contents (x26, x27)
                x26.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 5 then
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
                x3 := lookup_name (x23, x30, x26, x27)
                x26.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 6 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                add_in_arg_integer ("max_returned_objs")
                dum := req.set_params (nvl)
                create x26.make_default
                x26.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x27 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x30 := nvl.get_integer_value_by_name ("max_returned_objs")
                x4 := describe_contents (x26, x27, x30)
                x26.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_container_descriptionseq_tc)
                x4.sequence_to_any (ca)
            when 7 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                x5 := create_module (x23, x24, x25)
                ca.put_object ("corba_moduledef", x5)
            when 8 then
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
                x32 := CORBA_IDLType_narrow (o)
                x6 := create_constant (x23, x24, x25, x32, x33)
                ca.put_object ("corba_constantdef", x6)
            when 9 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                create x34.make_default
                x34.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x7 := create_struct (x23, x24, x25, x34)
                x34.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_structdef", x7)
            when 10 then
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
                x32 := CORBA_IDLType_narrow (o)
                create x35.make_default
                x35.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x8 := create_union (x23, x24, x25, x32, x35)
                x35.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_uniondef", x8)
            when 11 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_enummemberseq_tc)
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                create x36.make_default
                x36.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x9 := create_enum (x23, x24, x25, x36)
                x36.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_enumdef", x9)
            when 12 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type")
                x32 := CORBA_IDLType_narrow (o)
                x10 := create_alias (x23, x24, x25, x32)
                ca.put_object ("corba_aliasdef", x10)
            when 13 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("base_interfaces", corba_interfacedefseq_tc)
                add_in_arg_boolean ("is_abstract")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                create x37.make_default
                x37.sequence_from_any (nvl.get_any_value_by_name ("base_interfaces"))
                x27 := nvl.get_boolean_value_by_name ("is_abstract")
                x11 := create_interface (x23, x24, x25, x37, x27)
                x37.sequence_to_any (nvl.get_any_value_by_name ("base_interfaces"))
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
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                x27 := nvl.get_boolean_value_by_name ("is_custom")
                x28 := nvl.get_boolean_value_by_name ("is_abstract")
                o := nvl.get_ref_value_by_name ("ValueDef", "base_value")
                x38 := CORBA_ValueDef_narrow (o)
                x29 := nvl.get_boolean_value_by_name ("is_truncatable")
                create x39.make_default
                x39.sequence_from_any (nvl.get_any_value_by_name ("abstract_base_values"))
                create x37.make_default
                x37.sequence_from_any (nvl.get_any_value_by_name ("supported_interfaces"))
                create x40.make_default
                x40.sequence_from_any (nvl.get_any_value_by_name ("initializers"))
                x12 := create_value (x23, x24, x25, x27, x28, x38, x29, x39, x37, x40)
                x39.sequence_to_any (nvl.get_any_value_by_name ("abstract_base_values"))
                x37.sequence_to_any (nvl.get_any_value_by_name ("supported_interfaces"))
                x40.sequence_to_any (nvl.get_any_value_by_name ("initializers"))
                ca.put_object ("corba_valuedef", x12)
            when 15 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type_def")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type_def")
                x32 := CORBA_IDLType_narrow (o)
                x13 := create_value_box (x23, x24, x25, x32)
                ca.put_object ("corba_valueboxdef", x13)
            when 16 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                create x34.make_default
                x34.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x14 := create_exception (x23, x24, x25, x34)
                x34.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_exceptiondef", x14)
            when 17 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x24 := nvl.get_string_value_by_name ("name")
                x25 := nvl.get_string_value_by_name ("version")
                x15 := create_native (x23, x24, x25)
                ca.put_object ("corba_nativedef", x15)
            when 18 then
                add_in_arg_string ("search_name")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("search_name")
                x2 := find (x23)
                ca.put_object ("corba_contained", x2)
            when 19 then
                add_in_arg_string ("search_name")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("search_name")
                create x26.make_default
                x26.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x3 := find_name (x23, x26)
                x26.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 20 then
                add_in_arg_string ("id")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("id")
                x2 := locate_id (x23)
                ca.put_object ("corba_contained", x2)
            when 21 then
                add_in_arg_string ("name")
                add_in_arg_boolean ("include_enclosing_scopes")
                add_in_arg_boolean ("is_first_level")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("name")
                x27 := nvl.get_boolean_value_by_name ("include_enclosing_scopes")
                x28 := nvl.get_boolean_value_by_name ("is_first_level")
                x2 := locate_name (x23, x27, x28)
                ca.put_object ("corba_contained", x2)
            when 22 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x41 := CORBA_Contained_narrow (o)
                remove_contained (x41)
            when 23 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x41 := CORBA_Contained_narrow (o)
                add_contained (x41)
            when 24 then
                add_in_arg_string ("search_id")
                dum := req.set_params (nvl)
                x23 := nvl.get_string_value_by_name ("search_id")
                x2 := lookup_id (x23)
                ca.put_object ("corba_contained", x2)
            when 25 then
                add_in_arg_ref ("tc")
                dum := req.set_params (nvl)
                x42 := nvl.get_typecode_value_by_name ("tc")
                x16 := get_canonical_typecode (x42)
                ca.put_typecode (x16)
            when 26 then
                add_in_arg_with_type ("kind", corba_primitivekind_tc)
                dum := req.set_params (nvl)
                create x43.make_default
                x43.enum_from_any (nvl.get_any_value_by_name ("kind"))
                x17 := get_primitive (x43)
                x43.enum_to_any (nvl.get_any_value_by_name ("kind"))
                ca.put_object ("corba_primitivedef", x17)
            when 27 then
                add_in_arg_integer ("bound")
                dum := req.set_params (nvl)
                x30 := nvl.get_integer_value_by_name ("bound")
                x18 := create_string (x30)
                ca.put_object ("corba_stringdef", x18)
            when 28 then
                add_in_arg_integer ("bound")
                dum := req.set_params (nvl)
                x30 := nvl.get_integer_value_by_name ("bound")
                x19 := create_wstring (x30)
                ca.put_object ("corba_wstringdef", x19)
            when 29 then
                add_in_arg_integer ("bound")
                add_in_arg_ref ("element_type")
                dum := req.set_params (nvl)
                x30 := nvl.get_integer_value_by_name ("bound")
                o := nvl.get_ref_value_by_name ("IDLType", "element_type")
                x32 := CORBA_IDLType_narrow (o)
                x20 := create_sequence (x30, x32)
                ca.put_object ("corba_sequencedef", x20)
            when 30 then
                add_in_arg_integer ("length")
                add_in_arg_ref ("element_type")
                dum := req.set_params (nvl)
                x30 := nvl.get_integer_value_by_name ("length")
                o := nvl.get_ref_value_by_name ("IDLType", "element_type")
                x32 := CORBA_IDLType_narrow (o)
                x21 := create_array (x30, x32)
                ca.put_object ("corba_arraydef", x21)
            when 31 then
                add_in_arg_integer ("digits")
                add_in_arg_integer ("scale")
                dum := req.set_params (nvl)
                x30 := nvl.get_integer_value_by_name ("digits")
                x31 := nvl.get_integer_value_by_name ("scale")
                x22 := create_fixed (x30, x31)
                ca.put_object ("corba_fixeddef", x22)
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; type : INTEGER) : BOOLEAN is

        do
            result := (1 <= type and then type <= 31)
            result := result and then msg.conforms_to (template)
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/Repository:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "Repository"
        end

end -- class CORBA_REPOSITORY
