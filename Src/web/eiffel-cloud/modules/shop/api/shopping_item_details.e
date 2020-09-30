note
	description: "Summary description for {SHOPPING_ITEM_DETAILS}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHOPPING_ITEM_DETAILS

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			currency := "usd"
			set_onetime
		end

feature -- Access

	price: NATURAL_32

	cents_price: NATURAL_32

	currency: IMMUTABLE_STRING_8

	price_as_string: STRING_32
		do
			Result := {SHOPPING_CURRENCY_HELPER}.price_as_string (price, cents_price, currency)
		end

	price_as_iso_string: STRING_8
		do
			create Result.make (10)
			Result.append_natural_32 (price)
			if cents_price > 0 then
				Result.append_character ('.')
				if cents_price <= 9 then
					Result.append_integer (0)
				end
				Result.append_natural_32 (cents_price)
			end
			Result.append_character (' ')
			Result.append_string_general (currency)
		end

	title: detachable READABLE_STRING_32

feature -- Interval types

	interval_type: NATURAL_8
			-- onetime, daily, ...,  monthly, yearly.

	interval_count: NATURAL_8
			-- interval quantity.
			-- note: 3 + monthly -> every 3 months.

	is_onetime: BOOLEAN
		do
			Result := interval_type = interval_type_onetime
		ensure
			Result implies interval_count <= 1
		end

	is_daily: BOOLEAN
		do
			Result := interval_type = interval_type_daily
		end

	is_weekly: BOOLEAN
		do
			Result := interval_type = interval_type_weekly
		end

	is_monthly: BOOLEAN
		do
			Result := interval_type = interval_type_monthly
		end

	is_yearly: BOOLEAN
		do
			Result := interval_type = interval_type_yearly
		end

feature -- Constants

	interval_type_onetime: NATURAL_8 = 1
	interval_type_daily: NATURAL_8 = 2
	interval_type_weekly: NATURAL_8 = 3
	interval_type_monthly: NATURAL_8 = 4
	interval_type_yearly: NATURAL_8 = 5

feature -- Query

	price_in_cents: NATURAL_32
		do
			Result := price * 100 + cents_price
		end

feature -- Status report

	is_free: BOOLEAN
		do
			Result := price = 0 and then cents_price = 0
		end

feature -- Element change

	set_price_in_cents (a_price_in_cents: NATURAL_32; a_currency: READABLE_STRING_8)
		local
			p,c: NATURAL_32
		do
			c := a_price_in_cents \\ 100
			p := a_price_in_cents // 100
			set_price (p, c, a_currency)
		ensure
			price_in_cents = a_price_in_cents
		end

	set_price (a_price: NATURAL_32; a_cents_price: NATURAL_32; a_currency: READABLE_STRING_8)
		do
			price := a_price
			cents_price := a_cents_price
			create currency.make_from_string (a_currency)
		end

	set_onetime
		do
			interval_type := interval_type_onetime
			interval_count := 1
		ensure
			is_onetime
		end

	set_daily (a_count: NATURAL_8)
		do
			interval_type := interval_type_daily
			interval_count := a_count
		ensure
			is_daily
		end

	set_weekly (a_count: NATURAL_8)
		do
			interval_type := interval_type_weekly
			interval_count := a_count
		ensure
			is_weekly
		end

	set_monthly (a_count: NATURAL_8)
		do
			interval_type := interval_type_monthly
			interval_count := a_count
		ensure
			is_monthly
		end

	set_yearly (a_count: NATURAL_8)
		do
			interval_type := interval_type_yearly
			interval_count := a_count
		ensure
			is_yearly
		end

	set_title (s: detachable READABLE_STRING_GENERAL)
		do
			if s = Void then
				title := Void
			else
				title := s.to_string_32
			end
		end

end
