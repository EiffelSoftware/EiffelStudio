class SERVER

inherit
    CORBA_GENERAL;
    ARGUMENTS

creation
    make

feature

    make is

        local
            err     : BOOLEAN
            orb     : ORB
            boa     : BOA
            servant : ACCOUNT
            argc    : INTEGER_REF

        do
            if not err then
                -- Initialize the ORB and BOA

                create argc
                argc.set_item (argument_count)
                orb := ORB_init (argc, argument_array, "mico-local-orb")
                boa := orb.BOA_init (argc, argument_array, "mico-local-boa")

                -- Now create an implementation object

                create {ACCOUNT_IMPL} servant.make

                -- Tell the BOA our servant is ready and put the
                -- ORB in its event loop.

                boa.impl_is_ready (void)
                orb.run
            else -- killed by user
                io.put_string ("Server stopped%N")
            end

        rescue
             err := true
             retry
        end

end -- class SERVER
