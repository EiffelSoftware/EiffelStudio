class SERVER

inherit
    ARGUMENTS;
    THE_LOGGER;
    CORBA_GENERAL

creation
    make

feature

    make is

        local
            argc    : INTEGER_REF
            orb     : ORB
            boa     : BOA
            servant : HELLO
            err     : BOOLEAN

        do
            if not err then
                create argc
                argc.set_item (argument_count)
                orb := ORB_init (argc, argument_array, "mico-local-orb")
                boa := orb.BOA_init (argc, argument_array, "mico-local-boa")

                -- Create a servant.

                create {HELLO_IMPL} servant.make

                boa.impl_is_ready (void)
                orb.run
            else -- killed by user
                logger.log (logger.Log_info, "General", "SERVER", 
                            "make").put_string ("Server stopped%N")
            end

        rescue
            err := true
            logger.log (logger.Log_notice, "General", "CLIENT",
                        "make").put_string (except.exception_trace)
            retry
        end
----------------------

    except : EXCEPTIONS is

        once
            create result
        end

end -- class SERVER
