note
	description: "Summary description for {STRIPE_PAYMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_PAYMENT

create
	make

feature {NONE} -- Initialization

	make (a_category: READABLE_STRING_GENERAL; a_product: READABLE_STRING_GENERAL)
		do
			create category.make_from_string_general (a_category)
			create product_name.make_from_string_general (a_product)
		end

feature -- Status

	is_prepared: BOOLEAN

	mark_prepared
		do
			is_prepared := True
		end

feature -- Access

	category: IMMUTABLE_STRING_32

	product_name: IMMUTABLE_STRING_32

	price_in_cents: INTEGER

	price_text: STRING
		local
			i: INTEGER
		do
			create Result.make_empty
			if currency.is_case_insensitive_equal_general ("usd") then
				Result.extend ('$')
			end
			i := price_in_cents // 100
			Result.append (i.out)
			i := (price_in_cents \\ 100).abs
			if i /= 0 then
				Result.extend ('.')
				if i < 10 then
					Result.extend ('0')
				end
				Result.append (i.out)
			end
			if not currency.is_case_insensitive_equal_general ("usd") then
				Result.extend (' ')
				Result.append (currency.as_upper)
			end
		end

	currency: IMMUTABLE_STRING_8
		do
			Result := internal_currency
			if Result = Void then
				Result := default_currency
			end
		end

	default_currency: IMMUTABLE_STRING_8
		once
			Result := "usd"
		end

feature -- Access: optional

	business_name: detachable IMMUTABLE_STRING_32

	title: detachable IMMUTABLE_STRING_32

	customer_name: detachable IMMUTABLE_STRING_32

	customer_email: detachable IMMUTABLE_STRING_8

	customer_user: detachable CMS_USER

feature -- Access: default

	title_or_product_name: IMMUTABLE_STRING_32
		do
			if attached title as t then
				Result := t
			else
				Result := product_name
			end
		end

feature -- Access: internal

	internal_currency: detachable IMMUTABLE_STRING_8

feature -- Element change

	set_price (a_price_in_cents: INTEGER; a_currency: READABLE_STRING_8)
		do
			price_in_cents := a_price_in_cents
			create internal_currency.make_from_string (a_currency)
		end

	set_title (a_title: READABLE_STRING_GENERAL)
		do
			create title.make_from_string_general (a_title)
		end

	set_business_name (a_name: READABLE_STRING_GENERAL)
		do
			create business_name.make_from_string_general (a_name)
		end

	set_customer_name (a_name: READABLE_STRING_GENERAL)
		do
			create customer_name.make_from_string_general (a_name)
		end

	set_customer_email (v: detachable READABLE_STRING_8)
		do
			if v = Void then
				customer_email := Void
			else
				customer_email := v
			end
		end

end
