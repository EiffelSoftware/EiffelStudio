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
            proxy  : STRICTACCOUNT
            struct : AMOUNTSTRUCT
            argc   : INTEGER_REF
            err    : BOOLEAN
            ovdr   : OVERDRAFT

        do
            if not err then
                -- Initialize the ORB and BOA

                create argc
                argc.set_item (argument_count)
                orb := ORB_init (argc, argument_array, "mico-local-orb")
                boa := orb.BOA_init (argc, argument_array, "mico-local-boa")

                -- Now get a reference to the servant

                obj := orb.bind1 ("IDL:StrictAccount:1.0")

                -- And create a proxy for it

                proxy := StrictAccount_narrow (obj)

                -- Now we can use our account via the proxy


                proxy.setDesiredCurrency ("BEF")
                create struct.make (2, 0, 1, "BEF")
                proxy.setLimit (struct)
                struct.make (101, 43, 1, "BEF")
                proxy.deposit (struct)
                io.put_string ("%NJust deposited     ")
                io.put_string (struct_to_string (struct))
                io.new_line
                struct.make (105, 48, 1, "LUF")
                io.put_string ("Trying to withdraw ")
                io.put_string (struct_to_string (struct))
                io.new_line
                proxy.withdraw (struct)
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
                ovdr := Overdraft_narrow (last_exception)
                if ovdr /= void then
                    report_overdraft (ovdr)
                else
                    last_exception.print_it
                end
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

    report_overdraft (o : OVERDRAFT) is

        do
            io.put_string ("Shame on you! %
                           %You tried to overdraw your account%N")
            io.put_string ("credit line:          ")
            io.put_string (struct_to_string (o.limit))
            io.put_string ("%Ncurrent balance:      ")
            io.put_string (struct_to_string (o.balance))
            io.put_string ("%Nattempted withdrawal: ")
            io.put_string (struct_to_string (o.attemptedWithdrawal))
            io.new_line
        end
----------------------

    except : EXCEPTIONS is

        once
            create result
        end

end -- class CLIENT









