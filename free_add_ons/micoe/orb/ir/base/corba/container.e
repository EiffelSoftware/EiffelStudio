deferred class CORBA_CONTAINER
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
    CORBA_IROBJECT
        redefine
            repoid, type_name, consume, valid_message_type
        end
feature

    lookup (search_name : STRING) : CORBA_CONTAINED is

        deferred
        end

    contents (limit_type : CORBA_DEFINITIONKIND;
        exclude_inherited : BOOLEAN) : CORBA_CONTAINEDSEQ is

        deferred
        end

    lookup_name (search_name : STRING;
        levels_to_search : INTEGER;
        limit_type : CORBA_DEFINITIONKIND;
        exclude_inherited : BOOLEAN) : CORBA_CONTAINEDSEQ is

        deferred
        end

    describe_contents (limit_type : CORBA_DEFINITIONKIND;
        exclude_inherited : BOOLEAN;
        max_returned_objs : INTEGER) : CORBA_CONTAINER_DESCRIPTIONSEQ is

        deferred
        end

    create_module (id : STRING;
        name : STRING;
        version : STRING) : CORBA_MODULEDEF is

        deferred
        end

    create_constant (id : STRING;
        name : STRING;
        version : STRING;
        type : CORBA_IDLTYPE;
        value : CORBA_ANY) : CORBA_CONSTANTDEF is

        deferred
        end

    create_struct (id : STRING;
        name : STRING;
        version : STRING;
        members : CORBA_STRUCTMEMBERSEQ) : CORBA_STRUCTDEF is

        deferred
        end

    create_union (id : STRING;
        name : STRING;
        version : STRING;
        discriminator_type : CORBA_IDLTYPE;
        members : CORBA_UNIONMEMBERSEQ) : CORBA_UNIONDEF is

        deferred
        end

    create_enum (id : STRING;
        name : STRING;
        version : STRING;
        members : CORBA_ENUMMEMBERSEQ) : CORBA_ENUMDEF is

        deferred
        end

    create_alias (id : STRING;
        name : STRING;
        version : STRING;
        original_type : CORBA_IDLTYPE) : CORBA_ALIASDEF is

        deferred
        end

    create_interface (id : STRING;
        name : STRING;
        version : STRING;
        base_interfaces : CORBA_INTERFACEDEFSEQ;
        is_abstract : BOOLEAN) : CORBA_INTERFACEDEF is

        deferred
        end

    create_value (id : STRING;
        name : STRING;
        version : STRING;
        is_custom : BOOLEAN;
        is_abstract : BOOLEAN;
        base_value : CORBA_VALUEDEF;
        is_truncatable : BOOLEAN;
        abstract_base_values : CORBA_VALUEDEFSEQ;
        supported_interfaces : CORBA_INTERFACEDEFSEQ;
        initializers : CORBA_INITIALIZERSEQ) : CORBA_VALUEDEF is

        deferred
        end

    create_value_box (id : STRING;
        name : STRING;
        version : STRING;
        original_type_def : CORBA_IDLTYPE) : CORBA_VALUEBOXDEF is

        deferred
        end

    create_exception (id : STRING;
        name : STRING;
        version : STRING;
        members : CORBA_STRUCTMEMBERSEQ) : CORBA_EXCEPTIONDEF is

        deferred
        end

    create_native (id : STRING;
        name : STRING;
        version : STRING) : CORBA_NATIVEDEF is

        deferred
        end

    find (search_name : STRING) : CORBA_CONTAINED is

        deferred
        end

    find_name (search_name : STRING;
        limit_type : CORBA_DEFINITIONKIND) : CORBA_CONTAINEDSEQ is

        deferred
        end

    locate_id (id : STRING) : CORBA_CONTAINED is

        deferred
        end

    locate_name (name : STRING;
        include_enclosing_scopes : BOOLEAN;
        is_first_level : BOOLEAN) : CORBA_CONTAINED is

        deferred
        end

    remove_contained (con : CORBA_CONTAINED) is

        deferred
        end

    add_contained (con : CORBA_CONTAINED) is

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
            x16  : STRING
            x17  : STRING
            x18  : STRING
            x19  : CORBA_DEFINITIONKIND
            x20  : BOOLEAN
            x21  : BOOLEAN
            x22  : BOOLEAN
            x23  : INTEGER
            x24  : CORBA_IDLTYPE
            x25  : CORBA_ANY
            x26  : CORBA_STRUCTMEMBERSEQ
            x27  : CORBA_UNIONMEMBERSEQ
            x28  : CORBA_ENUMMEMBERSEQ
            x29  : CORBA_INTERFACEDEFSEQ
            x30  : CORBA_VALUEDEF
            x31  : CORBA_VALUEDEFSEQ
            x32  : CORBA_INITIALIZERSEQ
            x33  : CORBA_CONTAINED

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
                x16 := nvl.get_string_value_by_name ("search_name")
                x2 := lookup (x16)
                ca.put_object ("corba_contained", x2)
            when 4 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                create x19.make_default
                x19.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x20 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x3 := contents (x19, x20)
                x19.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 5 then
                add_in_arg_string ("search_name")
                add_in_arg_integer ("levels_to_search")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("search_name")
                x23 := nvl.get_integer_value_by_name ("levels_to_search")
                create x19.make_default
                x19.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x20 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x3 := lookup_name (x16, x23, x19, x20)
                x19.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 6 then
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                add_in_arg_boolean ("exclude_inherited")
                add_in_arg_integer ("max_returned_objs")
                dum := req.set_params (nvl)
                create x19.make_default
                x19.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x20 := nvl.get_boolean_value_by_name ("exclude_inherited")
                x23 := nvl.get_integer_value_by_name ("max_returned_objs")
                x4 := describe_contents (x19, x20, x23)
                x19.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_container_descriptionseq_tc)
                x4.sequence_to_any (ca)
            when 7 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("id")
                x17 := nvl.get_string_value_by_name ("name")
                x18 := nvl.get_string_value_by_name ("version")
                x5 := create_module (x16, x17, x18)
                ca.put_object ("corba_moduledef", x5)
            when 8 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("type")
                add_in_arg_ref ("value")
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("id")
                x17 := nvl.get_string_value_by_name ("name")
                x18 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "type")
                x24 := CORBA_IDLType_narrow (o)
                x6 := create_constant (x16, x17, x18, x24, x25)
                ca.put_object ("corba_constantdef", x6)
            when 9 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("id")
                x17 := nvl.get_string_value_by_name ("name")
                x18 := nvl.get_string_value_by_name ("version")
                create x26.make_default
                x26.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x7 := create_struct (x16, x17, x18, x26)
                x26.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_structdef", x7)
            when 10 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("discriminator_type")
                add_in_arg_with_type ("members", corba_unionmemberseq_tc)
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("id")
                x17 := nvl.get_string_value_by_name ("name")
                x18 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "discriminator_type")
                x24 := CORBA_IDLType_narrow (o)
                create x27.make_default
                x27.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x8 := create_union (x16, x17, x18, x24, x27)
                x27.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_uniondef", x8)
            when 11 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_enummemberseq_tc)
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("id")
                x17 := nvl.get_string_value_by_name ("name")
                x18 := nvl.get_string_value_by_name ("version")
                create x28.make_default
                x28.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x9 := create_enum (x16, x17, x18, x28)
                x28.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_enumdef", x9)
            when 12 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type")
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("id")
                x17 := nvl.get_string_value_by_name ("name")
                x18 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type")
                x24 := CORBA_IDLType_narrow (o)
                x10 := create_alias (x16, x17, x18, x24)
                ca.put_object ("corba_aliasdef", x10)
            when 13 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("base_interfaces", corba_interfacedefseq_tc)
                add_in_arg_boolean ("is_abstract")
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("id")
                x17 := nvl.get_string_value_by_name ("name")
                x18 := nvl.get_string_value_by_name ("version")
                create x29.make_default
                x29.sequence_from_any (nvl.get_any_value_by_name ("base_interfaces"))
                x20 := nvl.get_boolean_value_by_name ("is_abstract")
                x11 := create_interface (x16, x17, x18, x29, x20)
                x29.sequence_to_any (nvl.get_any_value_by_name ("base_interfaces"))
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
                x16 := nvl.get_string_value_by_name ("id")
                x17 := nvl.get_string_value_by_name ("name")
                x18 := nvl.get_string_value_by_name ("version")
                x20 := nvl.get_boolean_value_by_name ("is_custom")
                x21 := nvl.get_boolean_value_by_name ("is_abstract")
                o := nvl.get_ref_value_by_name ("ValueDef", "base_value")
                x30 := CORBA_ValueDef_narrow (o)
                x22 := nvl.get_boolean_value_by_name ("is_truncatable")
                create x31.make_default
                x31.sequence_from_any (nvl.get_any_value_by_name ("abstract_base_values"))
                create x29.make_default
                x29.sequence_from_any (nvl.get_any_value_by_name ("supported_interfaces"))
                create x32.make_default
                x32.sequence_from_any (nvl.get_any_value_by_name ("initializers"))
                x12 := create_value (x16, x17, x18, x20, x21, x30, x22, x31, x29, x32)
                x31.sequence_to_any (nvl.get_any_value_by_name ("abstract_base_values"))
                x29.sequence_to_any (nvl.get_any_value_by_name ("supported_interfaces"))
                x32.sequence_to_any (nvl.get_any_value_by_name ("initializers"))
                ca.put_object ("corba_valuedef", x12)
            when 15 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_ref ("original_type_def")
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("id")
                x17 := nvl.get_string_value_by_name ("name")
                x18 := nvl.get_string_value_by_name ("version")
                o := nvl.get_ref_value_by_name ("IDLType", "original_type_def")
                x24 := CORBA_IDLType_narrow (o)
                x13 := create_value_box (x16, x17, x18, x24)
                ca.put_object ("corba_valueboxdef", x13)
            when 16 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                add_in_arg_with_type ("members", corba_structmemberseq_tc)
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("id")
                x17 := nvl.get_string_value_by_name ("name")
                x18 := nvl.get_string_value_by_name ("version")
                create x26.make_default
                x26.sequence_from_any (nvl.get_any_value_by_name ("members"))
                x14 := create_exception (x16, x17, x18, x26)
                x26.sequence_to_any (nvl.get_any_value_by_name ("members"))
                ca.put_object ("corba_exceptiondef", x14)
            when 17 then
                add_in_arg_string ("id")
                add_in_arg_string ("name")
                add_in_arg_string ("version")
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("id")
                x17 := nvl.get_string_value_by_name ("name")
                x18 := nvl.get_string_value_by_name ("version")
                x15 := create_native (x16, x17, x18)
                ca.put_object ("corba_nativedef", x15)
            when 18 then
                add_in_arg_string ("search_name")
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("search_name")
                x2 := find (x16)
                ca.put_object ("corba_contained", x2)
            when 19 then
                add_in_arg_string ("search_name")
                add_in_arg_with_type ("limit_type", corba_definitionkind_tc)
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("search_name")
                create x19.make_default
                x19.enum_from_any (nvl.get_any_value_by_name ("limit_type"))
                x3 := find_name (x16, x19)
                x19.enum_to_any (nvl.get_any_value_by_name ("limit_type"))
                ca.make1 (corba_containedseq_tc)
                x3.sequence_to_any (ca)
            when 20 then
                add_in_arg_string ("id")
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("id")
                x2 := locate_id (x16)
                ca.put_object ("corba_contained", x2)
            when 21 then
                add_in_arg_string ("name")
                add_in_arg_boolean ("include_enclosing_scopes")
                add_in_arg_boolean ("is_first_level")
                dum := req.set_params (nvl)
                x16 := nvl.get_string_value_by_name ("name")
                x20 := nvl.get_boolean_value_by_name ("include_enclosing_scopes")
                x21 := nvl.get_boolean_value_by_name ("is_first_level")
                x2 := locate_name (x16, x20, x21)
                ca.put_object ("corba_contained", x2)
            when 22 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x33 := CORBA_Contained_narrow (o)
                remove_contained (x33)
            when 23 then
                add_in_arg_ref ("con")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Contained", "con")
                x33 := CORBA_Contained_narrow (o)
                add_contained (x33)
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; type : INTEGER) : BOOLEAN is

        do
            result := (1 <= type and then type <= 23)
            result := result and then msg.conforms_to (template)
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/Container:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "Container"
        end

end -- class CORBA_CONTAINER
