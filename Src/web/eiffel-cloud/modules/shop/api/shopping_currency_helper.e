note
	description: "Helper functions for currencies (ISO, symbols, ...)"
	date: "$Date$"
	revision: "$Revision$"

class
	SHOPPING_CURRENCY_HELPER

feature -- Status report

	is_valid_iso_currency (a_iso_currency: READABLE_STRING_8): BOOLEAN
		local
			i,n: INTEGER
		do
			if a_iso_currency.count = 3 then
				Result := True
				from
					i := 1
					n := 3
				until
					i > n or not Result
				loop
					Result := a_iso_currency [i].is_alpha -- A-Z only
					i := i + 1
				end
			end
		ensure
			instance_free: class
		end

feature -- Conversion

	iso_currency_as_sign (a_iso_currency: READABLE_STRING_8): detachable CHARACTER_32
		do
			if a_iso_currency.is_case_insensitive_equal_general ("usd") then
				Result := {CHARACTER_32} '$'
			elseif a_iso_currency.is_case_insensitive_equal_general ("eur") then
				Result := {CHARACTER_32} '%/0x20AC/' -- EUR symbol
			end
		ensure
			instance_free: class
		end

end
