class ACCOUNT_IMPL
    -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
    -- the body of each routine and add any (private) attributes needed.

inherit
    STRICTACCOUNT_SKEL
        redefine
            make
        end


creation
    make

feature

    make is

        do
            precursor
            create current_balance.make
        end

    setDesiredCurrency (currency : STRING) is

        do
            current_balance ?= current_balance.convertToCurrency (currency)
        end

    setLimit (limit : AMOUNTSTRUCT) is

        do
            limit.set_sign (-limit.sign)
            create credit_line.make
            credit_line.fromAmountStruct (limit)
        end

    deposit (amount : AMOUNTSTRUCT) is

        local
            amnt : AMOUNT_IMPL

        do
            create amnt.make
            amnt.fromAmountStruct (amount)
            current_balance := current_balance + amnt
        end

    withdraw (amount : AMOUNTSTRUCT) is

        local
            amnt : AMOUNT_IMPL

        do
            create amnt.make
            amnt.fromAmountStruct (amount)
            current_balance := current_balance - amnt
        end

    balance : AMOUNTSTRUCT is

        do
            result := current_balance.toAmountStruct
        end
----------------------
feature { NONE }

    current_balance : AMOUNT_IMPL
    credit_line     : AMOUNT_IMPL

end -- class ACCOUNT_IMPL







