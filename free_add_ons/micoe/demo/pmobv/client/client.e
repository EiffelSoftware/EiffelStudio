class CLIENT

inherit
    CORBA_GENERAL;
    BANKING_HELPER
    ARGUMENTS

creation
    make

feature

    make is

        local
            orb    : ORB
            boa    : BOA
            obj    : CORBA_OBJECT
            proxy  : ACCOUNT
            struct : AMOUNTSTRUCT
            argc   : INTEGER_REF
            err    : BOOLEAN

        do
            if not err then
                -- Initialize the ORB and BOA

                create argc
                argc.set_item (argument_count)
                orb := ORB_init (argc, argument_array, "mico-local-orb")
                boa := orb.BOA_init (argc, argument_array, "mico-local-boa")

                -- Now get a reference to the servant

                obj := orb.bind1 ("IDL:Account:1.0")

                -- And create a proxy for it

                proxy := Account_narrow (obj)

                -- Now we can use our account via the proxy

                create struct.make (101, 43, 1, "BEF")
                proxy.setDesiredCurrency ("BEF")
                proxy.deposit (struct)
                io.put_string ("%NDeposited ")
                io.put_string (struct_to_string (struct))
                io.new_line
                create struct.make (105, 48, 1, "LUF")
                proxy.withdraw (struct)
                io.put_string ("Withdrew  ")
                io.put_string (struct_to_string (struct))
                io.new_line
                struct := proxy.balance
                io.put_string ("Balance is ")
                io.put_string (struct_to_string (struct))
                io.new_line
            else
                io.put_string ("Client died%N")
            end

        rescue
            err:= true
            if last_exception /= void then
                last_exception.print_it
            else
                io.put_string (except.exception_trace)
                io.new_line
            end
            retry
        end
----------------------
feature { NONE }

    struct_to_string (str : AMOUNTSTRUCT) : STRING is

        do
            if str.sign = -1 then
                result := "-"
            else
                result := ""
            end
            result.append_integer (str.basicunits)
            if str.smallunits < 10 then
                result.append (".0")
            else
                result.extend ('.')
            end
            result.append_integer (str.smallunits)
            result.extend (' ')
            result.append (str.currency)
        end
----------------------

    except : EXCEPTIONS is

        once
            create result
        end

end -- class CLIENT









