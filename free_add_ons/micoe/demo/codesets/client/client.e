class CLIENT

inherit
    ARGUMENTS;
    THE_LOGGER;
    CORBA_GENERAL;
    HELLO_HELPER

creation
    make

feature

    Test_string : STRING is "Der Erfolg ist mehr als nur m&auml;&szlig;ig%N"

    make is

        local
            argc   : INTEGER_REF
            orb    : ORB
            boa    : BOA
            obj    : CORBA_OBJECT
            proxy  : HELLO
            answer : STRING
            err    : BOOLEAN

        do
            if not err then
                create argc
                argc.set_item (argument_count)
                orb := ORB_init (argc, argument_array, "mico-local-orb")
                boa := orb.BOA_init (argc, argument_array, "mico-local-boa")
                obj := orb.bind1 ("IDL:Hello:1.0")
                proxy := Hello_narrow (obj)
                io.put_string ("Client says:%N")
                io.put_string (Test_string)
                answer := proxy.hello (Test_string)
                io.put_string ("Server answers:%N")
                io.put_string (answer)
            else
                logger.log (logger.Log_err, "General", "CLIENT", 
                            "make").put_string ("Client died!%N")
            end

        rescue
            err := true
            if last_exception /= void then
                last_exception.print_it
            else
                logger.log (logger.Log_notice, "General", "CLIENT",
                            "make").put_string (except.exception_trace)
            end
            retry
        end
----------------------

    except : EXCEPTIONS is

        once
            create result
        end

end -- class CLIENT






