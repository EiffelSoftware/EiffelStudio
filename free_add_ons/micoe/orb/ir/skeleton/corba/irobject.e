deferred class CORBA_IROBJECT_SKEL
    -- This text was automatically generated. DO NOT EDIT!

inherit
    STANDARD_SKELETON
        undefine
            repoid, consume, valid_message_type
        select
            doinvoke
        end;
    CORBA_IROBJECT
        rename
            doinvoke as unused_doinvoke
        select
            make
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
        end

end -- class CORBA_IROBJECT_SKEL
