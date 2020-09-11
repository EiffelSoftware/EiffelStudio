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

	append_iso_currency_as_sign_to (a_iso_currency: READABLE_STRING_8; a_output: STRING_32)
		require
			is_valid_iso_currency (a_iso_currency)
		do
			if attached iso_currency_as_sign (a_iso_currency) as c then
				a_output.append_character (c)
			else
				a_output.append_string_general (a_iso_currency)
			end
		ensure
			instance_free: class
		end

end
