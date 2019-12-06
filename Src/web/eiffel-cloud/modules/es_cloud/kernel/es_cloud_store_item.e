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
		end

feature -- Access

	id: IMMUTABLE_STRING_32

	price: INTEGER

	cents_price: INTEGER

	currency: IMMUTABLE_STRING_8

feature -- Status report

	is_free: BOOLEAN
		do
			Result := price = 0 and then cents_price = 0
		end

feature -- Element change

	set_price (a_price: INTEGER; a_cents_price: INTEGER; a_currency: READABLE_STRING_8)
		do
			price := a_price
			cents_price := a_cents_price
			create currency.make_from_string (a_currency)
		end

end
