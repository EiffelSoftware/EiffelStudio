class CORBA_CONTAINED_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_CONTAINED
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

    id : STRING is

        do
            begin_request ("_get_id")
            result_is_STRING
            invoke
            result := get_result_STRING
            end_request
        end

    set_id (value : STRING) is

        do
            begin_request ("_set_id")
            stub_add_in_arg_string ("value", value)
            invoke
            end_request
        end

    name : STRING is

        do
            begin_request ("_get_name")
            result_is_STRING
            invoke
            result := get_result_STRING
            end_request
        end

    set_name (value : STRING) is

        do
            begin_request ("_set_name")
            stub_add_in_arg_string ("value", value)
            invoke
            end_request
        end

    version : STRING is

        do
            begin_request ("_get_version")
            result_is_STRING
            invoke
            result := get_result_STRING
            end_request
        end

    set_version (value : STRING) is

        do
            begin_request ("_set_version")
            stub_add_in_arg_string ("value", value)
            invoke
            end_request
        end

    defined_in : CORBA_CONTAINER is

        local
            o : CORBA_OBJECT

        do
            begin_request ("_get_defined_in")
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_Container_narrow (o)
            end_request
        end

    absolute_name : STRING is

        do
            begin_request ("_get_absolute_name")
            result_is_STRING
            invoke
            result := get_result_STRING
            end_request
        end

    containing_repository : CORBA_REPOSITORY is

        local
            o : CORBA_OBJECT

        do
            begin_request ("_get_containing_repository")
            result_is_ref
            invoke
            o := get_result_ref
            result := CORBA_Repository_narrow (o)
            end_request
        end

    describe : CORBA_CONTAINED_DESCRIPTION is

        do
            begin_request ("describe")
            result_is_of_type (corba_contained_description_tc)
            invoke
            create result.make_default
            result.struct_from_any (get_result_as_any)
            end_request
        end

    move (new_container : CORBA_CONTAINER;
        new_name : STRING;
        new_version : STRING) is

        do
            begin_request ("move")
            stub_add_in_arg_ref ("new_container", new_container.type_name, new_container.implementation)
            stub_add_in_arg_string ("new_name", new_name)
            stub_add_in_arg_string ("new_version", new_version)
            invoke
            end_request
        end

end -- class CORBA_CONTAINED_STUB
