deferred class CORBA_OPERATIONDEF_SKEL
    -- This text was automatically generated. DO NOT EDIT!

inherit
    CORBA_OPERATIONDEF
        undefine
            doinvoke
        end;
    CORBA_CONTAINED_SKEL
        undefine
            make,
            repoid, type_name, consume,
            valid_message_type, template
        redefine
            dispatcher
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
            result.put (cour, "describe")
            create cour.make (void, void, 4)
            result.put (cour, "move")
            create cour.make (void, void, 5)
            result.put (cour, "_get_id")
            create cour.make (void, void, 6)
            result.put (cour, "_set_id")
            create cour.make (void, void, 7)
            result.put (cour, "_get_name")
            create cour.make (void, void, 8)
            result.put (cour, "_set_name")
            create cour.make (void, void, 9)
            result.put (cour, "_get_version")
            create cour.make (void, void, 10)
            result.put (cour, "_set_version")
            create cour.make (void, void, 11)
            result.put (cour, "_get_defined_in")
            create cour.make (void, void, 12)
            result.put (cour, "_get_absolute_name")
            create cour.make (void, void, 13)
            result.put (cour, "_get_containing_repository")
            create cour.make (void, void, 14)
            result.put (cour, "_get_result")
            create cour.make (void, void, 15)
            result.put (cour, "_get_result_def")
            create cour.make (void, void, 16)
            result.put (cour, "_set_result_def")
            create cour.make (void, void, 17)
            result.put (cour, "_get_params")
            create cour.make (void, void, 18)
            result.put (cour, "_set_params")
            create cour.make (void, void, 19)
            result.put (cour, "_get_mode")
            create cour.make (void, void, 20)
            result.put (cour, "_set_mode")
            create cour.make (void, void, 21)
            result.put (cour, "_get_contexts")
            create cour.make (void, void, 22)
            result.put (cour, "_set_contexts")
            create cour.make (void, void, 23)
            result.put (cour, "_get_exceptions")
            create cour.make (void, void, 24)
            result.put (cour, "_set_exceptions")
        end

end -- class CORBA_OPERATIONDEF_SKEL
