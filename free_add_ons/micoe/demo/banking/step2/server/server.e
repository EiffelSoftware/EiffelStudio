class SERVER

inherit
    CORBA_GENERAL;
    ARGUMENTS

creation
    make

feature

    objpath : STRING is "/tmp/account.obj"
    
    make is

        local
            err     : BOOLEAN
            orb     : ORB
            boa     : BOA
            servant : ACCOUNT
            argc    : INTEGER_REF
            objfile : PLAIN_TEXT_FILE

        do
            if not err then
                -- Initialize the ORB and BOA

                create argc
                argc.set_item (argument_count)
                orb := ORB_init (argc, argument_array, "mico-local-orb")
                boa := orb.BOA_init (argc, argument_array, "mico-local-boa")

                -- Now create an implementation object

                create {ACCOUNT_IMPL} servant.make

                -- Now put a stringified reference to our sevant in a
                -- a file where the client can find it.

                create objfile.make_open_write (objpath)
                objfile.put_string (orb.object_to_string (servant))
                objfile.new_line
                objfile.close

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
