class STANDALONE

inherit
    CORBA_GENERAL;
    ARGUMENTS

creation
    make

feature

    make is

        local
            orb     : ORB
            boa     : BOA
            servant : ACCOUNT
            proxy   : ACCOUNT
            argc    : INTEGER_REF

        do
            -- Initialize the ORB and BOA

            create argc
            argc.set_item (argument_count)
            orb := ORB_init (argc, argument_array, "mico-local-orb")
            boa := orb.BOA_init (argc, argument_array, "mico-local-boa")

            -- Now create an implementation object and a proxy for it

            create {ACCOUNT_IMPL} servant.make
            create {ACCOUNT_STUB} proxy.make_with_peer (servant)

            -- Now we can use our account via the proxy

            proxy.deposit (700)
            proxy.withdraw (250)
            io.put_string ("%NBalance is ")
            io.putint (proxy.balance)
            io.new_line
        end

end -- class STANDALONE
