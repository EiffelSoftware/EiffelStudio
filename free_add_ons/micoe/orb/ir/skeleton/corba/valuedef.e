deferred class CORBA_VALUEDEF_SKEL
    -- This text was automatically generated. DO NOT EDIT!

inherit
    CORBA_VALUEDEF
        undefine
            doinvoke
        end;
    CORBA_CONTAINER_SKEL
        undefine
            make,
            repoid, type_name, consume,
            valid_message_type, template
        redefine
            dispatcher
        end;
    CORBA_CONTAINED_SKEL
        undefine
            make,
            repoid, type_name, consume,
            valid_message_type, template,
            ib_make, dispatcher
        end;
    CORBA_IDLTYPE_SKEL
        undefine
            make,
            repoid, type_name, consume,
            valid_message_type, template,
            ib_make, dispatcher
        end


feature { NONE }

    dispatcher : DICTIONARY [COURIER, STRING] is

        local
            cour : COURIER

        do
            create result.make
            create cour.make (void, void, 1)
            result.put (cour, "destroy")
            create cour.make (void, void, 2)
            result.put (cour, "_get_def_kind")
            create cour.make (void, void, 3)
            result.put (cour, "lookup")
            create cour.make (void, void, 4)
            result.put (cour, "contents")
            create cour.make (void, void, 5)
            result.put (cour, "lookup_name")
            create cour.make (void, void, 6)
            result.put (cour, "describe_contents")
            create cour.make (void, void, 7)
            result.put (cour, "create_module")
            create cour.make (void, void, 8)
            result.put (cour, "create_constant")
            create cour.make (void, void, 9)
            result.put (cour, "create_struct")
            create cour.make (void, void, 10)
            result.put (cour, "create_union")
            create cour.make (void, void, 11)
            result.put (cour, "create_enum")
            create cour.make (void, void, 12)
            result.put (cour, "create_alias")
            create cour.make (void, void, 13)
            result.put (cour, "create_interface")
            create cour.make (void, void, 14)
            result.put (cour, "create_value")
            create cour.make (void, void, 15)
            result.put (cour, "create_value_box")
            create cour.make (void, void, 16)
            result.put (cour, "create_exception")
            create cour.make (void, void, 17)
            result.put (cour, "create_native")
            create cour.make (void, void, 18)
            result.put (cour, "find")
            create cour.make (void, void, 19)
            result.put (cour, "find_name")
            create cour.make (void, void, 20)
            result.put (cour, "locate_id")
            create cour.make (void, void, 21)
            result.put (cour, "locate_name")
            create cour.make (void, void, 22)
            result.put (cour, "remove_contained")
            create cour.make (void, void, 23)
            result.put (cour, "add_contained")
            create cour.make (void, void, 24)
            result.put (cour, "destroy")
            create cour.make (void, void, 25)
            result.put (cour, "_get_def_kind")
            create cour.make (void, void, 26)
            result.put (cour, "describe")
            create cour.make (void, void, 27)
            result.put (cour, "move")
            create cour.make (void, void, 28)
            result.put (cour, "_get_id")
            create cour.make (void, void, 29)
            result.put (cour, "_set_id")
            create cour.make (void, void, 30)
            result.put (cour, "_get_name")
            create cour.make (void, void, 31)
            result.put (cour, "_set_name")
            create cour.make (void, void, 32)
            result.put (cour, "_get_version")
            create cour.make (void, void, 33)
            result.put (cour, "_set_version")
            create cour.make (void, void, 34)
            result.put (cour, "_get_defined_in")
            create cour.make (void, void, 35)
            result.put (cour, "_get_absolute_name")
            create cour.make (void, void, 36)
            result.put (cour, "_get_containing_repository")
            create cour.make (void, void, 37)
            result.put (cour, "destroy")
            create cour.make (void, void, 38)
            result.put (cour, "_get_def_kind")
            create cour.make (void, void, 39)
            result.put (cour, "_get_type")
            create cour.make (void, void, 40)
            result.put (cour, "is_a")
            create cour.make (void, void, 41)
            result.put (cour, "describe_value")
            create cour.make (void, void, 42)
            result.put (cour, "create_value_member")
            create cour.make (void, void, 43)
            result.put (cour, "create_attribute")
            create cour.make (void, void, 44)
            result.put (cour, "create_operation")
            create cour.make (void, void, 45)
            result.put (cour, "_get_supported_interfaces")
            create cour.make (void, void, 46)
            result.put (cour, "_set_supported_interfaces")
            create cour.make (void, void, 47)
            result.put (cour, "_get_initializers")
            create cour.make (void, void, 48)
            result.put (cour, "_set_initializers")
            create cour.make (void, void, 49)
            result.put (cour, "_get_base_value")
            create cour.make (void, void, 50)
            result.put (cour, "_set_base_value")
            create cour.make (void, void, 51)
            result.put (cour, "_get_abstract_base_values")
            create cour.make (void, void, 52)
            result.put (cour, "_set_abstract_base_values")
            create cour.make (void, void, 53)
            result.put (cour, "_get_is_abstract")
            create cour.make (void, void, 54)
            result.put (cour, "_set_is_abstract")
            create cour.make (void, void, 55)
            result.put (cour, "_get_is_custom")
            create cour.make (void, void, 56)
            result.put (cour, "_set_is_custom")
            create cour.make (void, void, 57)
            result.put (cour, "_get_is_truncatable")
            create cour.make (void, void, 58)
            result.put (cour, "_set_is_truncatable")
        end

end -- class CORBA_VALUEDEF_SKEL
