deferred class CORBA_INTERFACEDEF
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
        end;
    CORBA_IDLTYPE
        undefine
            repoid, type_name, consume, valid_message_type, template
        end
feature

    base_interfaces : CORBA_INTERFACEDEFSEQ is

        deferred
        end

    set_base_interfaces (value : CORBA_INTERFACEDEFSEQ) is

        deferred
        end

    is_abstract : BOOLEAN is

        deferred
        end

    set_is_abstract (value : BOOLEAN) is

        deferred
        end

    idl_is_a (interface_id : STRING) : BOOLEAN is

        deferred
        end

    describe_interface : CORBA_INTERFACEDEF_FULLINTERFACEDESCRIPTION is

        deferred
        end

    create_attribute (idl_id : STRING;
        idl_name : STRING;
        idl_version : STRING;
        idl_type : CORBA_IDLTYPE;
        mode : CORBA_ATTRIBUTEMODE) : CORBA_ATTRIBUTEDEF is

        deferred
        end

    create_operation (idl_id : STRING;
        idl_name : STRING;
        idl_version : STRING;
        idl_result : CORBA_IDLTYPE;
        mode : CORBA_OPERATIONMODE;
        params : CORBA_PARDESCRIPTIONSEQ;
        exceptions : CORBA_EXCEPTIONDEFSEQ;
        contexts : CORBA_CONTEXTIDSEQ) : CORBA_OPERATIONDEF is

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
            x20  : CORBA_TYPECODE
            x21  : BOOLEAN
            x22  : CORBA_INTERFACEDEF_FULLINTERFACEDESCRIPTION
            x23  : CORBA_ATTRIBUTEDEF
            x24  : CORBA_OPERATIONDEF
            x25  : CORBA_INTERFACEDEFSEQ
            x26  : STRING
            x27  : STRING
            x28  : STRING
            x29  : CORBA_DEFINITIONKIND
            x30  : BOOLEAN
            x31  : BOOLEAN
            x32  : BOOLEAN
            x33  : INTEGER
            x34  : CORBA_IDLTYPE
            x35  : CORBA_ANY
            x36  : CORBA_STRUCTMEMBERSEQ
            x37  : CORBA_UNIONMEMBERSEQ
            x38  : CORBA_ENUMMEMBERSEQ
            x39  : CORBA_INTERFACEDEFSEQ
            x40  : CORBA_VALUEDEF
            x41  : CORBA_VALUEDEFSEQ
            x42  : CORBA_INITIALIZERSEQ
            x43  : CORBA_CONTAINED
            x44  : CORBA_CONTAINER
            x45  : CORBA_ATTRIBUTEMODE
            x46  : CORBA_OPERATIONMODE
            x47  : CORBA_PARDESCRIPTIONSEQ
            x48  : CORBA_EXCEPTIONDEFSEQ
            x49  : CORBA_CONTEXTIDSEQ

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
                add_in_arg_string ("search_name")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("search_name")
                x2 := lookup (x26)
                ca.put_object ("corba_contained", x2)
            when 4 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                create x29.make_default
                x29.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x30 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x3 := contents (x29, x30)
                x29.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 5 then
                add_in_arg_string ("search_name")
                add_in_arg_integer ("levels_to_search")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("search_name")
                x33 := nvl.get_integer_value_by_name ("levels_to_search")
                create x29.make_default
                x29.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x30 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x3 := lookup_name (x26, x33, x29, x30)
                x29.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 6 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                add_in_arg_integer ("max_returned_objs")
                dum := req.set_params (nvl)
                create x29.make_default
                x29.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x30 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x33 := nvl.get_integer_value_by_name ("max_returned_objs")
                x4 := describe_contents (x29, x30, x33)
                x29.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_container_descriptionseq_tc)
                x4.sequence_to_any (ca)
            when 7 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                x5 := create_module (x26, x27, x28)
                ca.put_object ("corba_moduledef", x5)
            when 8 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("type")
                add_in_arg_ref ("value")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "type")
                x34 := CORBA_IDLType_narrow (o)
                x6 := create_constant (x26, x27, x28, x34, x35)
                ca.put_object ("corba_constantdef", x6)
            when 9 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                create x36.make_default
                x36.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x7 := create_struct (x26, x27, x28, x36)
                x36.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_structdef", x7)
            when 10 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("discriminator_type")
                add_in_arg_with_type ("members", corba_unionmemberseq_tc)
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "discriminator_type")
                x34 := CORBA_IDLType_narrow (o)
                create x37.make_default
                x37.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x8 := create_union (x26, x27, x28, x34, x37)
                x37.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_uniondef", x8)
            when 11 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_enummemberseq_tc)
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                create x38.make_default
                x38.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x9 := create_enum (x26, x27, x28, x38)
                x38.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_enumdef", x9)
            when 12 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type")
                x34 := CORBA_IDLType_narrow (o)
                x10 := create_alias (x26, x27, x28, x34)
                ca.put_object ("corba_aliasdef", x10)
            when 13 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("base_interfaces", corba_interfacedefseq_tc)
                add_in_arg_boolean ("is_abstract")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                create x39.make_default
                x39.sequence_from_any (nvl.get_any_value_by_name ("base_interfaces"))
                x30 := nvl.get_boolean_value_by_name ("is_abstract")
                x11 := create_interface (x26, x27, x28, x39, x30)
                x39.sequence_to_any (nvl.get_any_value_by_name ("base_interfaces"))
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
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                x30 := nvl.get_boolean_value_by_name ("is_custom")
                x31 := nvl.get_boolean_value_by_name ("is_abstract")
                o := nvl.get_ref_value_by_name ("ValueDef", "base_value")
                x40 := CORBA_ValueDef_narrow (o)
                x32 := nvl.get_boolean_value_by_name ("is_truncatable")
                create x41.make_default
                x41.sequence_from_any (nvl.get_any_value_by_name ("abstract_base_values"))
                create x39.make_default
                x39.sequence_from_any (nvl.get_any_value_by_name ("supported_interfaces"))
                create x42.make_default
                x42.sequence_from_any (nvl.get_any_value_by_name ("initializers"))
                x12 := create_value (x26, x27, x28, x30, x31, x40, x32, x41, x39, x42)
                x41.sequence_to_any (nvl.get_any_value_by_name ("abstract_base_values"))
                x39.sequence_to_any (nvl.get_any_value_by_name ("supported_interfaces"))
                x42.sequence_to_any (nvl.get_any_value_by_name ("initializers"))
                ca.put_object ("corba_valuedef", x12)
            when 15 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type_def")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type_def")
                x34 := CORBA_IDLType_narrow (o)
                x13 := create_value_box (x26, x27, x28, x34)
                ca.put_object ("corba_valueboxdef", x13)
            when 16 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                create x36.make_default
                x36.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x14 := create_exception (x26, x27, x28, x36)
                x36.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_exceptiondef", x14)
            when 17 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                x15 := create_native (x26, x27, x28)
                ca.put_object ("corba_nativedef", x15)
            when 18 then
                add_in_arg_string ("search_name")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("search_name")
                x2 := find (x26)
                ca.put_object ("corba_contained", x2)
            when 19 then
                add_in_arg_string ("search_name")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("search_name")
                create x29.make_default
                x29.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x3 := find_name (x26, x29)
                x29.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 20 then
                add_in_arg_string ("id")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x2 := locate_id (x26)
                ca.put_object ("corba_contained", x2)
            when 21 then
                add_in_arg_string ("name")
                add_in_arg_boolean ("include_enclosing_scopes")
                add_in_arg_boolean ("is_first_level")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("name")
                x30 := nvl.get_boolean_value_by_name ("include_enclosing_scopes")
                x31 := nvl.get_boolean_value_by_name ("is_first_level")
                x2 := locate_name (x26, x30, x31)
                ca.put_object ("corba_contained", x2)
            when 22 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x43 := CORBA_Contained_narrow (o)
                remove_contained (x43)
            when 23 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x43 := CORBA_Contained_narrow (o)
                add_contained (x43)
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
                x44 := CORBA_Container_narrow (o)
                x26 := nvl.get_string_value_by_name ("new_name")
                x27 := nvl.get_string_value_by_name ("new_version")
                move (x44, x26, x27)
            when 28 then
                x17 := id
                ca.put_string (x17, 0)
            when 29 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("val")
                set_id (x26)
            when 30 then
                x17 := name
                ca.put_string (x17, 0)
            when 31 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("val")
                set_name (x26)
            when 32 then
                x17 := version
                ca.put_string (x17, 0)
            when 33 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("val")
                set_version (x26)
            when 34 then
                x18 := defined_in
                ca.put_object ("corba_container", x18)
            when 35 then
                x17 := absolute_name
                ca.put_string (x17, 0)
            when 36 then
                x19 := containing_repository
                ca.put_object ("corba_repository", x19)
            when 37 then
                destroy
            when 38 then
                x1 := def_kind
                ca.make1 (corba_definitionkind_tc)
                x1.enum_to_any (ca)
            when 39 then
                x20 := type
                ca.put_typecode (x20)
            when 40 then
                add_in_arg_string ("interface_id")
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("interface_id")
                x21 := idl_is_a (x26)
                ca.put_boolean (x21)
            when 41 then
                x22 := describe_interface
                ca.make1 (corba_interfacedef_fullinterfacedescription_tc)
                x22.struct_to_any (ca)
            when 42 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("type")
                add_in_arg_with_type ("mode", corba_attributemode_tc)
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "type")
                x34 := CORBA_IDLType_narrow (o)
                create x45.make_default
                x45.enum_from_any (nvl.get_any_value_by_name ("mode"))
                x23 := create_attribute (x26, x27, x28, x34, x45)
                x45.enum_to_any (nvl.get_any_value_by_name ("mode"))
                ca.put_object ("corba_attributedef", x23)
            when 43 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("result")
                add_in_arg_with_type ("mode", corba_operationmode_tc)
                add_in_arg_with_type ("params", corba_pardescriptionseq_tc)
                add_in_arg_with_type ("exceptions", corba_exceptiondefseq_tc)
                add_in_arg_with_type ("contexts", corba_contextidseq_tc)
                dum := req.set_params (nvl)
                x26 := nvl.get_string_value_by_name ("id")
                x27 := nvl.get_string_value_by_name ("name")
                x28 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "result")
                x34 := CORBA_IDLType_narrow (o)
                create x46.make_default
                x46.enum_from_any (nvl.get_any_value_by_name ("mode"))
                create x47.make_default
                x47.sequence_from_any (nvl.get_any_value_by_name ("params"))
                create x48.make_default
                x48.sequence_from_any (nvl.get_any_value_by_name ("exceptions"))
                create x49.make_default
                x49.sequence_from_any (nvl.get_any_value_by_name ("contexts"))
                x24 := create_operation (x26, x27, x28, x34, x46, x47, x48, x49)
                x47.sequence_to_any (nvl.get_any_value_by_name ("params"))
                x48.sequence_to_any (nvl.get_any_value_by_name ("exceptions"))
                x49.sequence_to_any (nvl.get_any_value_by_name ("contexts"))
                x46.enum_to_any (nvl.get_any_value_by_name ("mode"))
                ca.put_object ("corba_operationdef", x24)
            when 44 then
                x25 := base_interfaces
                ca.make1 (corba_interfacedefseq_tc)
                x25.sequence_to_any (ca)
            when 45 then
                add_in_arg_with_type ("val", corba_interfacedefseq_tc)
                dum := req.set_params (nvl)
                create x39.make_default
                x39.sequence_from_any (nvl.get_any_value_by_name ("val"))
                set_base_interfaces (x39)
                x39.sequence_to_any (nvl.get_any_value_by_name ("val"))
            when 46 then
                x21 := is_abstract
                ca.put_boolean (x21)
            when 47 then
                add_in_arg_boolean ("val")
                dum := req.set_params (nvl)
                x30 := nvl.get_boolean_value_by_name ("val")
                set_is_abstract (x30)
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; idl_type : INTEGER) : BOOLEAN is

        do
            result := (1 <= idl_type and then idl_type <= 47)
            result := result and then msg.conforms_to (template)
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/InterfaceDef:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "InterfaceDef"
        end

end -- class CORBA_INTERFACEDEF
