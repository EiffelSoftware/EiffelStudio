note
	description: "Summary description for {STRIPE_PAYMENT_ONETIME_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_PAYMENT_ONETIME_ITEM

inherit
	STRIPE_PAYMENT_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_identifier: READABLE_STRING_GENERAL; a_price_in_cents: NATURAL_32; a_currency: READABLE_STRING_8)
		do
			create identifier.make_from_string_general (a_identifier)
			set_price (a_price_in_cents, a_currency)
			quantity := 1
		end

feature -- Access

	price_in_cents: NATURAL_32

	identifier: IMMUTABLE_STRING_32

	currency: IMMUTABLE_STRING_8

	title:  detachable IMMUTABLE_STRING_32

feature -- Element change

	set_price (a_price_in_cents: NATURAL_32; a_currency: READABLE_STRING_8)
		do
			price_in_cents := a_price_in_cents
			create currency.make_from_string (a_currency)
		end

	set_title (a_title: READABLE_STRING_GENERAL)
		do
			create title.make_from_string_general (a_title)
		end

end
