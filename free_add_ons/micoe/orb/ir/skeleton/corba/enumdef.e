deferred class CORBA_ENUMDEF_SKEL
    -- This text was automatically generated. DO NOT EDIT!

inherit
    CORBA_ENUMDEF
        undefine
            doinvoke
        end;
    CORBA_TYPEDEFDEF_SKEL
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
            result.put (cour, "destroy")
            create cour.make (void, void, 15)
            result.put (cour, "_get_def_kind")
            create cour.make (void, void, 16)
            result.put (cour, "_get_type")
            create cour.make (void, void, 17)
            result.put (cour, "_get_members")
            create cour.make (void, void, 18)
            result.put (cour, "_set_members")
        end

end -- class CORBA_ENUMDEF_SKEL
