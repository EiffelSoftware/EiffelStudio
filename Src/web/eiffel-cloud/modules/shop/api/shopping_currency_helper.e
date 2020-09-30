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

	price_in_cents_as_string (a_price_in_cents: NATURAL_32; a_iso_currency: READABLE_STRING_8): STRING_32
		local
			u,c: NATURAL_32
		do
			u := a_price_in_cents // 100
			c := a_price_in_cents \\ 100
			Result := price_as_string (u, c, a_iso_currency)
		ensure
			instance_free: class
		end

	price_as_string (a_price, a_cents: NATURAL_32; a_iso_currency: READABLE_STRING_8): STRING_32
		do
			create Result.make (10)
			Result.append_natural_32 (a_price)
			if a_cents > 0 then
				Result.append_character ('.')
				if a_cents <= 9 then
					Result.append_natural_32 (0)
				end
				Result.append_natural_32 (a_cents)
			end

			if attached iso_currency_as_sign (a_iso_currency) as ch then
				Result.prepend_character (ch)
			else
				Result.append_character (' ')
				Result.append_string_general (a_iso_currency.as_upper)
			end
		ensure
			instance_free: class
		end

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
