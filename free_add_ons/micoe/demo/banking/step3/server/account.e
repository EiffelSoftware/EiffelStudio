class ACCOUNT_IMPL

inherit
    ACCOUNT_SKEL
        redefine
            make
        end

creation
    make

feature

    make is

        do
            precursor -- don't forget this!
            current_balance := 0
        end

    deposit (amount : INTEGER) is

        do
            current_balance := current_balance + amount
        end

    withdraw (amount : INTEGER) is

        do
            current_balance := current_balance - amount
        end

    balance : INTEGER is

        do
            result := current_balance
        end

feature { NONE }

    current_balance : INTEGER

end -- class ACCOUNT_IMPL
