note
	description: "Summary description for {ES_CLOUD_STORE_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_STORE_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_id: READABLE_STRING_GENERAL)
		do
			create id.make_from_string_general (a_id)
			currency := "usd"
			onetime_month_duration := 12
		end

feature -- Access

	id: IMMUTABLE_STRING_32

	name: detachable IMMUTABLE_STRING_32

	title: detachable IMMUTABLE_STRING_32

	price: NATURAL_32

	cents_price: NATURAL_32

	currency: IMMUTABLE_STRING_8

	interval: detachable IMMUTABLE_STRING_8

	onetime_month_duration: NATURAL

	is_onetime: BOOLEAN
		do
			Result := not attached interval as l_interval or else
					l_interval.is_case_insensitive_equal_general ("onetime")
		end

	is_yearly: BOOLEAN
		do
			Result := attached interval as l_interval and then
					l_interval.is_case_insensitive_equal_general ("year")
		end

	is_monthly: BOOLEAN
		do
			Result := attached interval as l_interval and then
					l_interval.is_case_insensitive_equal_general ("month")
		end

	is_weekly: BOOLEAN
		do
			Result := attached interval as l_interval and then
					l_interval.is_case_insensitive_equal_general ("week")
		end

	is_daily: BOOLEAN
		do
			Result := attached interval as l_interval and then
					l_interval.is_case_insensitive_equal_general ("day")
		end

	price_as_string: STRING_32
		do
			create Result.make (10)
			Result.append_natural_32 (price)
			if cents_price > 0 then
				Result.append_character ('.')
				if cents_price <= 9 then
					Result.append_natural_32 (0)
				end
				Result.append_natural_32 (cents_price)
			end
			Result.append_character (' ')
			if currency.is_case_insensitive_equal_general ("usd") then
				Result.append_character ('$')
			elseif currency.is_case_insensitive_equal_general ("eur") then
				Result.append_character ({CHARACTER_32} '%/8364/')
			else
				Result.append_string_general (currency.as_upper)
			end
		end

feature -- Status report

	is_free: BOOLEAN
		do
			Result := price = 0 and then cents_price = 0
		end

feature -- Element change

	set_title (a_title: detachable READABLE_STRING_GENERAL)
		do
			if a_title = Void then
				title := Void
			else
				create title.make_from_string_general (a_title)
			end
		end

	set_name (a_name: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (a_name)
		end

	set_price (a_price: NATURAL_32; a_cents_price: NATURAL_32; a_currency: READABLE_STRING_8; a_interval: detachable READABLE_STRING_GENERAL)
		do
			price := a_price
			cents_price := a_cents_price
			create currency.make_from_string (a_currency)
			if a_interval /= Void then
				interval := a_interval.to_string_8.as_lower
			else
				interval := Void -- onetime
			end
		end

	set_onetime_month_duration (a_nb: NATURAL)
		require
			is_onetime
		do
			onetime_month_duration := a_nb
		end

end
