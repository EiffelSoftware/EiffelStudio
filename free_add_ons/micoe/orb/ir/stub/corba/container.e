class CORBA_CONTAINER_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_CONTAINER
        undefine
            implementation
        end;
    CORBA_IROBJECT_STUB
        undefine
            copy, is_equal, make,
            repoid, type_name,
            consume, valid_message_type,
            template
        end

creation
    make, make_with_peer

feature

    lookup (search_name : STRING) : CORBA_CONTAINED is

        local
            o : CORBA_OBJECT

        do
            begin_request ("lookup")
            stub_add_in_arg_string ("search_name", search_name)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_Contained_narrow (o)
            end_request
        end

    contents (limit_type : CORBA_DEFINITIONKIND;
        exclude_inherited : BOOLEAN) : CORBA_CONTAINEDSEQ is

        local
            ca : CORBA_ANY

        do
            begin_request ("contents")
            create ca.make1 (corba_definitionkind_tc)
            limit_type.enum_to_any (ca)
            stub_add_in_arg_any ("limit_type", ca)
            stub_add_in_arg_boolean ("exclude_inherited", exclude_inherited)
            result_is_of_type (corba_containedseq_tc)
            invoke
            create result.make_default
            result.sequence_from_any (get_result_as_any)
            end_request
        end

    lookup_name (search_name : STRING;
        levels_to_search : INTEGER;
        limit_type : CORBA_DEFINITIONKIND;
        exclude_inherited : BOOLEAN) : CORBA_CONTAINEDSEQ is

        local
            ca : CORBA_ANY

        do
            begin_request ("lookup_name")
            stub_add_in_arg_string ("search_name", search_name)
            stub_add_in_arg_integer ("levels_to_search", levels_to_search)
            create ca.make1 (corba_definitionkind_tc)
            limit_type.enum_to_any (ca)
            stub_add_in_arg_any ("limit_type", ca)
            stub_add_in_arg_boolean ("exclude_inherited", exclude_inherited)
            result_is_of_type (corba_containedseq_tc)
            invoke
            create result.make_default
            result.sequence_from_any (get_result_as_any)
            end_request
        end

    describe_contents (limit_type : CORBA_DEFINITIONKIND;
        exclude_inherited : BOOLEAN;
        max_returned_objs : INTEGER) : CORBA_CONTAINER_DESCRIPTIONSEQ is

        local
            ca : CORBA_ANY

        do
            begin_request ("describe_contents")
            create ca.make1 (corba_definitionkind_tc)
            limit_type.enum_to_any (ca)
            stub_add_in_arg_any ("limit_type", ca)
            stub_add_in_arg_boolean ("exclude_inherited", exclude_inherited)
            stub_add_in_arg_integer ("max_returned_objs", max_returned_objs)
            result_is_of_type (corba_container_descriptionseq_tc)
            invoke
            create result.make_default
            result.sequence_from_any (get_result_as_any)
            end_request
        end

    create_module (id : STRING;
        name : STRING;
        version : STRING) : CORBA_MODULEDEF is

        local
            o : CORBA_OBJECT

        do
            begin_request ("create_module")
            stub_add_in_arg_string ("id", id)
            stub_add_in_arg_string ("name", name)
            stub_add_in_arg_string ("version", version)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_ModuleDef_narrow (o)
            end_request
        end

    create_constant (id : STRING;
        name : STRING;
        version : STRING;
        type : CORBA_IDLTYPE;
        value : CORBA_ANY) : CORBA_CONSTANTDEF is

        local
            o : CORBA_OBJECT

        do
            begin_request ("create_constant")
            stub_add_in_arg_string ("id", id)
            stub_add_in_arg_string ("name", name)
            stub_add_in_arg_string ("version", version)
            stub_add_in_arg_ref ("type", type.type_name, type.implementation)
            stub_add_in_arg_any ("value", value)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_ConstantDef_narrow (o)
            end_request
        end

    create_struct (id : STRING;
        name : STRING;
        version : STRING;
        members : CORBA_STRUCTMEMBERSEQ) : CORBA_STRUCTDEF is

        local
            ca : CORBA_ANY
            o : CORBA_OBJECT

        do
            begin_request ("create_struct")
            stub_add_in_arg_string ("id", id)
            stub_add_in_arg_string ("name", name)
            stub_add_in_arg_string ("version", version)
            create ca.make1 (corba_structmemberseq_tc)
            members.sequence_to_any (ca)
            stub_add_in_arg_any ("members", ca)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_StructDef_narrow (o)
            end_request
        end

    create_union (id : STRING;
        name : STRING;
        version : STRING;
        discriminator_type : CORBA_IDLTYPE;
        members : CORBA_UNIONMEMBERSEQ) : CORBA_UNIONDEF is

        local
            ca : CORBA_ANY
            o : CORBA_OBJECT

        do
            begin_request ("create_union")
            stub_add_in_arg_string ("id", id)
            stub_add_in_arg_string ("name", name)
            stub_add_in_arg_string ("version", version)
            stub_add_in_arg_ref ("discriminator_type", discriminator_type.type_name, discriminator_type.implementation)
            create ca.make1 (corba_unionmemberseq_tc)
            members.sequence_to_any (ca)
            stub_add_in_arg_any ("members", ca)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_UnionDef_narrow (o)
            end_request
        end

    create_enum (id : STRING;
        name : STRING;
        version : STRING;
        members : CORBA_ENUMMEMBERSEQ) : CORBA_ENUMDEF is

        local
            ca : CORBA_ANY
            o : CORBA_OBJECT

        do
            begin_request ("create_enum")
            stub_add_in_arg_string ("id", id)
            stub_add_in_arg_string ("name", name)
            stub_add_in_arg_string ("version", version)
            create ca.make1 (corba_enummemberseq_tc)
            members.sequence_to_any (ca)
            stub_add_in_arg_any ("members", ca)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_EnumDef_narrow (o)
            end_request
        end

    create_alias (id : STRING;
        name : STRING;
        version : STRING;
        original_type : CORBA_IDLTYPE) : CORBA_ALIASDEF is

        local
            o : CORBA_OBJECT

        do
            begin_request ("create_alias")
            stub_add_in_arg_string ("id", id)
            stub_add_in_arg_string ("name", name)
            stub_add_in_arg_string ("version", version)
            stub_add_in_arg_ref ("original_type", original_type.type_name, original_type.implementation)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_AliasDef_narrow (o)
            end_request
        end

    create_interface (id : STRING;
        name : STRING;
        version : STRING;
        base_interfaces : CORBA_INTERFACEDEFSEQ;
        is_abstract : BOOLEAN) : CORBA_INTERFACEDEF is

        local
            ca : CORBA_ANY
            o : CORBA_OBJECT

        do
            begin_request ("create_interface")
            stub_add_in_arg_string ("id", id)
            stub_add_in_arg_string ("name", name)
            stub_add_in_arg_string ("version", version)
            create ca.make1 (corba_interfacedefseq_tc)
            base_interfaces.sequence_to_any (ca)
            stub_add_in_arg_any ("base_interfaces", ca)
            stub_add_in_arg_boolean ("is_abstract", is_abstract)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_InterfaceDef_narrow (o)
            end_request
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

        local
            ca : CORBA_ANY
            o : CORBA_OBJECT

        do
            begin_request ("create_value")
            stub_add_in_arg_string ("id", id)
            stub_add_in_arg_string ("name", name)
            stub_add_in_arg_string ("version", version)
            stub_add_in_arg_boolean ("is_custom", is_custom)
            stub_add_in_arg_boolean ("is_abstract", is_abstract)
            stub_add_in_arg_ref ("base_value", base_value.type_name, base_value.implementation)
            stub_add_in_arg_boolean ("is_truncatable", is_truncatable)
            create ca.make1 (corba_valuedefseq_tc)
            abstract_base_values.sequence_to_any (ca)
            stub_add_in_arg_any ("abstract_base_values", ca)
            create ca.make1 (corba_interfacedefseq_tc)
            supported_interfaces.sequence_to_any (ca)
            stub_add_in_arg_any ("supported_interfaces", ca)
            create ca.make1 (corba_initializerseq_tc)
            initializers.sequence_to_any (ca)
            stub_add_in_arg_any ("initializers", ca)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_ValueDef_narrow (o)
            end_request
        end

    create_value_box (id : STRING;
        name : STRING;
        version : STRING;
        original_type_def : CORBA_IDLTYPE) : CORBA_VALUEBOXDEF is

        local
            o : CORBA_OBJECT

        do
            begin_request ("create_value_box")
            stub_add_in_arg_string ("id", id)
            stub_add_in_arg_string ("name", name)
            stub_add_in_arg_string ("version", version)
            stub_add_in_arg_ref ("original_type_def", original_type_def.type_name, original_type_def.implementation)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_ValueBoxDef_narrow (o)
            end_request
        end

    create_exception (id : STRING;
        name : STRING;
        version : STRING;
        members : CORBA_STRUCTMEMBERSEQ) : CORBA_EXCEPTIONDEF is

        local
            ca : CORBA_ANY
            o : CORBA_OBJECT

        do
            begin_request ("create_exception")
            stub_add_in_arg_string ("id", id)
            stub_add_in_arg_string ("name", name)
            stub_add_in_arg_string ("version", version)
            create ca.make1 (corba_structmemberseq_tc)
            members.sequence_to_any (ca)
            stub_add_in_arg_any ("members", ca)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_ExceptionDef_narrow (o)
            end_request
        end

    create_native (id : STRING;
        name : STRING;
        version : STRING) : CORBA_NATIVEDEF is

        local
            o : CORBA_OBJECT

        do
            begin_request ("create_native")
            stub_add_in_arg_string ("id", id)
            stub_add_in_arg_string ("name", name)
            stub_add_in_arg_string ("version", version)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_NativeDef_narrow (o)
            end_request
        end

    find (search_name : STRING) : CORBA_CONTAINED is

        local
            o : CORBA_OBJECT

        do
            begin_request ("find")
            stub_add_in_arg_string ("search_name", search_name)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_Contained_narrow (o)
            end_request
        end

    find_name (search_name : STRING;
        limit_type : CORBA_DEFINITIONKIND) : CORBA_CONTAINEDSEQ is

        local
            ca : CORBA_ANY

        do
            begin_request ("find_name")
            stub_add_in_arg_string ("search_name", search_name)
            create ca.make1 (corba_definitionkind_tc)
            limit_type.enum_to_any (ca)
            stub_add_in_arg_any ("limit_type", ca)
            result_is_of_type (corba_containedseq_tc)
            invoke
            create result.make_default
            result.sequence_from_any (get_result_as_any)
            end_request
        end

    locate_id (id : STRING) : CORBA_CONTAINED is

        local
            o : CORBA_OBJECT

        do
            begin_request ("locate_id")
            stub_add_in_arg_string ("id", id)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_Contained_narrow (o)
            end_request
        end

    locate_name (name : STRING;
        include_enclosing_scopes : BOOLEAN;
        is_first_level : BOOLEAN) : CORBA_CONTAINED is

        local
            o : CORBA_OBJECT

        do
            begin_request ("locate_name")
            stub_add_in_arg_string ("name", name)
            stub_add_in_arg_boolean ("include_enclosing_scopes", include_enclosing_scopes)
            stub_add_in_arg_boolean ("is_first_level", is_first_level)
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_Contained_narrow (o)
            end_request
        end

    remove_contained (con : CORBA_CONTAINED) is

        do
            begin_request ("remove_contained")
            stub_add_in_arg_ref ("con", con.type_name, con.implementation)
            invoke
            end_request
        end

    add_contained (con : CORBA_CONTAINED) is

        do
            begin_request ("add_contained")
            stub_add_in_arg_ref ("con", con.type_name, con.implementation)
            invoke
            end_request
        end

end -- class CORBA_CONTAINER_STUB
