class CLIENT

inherit
    CORBA_GENERAL;
    BANKING_HELPER;
    ARGUMENTS

creation
    make

feature

    objpath : STRING is "/tmp/account.obj"

    make is

        local
            orb     : ORB
            boa     : BOA
            obj     : CORBA_OBJECT
            proxy   : ACCOUNT
            argc    : INTEGER_REF
            objfile : PLAIN_TEXT_FILE
            err     : BOOLEAN

        do
            if not err then
                -- Initialize the ORB and BOA

                create argc
                argc.set_item (argument_count)
                orb := ORB_init (argc, argument_array, "mico-local-orb")
                boa := orb.BOA_init (argc, argument_array, "mico-local-boa")

                -- Now fetch a reference to the servant

                create objfile.make_open_read (objpath)
                objfile.read_line
                obj := orb.string_to_object (objfile.last_string)
                objfile.close

                -- And create a proxy for it

                proxy := Account_narrow (obj)

                -- Now we can use our account via the proxy

                proxy.deposit (700)
                proxy.withdraw (250)
                io.put_string ("%NBalance is ")
                io.putint (proxy.balance)
                io.new_line
            else
                io.put_string ("Client died%N")
            end

        rescue
            err := true
            if last_exception /= void then
                last_exception.print_it
            else
                io.put_string (except.exception_trace)
            end
            retry
        end
----------------------

    except : EXCEPTIONS is

        once
            create result
        end

end -- class CLIENT









