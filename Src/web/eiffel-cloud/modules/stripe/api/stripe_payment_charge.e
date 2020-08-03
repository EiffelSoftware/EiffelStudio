note
	description: "Summary description for {PAYMENT_CHARGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_PAYMENT_CHARGE

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
			currency := "usd"
			Precursor (j)

			if attached {JSON_OBJECT} j.item ("billing_details") as jv then
				create billing_details.make_with_json (jv)
			end
			if attached j.boolean_item ("paid") as b then
				paid := b.item
			end
			currency := safe_string_8_item (j, "currency", currency)
			if attached {JSON_NUMBER} j.item ("amount") as num then
				amount := num.integer_64_item.to_integer
			elseif attached j.string_item ("amount") as s then
				amount := s.item.to_integer
			else
				amount := 0
			end

			receipt_url := string_8_item (j, "receipt_url")
		end

feature -- Access

	paid: BOOLEAN

	amount: INTEGER_32

	currency: READABLE_STRING_8

	receipt_url: detachable READABLE_STRING_8

	billing_details: detachable BILLING_DETAILS


end
