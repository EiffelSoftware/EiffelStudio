note
	description: "Summary description for {PAYMENT_INTENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PAYMENT_INTENT

inherit
	STRIPE_OBJECT
		redefine
			make_with_json
		end

create
	make_empty,
	make_with_json

feature {NONE} -- Initialization

	make_with_json (j: like json)
		do
			Precursor (j)
			id := safe_string_8_item (j, "id", "")
			client_secret := safe_string_8_item (j, "client_secret", "")
			currency := safe_string_8_item (j, "currency", "usd")
			if attached {JSON_NUMBER} j.item ("amount") as num then
				amount := num.integer_64_item.to_integer
			elseif attached j.string_item ("amount") as s then
				amount := s.item.to_integer
			else
				amount := 0
			end
		end

feature -- Access

	client_secret: IMMUTABLE_STRING_8

	amount: INTEGER_32

	currency: READABLE_STRING_8

feature -- Element change

	set_client_secret (v: READABLE_STRING_8)
		do
			client_secret := v
		end

end
