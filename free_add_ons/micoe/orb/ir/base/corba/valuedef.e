deferred class CORBA_VALUEDEF
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

    supported_interfaces : CORBA_INTERFACEDEFSEQ is

        deferred
        end

    set_supported_interfaces (value : CORBA_INTERFACEDEFSEQ) is

        deferred
        end

    initializers : CORBA_INITIALIZERSEQ is

        deferred
        end

    set_initializers (value : CORBA_INITIALIZERSEQ) is

        deferred
        end

    base_value : CORBA_VALUEDEF is

        deferred
        end

    set_base_value (value : CORBA_VALUEDEF) is

        deferred
        end

    abstract_base_values : CORBA_VALUEDEFSEQ is

        deferred
        end

    set_abstract_base_values (value : CORBA_VALUEDEFSEQ) is

        deferred
        end

    is_abstract : BOOLEAN is

        deferred
        end

    set_is_abstract (value : BOOLEAN) is

        deferred
        end

    is_custom : BOOLEAN is

        deferred
        end

    set_is_custom (value : BOOLEAN) is

        deferred
        end

    is_truncatable : BOOLEAN is

        deferred
        end

    set_is_truncatable (value : BOOLEAN) is

        deferred
        end

    idl_is_a (idl_id : STRING) : BOOLEAN is

        deferred
        end

    describe_value : CORBA_VALUEDEF_FULLVALUEDESCRIPTION is

        deferred
        end

    create_value_member (idl_id : STRING;
        idl_name : STRING;
        idl_version : STRING;
        idl_type : CORBA_IDLTYPE;
        access : INTEGER) : CORBA_VALUEMEMBERDEF is

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
            x22  : CORBA_VALUEDEF_FULLVALUEDESCRIPTION
            x23  : CORBA_VALUEMEMBERDEF
            x24  : CORBA_ATTRIBUTEDEF
            x25  : CORBA_OPERATIONDEF
            x26  : CORBA_INTERFACEDEFSEQ
            x27  : CORBA_INITIALIZERSEQ
            x28  : CORBA_VALUEDEFSEQ
            x29  : STRING
            x30  : STRING
            x31  : STRING
            x32  : CORBA_DEFINITIONKIND
            x33  : BOOLEAN
            x34  : BOOLEAN
            x35  : BOOLEAN
            x36  : INTEGER
            x37  : CORBA_IDLTYPE
            x38  : CORBA_ANY
            x39  : CORBA_STRUCTMEMBERSEQ
            x40  : CORBA_UNIONMEMBERSEQ
            x41  : CORBA_ENUMMEMBERSEQ
            x42  : CORBA_INTERFACEDEFSEQ
            x43  : CORBA_VALUEDEF
            x44  : CORBA_VALUEDEFSEQ
            x45  : CORBA_INITIALIZERSEQ
            x46  : CORBA_CONTAINED
            x47  : CORBA_CONTAINER
            x48  : INTEGER
            x49  : CORBA_ATTRIBUTEMODE
            x50  : CORBA_OPERATIONMODE
            x51  : CORBA_PARDESCRIPTIONSEQ
            x52  : CORBA_EXCEPTIONDEFSEQ
            x53  : CORBA_CONTEXTIDSEQ

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
                x29 := nvl.get_string_value_by_name ("search_name")
                x2 := lookup (x29)
                ca.put_object ("corba_contained", x2)
            when 4 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                create x32.make_default
                x32.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x33 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x3 := contents (x32, x33)
                x32.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 5 then
                add_in_arg_string ("search_name")
                add_in_arg_integer ("levels_to_search")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("search_name")
                x36 := nvl.get_integer_value_by_name ("levels_to_search")
                create x32.make_default
                x32.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x33 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x3 := lookup_name (x29, x36, x32, x33)
                x32.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 6 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                add_in_arg_integer ("max_returned_objs")
                dum := req.set_params (nvl)
                create x32.make_default
                x32.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x33 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x36 := nvl.get_integer_value_by_name ("max_returned_objs")
                x4 := describe_contents (x32, x33, x36)
                x32.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_container_descriptionseq_tc)
                x4.sequence_to_any (ca)
            when 7 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                x5 := create_module (x29, x30, x31)
                ca.put_object ("corba_moduledef", x5)
            when 8 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("type")
                add_in_arg_ref ("value")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "type")
                x37 := CORBA_IDLType_narrow (o)
                x6 := create_constant (x29, x30, x31, x37, x38)
                ca.put_object ("corba_constantdef", x6)
            when 9 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                create x39.make_default
                x39.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x7 := create_struct (x29, x30, x31, x39)
                x39.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_structdef", x7)
            when 10 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("discriminator_type")
                add_in_arg_with_type ("members", corba_unionmemberseq_tc)
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "discriminator_type")
                x37 := CORBA_IDLType_narrow (o)
                create x40.make_default
                x40.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x8 := create_union (x29, x30, x31, x37, x40)
                x40.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_uniondef", x8)
            when 11 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_enummemberseq_tc)
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                create x41.make_default
                x41.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x9 := create_enum (x29, x30, x31, x41)
                x41.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_enumdef", x9)
            when 12 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type")
                x37 := CORBA_IDLType_narrow (o)
                x10 := create_alias (x29, x30, x31, x37)
                ca.put_object ("corba_aliasdef", x10)
            when 13 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("base_interfaces", corba_interfacedefseq_tc)
                add_in_arg_boolean ("is_abstract")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                create x42.make_default
                x42.sequence_from_any (nvl.get_any_value_by_name ("base_interfaces"))
                x33 := nvl.get_boolean_value_by_name ("is_abstract")
                x11 := create_interface (x29, x30, x31, x42, x33)
                x42.sequence_to_any (nvl.get_any_value_by_name ("base_interfaces"))
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
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                x33 := nvl.get_boolean_value_by_name ("is_custom")
                x34 := nvl.get_boolean_value_by_name ("is_abstract")
                o := nvl.get_ref_value_by_name ("ValueDef", "base_value")
                x43 := CORBA_ValueDef_narrow (o)
                x35 := nvl.get_boolean_value_by_name ("is_truncatable")
                create x44.make_default
                x44.sequence_from_any (nvl.get_any_value_by_name ("abstract_base_values"))
                create x42.make_default
                x42.sequence_from_any (nvl.get_any_value_by_name ("supported_interfaces"))
                create x45.make_default
                x45.sequence_from_any (nvl.get_any_value_by_name ("initializers"))
                x12 := create_value (x29, x30, x31, x33, x34, x43, x35, x44, x42, x45)
                x44.sequence_to_any (nvl.get_any_value_by_name ("abstract_base_values"))
                x42.sequence_to_any (nvl.get_any_value_by_name ("supported_interfaces"))
                x45.sequence_to_any (nvl.get_any_value_by_name ("initializers"))
                ca.put_object ("corba_valuedef", x12)
            when 15 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type_def")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type_def")
                x37 := CORBA_IDLType_narrow (o)
                x13 := create_value_box (x29, x30, x31, x37)
                ca.put_object ("corba_valueboxdef", x13)
            when 16 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                create x39.make_default
                x39.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x14 := create_exception (x29, x30, x31, x39)
                x39.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_exceptiondef", x14)
            when 17 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                x15 := create_native (x29, x30, x31)
                ca.put_object ("corba_nativedef", x15)
            when 18 then
                add_in_arg_string ("search_name")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("search_name")
                x2 := find (x29)
                ca.put_object ("corba_contained", x2)
            when 19 then
                add_in_arg_string ("search_name")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("search_name")
                create x32.make_default
                x32.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x3 := find_name (x29, x32)
                x32.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 20 then
                add_in_arg_string ("id")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x2 := locate_id (x29)
                ca.put_object ("corba_contained", x2)
            when 21 then
                add_in_arg_string ("name")
                add_in_arg_boolean ("include_enclosing_scopes")
                add_in_arg_boolean ("is_first_level")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("name")
                x33 := nvl.get_boolean_value_by_name ("include_enclosing_scopes")
                x34 := nvl.get_boolean_value_by_name ("is_first_level")
                x2 := locate_name (x29, x33, x34)
                ca.put_object ("corba_contained", x2)
            when 22 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x46 := CORBA_Contained_narrow (o)
                remove_contained (x46)
            when 23 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x46 := CORBA_Contained_narrow (o)
                add_contained (x46)
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
                x47 := CORBA_Container_narrow (o)
                x29 := nvl.get_string_value_by_name ("new_name")
                x30 := nvl.get_string_value_by_name ("new_version")
                move (x47, x29, x30)
            when 28 then
                x17 := id
                ca.put_string (x17, 0)
            when 29 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("val")
                set_id (x29)
            when 30 then
                x17 := name
                ca.put_string (x17, 0)
            when 31 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("val")
                set_name (x29)
            when 32 then
                x17 := version
                ca.put_string (x17, 0)
            when 33 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("val")
                set_version (x29)
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
                add_in_arg_string ("id")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x21 := idl_is_a (x29)
                ca.put_boolean (x21)
            when 41 then
                x22 := describe_value
                ca.make1 (corba_valuedef_fullvaluedescription_tc)
                x22.struct_to_any (ca)
            when 42 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("type")
                add_in_arg_integer ("access")
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "type")
                x37 := CORBA_IDLType_narrow (o)
                x48 := nvl.get_integer_value_by_name ("access")
                x23 := create_value_member (x29, x30, x31, x37, x48)
                ca.put_object ("corba_valuememberdef", x23)
            when 43 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("type")
                add_in_arg_with_type ("mode", corba_attributemode_tc)
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "type")
                x37 := CORBA_IDLType_narrow (o)
                create x49.make_default
                x49.enum_from_any (nvl.get_any_value_by_name ("mode"))
                x24 := create_attribute (x29, x30, x31, x37, x49)
                x49.enum_to_any (nvl.get_any_value_by_name ("mode"))
                ca.put_object ("corba_attributedef", x24)
            when 44 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("result")
                add_in_arg_with_type ("mode", corba_operationmode_tc)
                add_in_arg_with_type ("params", corba_pardescriptionseq_tc)
                add_in_arg_with_type ("exceptions", corba_exceptiondefseq_tc)
                add_in_arg_with_type ("contexts", corba_contextidseq_tc)
                dum := req.set_params (nvl)
                x29 := nvl.get_string_value_by_name ("id")
                x30 := nvl.get_string_value_by_name ("name")
                x31 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "result")
                x37 := CORBA_IDLType_narrow (o)
                create x50.make_default
                x50.enum_from_any (nvl.get_any_value_by_name ("mode"))
                create x51.make_default
                x51.sequence_from_any (nvl.get_any_value_by_name ("params"))
                create x52.make_default
                x52.sequence_from_any (nvl.get_any_value_by_name ("exceptions"))
                create x53.make_default
                x53.sequence_from_any (nvl.get_any_value_by_name ("contexts"))
                x25 := create_operation (x29, x30, x31, x37, x50, x51, x52, x53)
                x51.sequence_to_any (nvl.get_any_value_by_name ("params"))
                x52.sequence_to_any (nvl.get_any_value_by_name ("exceptions"))
                x53.sequence_to_any (nvl.get_any_value_by_name ("contexts"))
                x50.enum_to_any (nvl.get_any_value_by_name ("mode"))
                ca.put_object ("corba_operationdef", x25)
            when 45 then
                x26 := supported_interfaces
                ca.make1 (corba_interfacedefseq_tc)
                x26.sequence_to_any (ca)
            when 46 then
                add_in_arg_with_type ("val", corba_interfacedefseq_tc)
                dum := req.set_params (nvl)
                create x42.make_default
                x42.sequence_from_any (nvl.get_any_value_by_name ("val"))
                set_supported_interfaces (x42)
                x42.sequence_to_any (nvl.get_any_value_by_name ("val"))
            when 47 then
                x27 := initializers
                ca.make1 (corba_initializerseq_tc)
                x27.sequence_to_any (ca)
            when 48 then
                add_in_arg_with_type ("val", corba_initializerseq_tc)
                dum := req.set_params (nvl)
                create x45.make_default
                x45.sequence_from_any (nvl.get_any_value_by_name ("val"))
                set_initializers (x45)
                x45.sequence_to_any (nvl.get_any_value_by_name ("val"))
            when 49 then
                x12 := base_value
                ca.put_object ("corba_valuedef", x12)
            when 50 then
                add_in_arg_ref ("val")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("ValueDef", "val")
                x43 := CORBA_ValueDef_narrow (o)
                set_base_value (x43)
            when 51 then
                x28 := abstract_base_values
                ca.make1 (corba_valuedefseq_tc)
                x28.sequence_to_any (ca)
            when 52 then
                add_in_arg_with_type ("val", corba_valuedefseq_tc)
                dum := req.set_params (nvl)
                create x44.make_default
                x44.sequence_from_any (nvl.get_any_value_by_name ("val"))
                set_abstract_base_values (x44)
                x44.sequence_to_any (nvl.get_any_value_by_name ("val"))
            when 53 then
                x21 := is_abstract
                ca.put_boolean (x21)
            when 54 then
                add_in_arg_boolean ("val")
                dum := req.set_params (nvl)
                x33 := nvl.get_boolean_value_by_name ("val")
                set_is_abstract (x33)
            when 55 then
                x21 := is_custom
                ca.put_boolean (x21)
            when 56 then
                add_in_arg_boolean ("val")
                dum := req.set_params (nvl)
                x33 := nvl.get_boolean_value_by_name ("val")
                set_is_custom (x33)
            when 57 then
                x21 := is_truncatable
                ca.put_boolean (x21)
            when 58 then
                add_in_arg_boolean ("val")
                dum := req.set_params (nvl)
                x33 := nvl.get_boolean_value_by_name ("val")
                set_is_truncatable (x33)
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; idl_type : INTEGER) : BOOLEAN is

        do
            result := (1 <= idl_type and then idl_type <= 58)
            result := result and then msg.conforms_to (template)
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/ValueDef:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "ValueDef"
        end

end -- class CORBA_VALUEDEF
