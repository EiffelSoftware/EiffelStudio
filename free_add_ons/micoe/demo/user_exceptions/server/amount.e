class AMOUNT_IMPL
    -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
    -- the body of each routine and add any (private) attributes needed.

inherit
    AMOUNT_SKEL
        redefine
            make
        end;
    COMPARABLE
        undefine
            copy, is_equal
        end


creation
    make

feature

    make is

        do
            precursor
            basicunits := 0
            smallunits := 0
            sign       := 1
            currency   := "EUR"

        ensure then
            in_normal_form : in_normal_form
        end

    fromamountstruct (amnt : AMOUNTSTRUCT) is

        local
            pennies : INTEGER

        do
            pennies := amnt.sign * (100 * amnt.basicunits + amnt.smallunits)
            currency   := amnt.currency
            if pennies < 0 then
                sign    := -1
                pennies := - pennies
            else
                sign := 1
            end
            basicunits := pennies // 100
            smallunits := pennies \\ 100      

        ensure then
            in_normal_form : in_normal_form
        end

    toamountstruct : AMOUNTSTRUCT is

        do
            create result.make (basicUnits, smallUnits, sign, currency)
        end

    fromstring (amnt : STRING) is

        do
        end

    tostring : STRING is

        do
            if sign = -1 then
                result := "-"
            else
                result := ""
            end
            result.append_integer (basicunits)
            if smallunits < 10 then
                result.append (".0")
            else
                result.extend ('.')
            end
            result.append_integer (smallunits)
            result.extend (' ')
            result.append (currency)
        end

    infix "+" (other : like current) : like current is

        local
            amnt    : like current
            pennies : INTEGER

        do
            amnt    := other.internal_convert_to_currency (currency)
            pennies := amount_to_pennies + amnt.amount_to_pennies
            result  := amount_from_pennies (pennies)

        ensure
            result_in_normal_form : result.in_normal_form
        end

    plus (amount : AMOUNT) : AMOUNT is

        local
            amnt : like current

        do
            amnt   ?= amount
            result := current + amnt
        end

    infix "-" (other : like current) : like current is

        local
            amnt    : like current
            pennies : INTEGER

        do
            amnt    := other.internal_convert_to_currency (currency)
            pennies := amount_to_pennies - amnt.amount_to_pennies
            result  := amount_from_pennies (pennies)

        ensure
            result_in_normal_form : result.in_normal_form
        end

    minus (amount : AMOUNT) : AMOUNT is

        local
            amnt : like current

        do
            amnt   ?= amount
            result := current - amnt
        end

    infix "*" (factor : DOUBLE) : like current is

        local
            pennies : INTEGER
            math    : MATH

        do
            pennies := amount_to_pennies
            create math
            pennies := math.floor (pennies * factor + 0.5)
            result  := amount_from_pennies (pennies)
        end

    times (factor : DOUBLE) : AMOUNT is

        do
            result := current * factor
        end

    converttocurrency (targetcurrency : STRING) : AMOUNT is

        do
            result := internal_convert_to_currency (targetcurrency)
        end

    infix "<" (other : like current) : BOOLEAN is

        local
            amnt : like current

        do
            amnt    := other.internal_convert_to_currency (currency)
            result  := (amount_to_pennies < amnt.amount_to_pennies)
        end
----------------------
feature { AMOUNT_IMPL }

    basicunits : INTEGER
    smallunits : INTEGER
    sign       : INTEGER
    currency   : STRING
----------------------

    set_currency (new_currency : STRING) is

        do
            currency := new_currency
        end
----------------------

    amount_to_pennies : INTEGER is

        do
            result := sign * (100 * basicunits + smallunits)
        end
----------------------

    amount_from_pennies (pennies : INTEGER) : like current is

        local
            p, sgn, basic, small : INTEGER
            struct               : AMOUNTSTRUCT

        do
            if pennies < 0 then
                sgn := -1
                p   := -pennies
            else
                sgn := 1
                p   := pennies
            end
            basic := p // 100
            small := p \\ 100
            create struct.make (basic, small, sgn, currency)
            create result.make
            result.fromamountstruct (struct)
        end
----------------------

    internal_convert_to_currency (new_currency : STRING) : like current is

        local
            factor : DOUBLE

        do
            factor := conversion_rate (new_currency, currency)
            result := current * factor
            result.set_currency (new_currency)
        end
----------------------

    in_normal_form : BOOLEAN is

        do
            result := basicunits >= 0
                      and then
                      (smallunits >= 0 and then smallunits < 100)
                      and then 
                      (sign = 1 or else sign = -1)
        end
----------------------

    conversion_rate (tgt, src : STRING) : DOUBLE is

        local
            num, denom : DOUBLE

        do
            if equal (tgt, src) then
                result := 1.0
            else
                num   := convert_to_euro (tgt)
                denom := convert_to_euro (src)
                result := num / denom
            end
        end
----------------------

    convert_to_euro (other : STRING) : DOUBLE is

        do
            if equal (other, "EUR") then
                result := 1.0
            elseif european_rates.has (other) then
                result := european_rates.at (other)
            else
                -- We really should consult a database
                -- with the exchange rates of the day.
                result := 1.0
            end
        end
----------------------

    european_rates : DICTIONARY [DOUBLE, STRING] is

        once
            create result.make
            result.put (1.95583, "DEM")
            result.put (40.3399, "BEF")
            result.put (40.3399, "LUF")
            result.put (5.94573, "FIM")
            result.put (6.55957, "FRF")
            result.put (0.787564, "IEP")
            result.put (1936.27, "ITL")
            result.put (2.20371, "NLG")
            result.put (13.7603, "ATS")
            result.put (200.482, "PTE")
            result.put (166.386, "ESP") 
        end

end -- class AMOUNT_IMPL






