deferred class CORBA_CONTAINED
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

    id : STRING is

        deferred
        end

    set_id (value : STRING) is

        deferred
        end

    name : STRING is

        deferred
        end

    set_name (value : STRING) is

        deferred
        end

    version : STRING is

        deferred
        end

    set_version (value : STRING) is

        deferred
        end

    defined_in : CORBA_CONTAINER is

        deferred
        end

    absolute_name : STRING is

        deferred
        end

    containing_repository : CORBA_REPOSITORY is

        deferred
        end

    describe : CORBA_CONTAINED_DESCRIPTION is

        deferred
        end

    move (new_container : CORBA_CONTAINER;
        new_name : STRING;
        new_version : STRING) is

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
            x2  : CORBA_CONTAINED_DESCRIPTION
            x3  : STRING
            x4  : CORBA_CONTAINER
            x5  : CORBA_REPOSITORY
            x6  : CORBA_CONTAINER
            x7  : STRING
            x8  : STRING

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
                x2 := describe
                ca.make1 (corba_contained_description_tc)
                x2.struct_to_any (ca)
            when 4 then
                add_in_arg_ref ("new_container")
                add_in_arg_string ("new_name")
                add_in_arg_string ("new_version")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("Container", "new_container")
                x6 := CORBA_Container_narrow (o)
                x7 := nvl.get_string_value_by_name ("new_name")
                x8 := nvl.get_string_value_by_name ("new_version")
                move (x6, x7, x8)
            when 5 then
                x3 := id
                ca.put_string (x3, 0)
            when 6 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x7 := nvl.get_string_value_by_name ("val")
                set_id (x7)
            when 7 then
                x3 := name
                ca.put_string (x3, 0)
            when 8 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x7 := nvl.get_string_value_by_name ("val")
                set_name (x7)
            when 9 then
                x3 := version
                ca.put_string (x3, 0)
            when 10 then
                add_in_arg_string ("val")
                dum := req.set_params (nvl)
                x7 := nvl.get_string_value_by_name ("val")
                set_version (x7)
            when 11 then
                x4 := defined_in
                ca.put_object ("corba_container", x4)
            when 12 then
                x3 := absolute_name
                ca.put_string (x3, 0)
            when 13 then
                x5 := containing_repository
                ca.put_object ("corba_repository", x5)
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; type : INTEGER) : BOOLEAN is

        do
            result := (1 <= type and then type <= 13)
            result := result and then msg.conforms_to (template)
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/Contained:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "Contained"
        end

end -- class CORBA_CONTAINED
