deferred class CORBA_ARRAYDEF_SKEL
    -- This text was automatically generated. DO NOT EDIT!

inherit
    CORBA_ARRAYDEF
        undefine
            doinvoke
        end;
    CORBA_IDLTYPE_SKEL
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
            result.put (cour, "_get_type")
            create cour.make (void, void, 4)
            result.put (cour, "_get_length")
            create cour.make (void, void, 5)
            result.put (cour, "_set_length")
            create cour.make (void, void, 6)
            result.put (cour, "_get_element_type")
            create cour.make (void, void, 7)
            result.put (cour, "_get_element_type_def")
            create cour.make (void, void, 8)
            result.put (cour, "_set_element_type_def")
        end

end -- class CORBA_ARRAYDEF_SKEL
