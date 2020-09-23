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
		local
			inv: like invoice
			cust: like customer
			pi: like payment_intent
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
			amount := integer_32_item (j, "amount")
			description := string_32_item (j, "description")

			receipt_url := string_8_item (j, "receipt_url")

			status := string_8_item (j, "status")

			if attached {JSON_OBJECT} j.item ("invoice") as j_invoice then
				create inv.make_with_json (j_invoice)
				invoice := inv
				invoice_id := inv.id
			else
				invoice_id := string_8_item (j, "invoice")
			end

			if attached {JSON_OBJECT} j.item ("customer") as j_customer then
				create cust.make_with_json (j_customer)
				customer := cust
				customer_id := cust.id
			else
				customer_id := string_8_item (j, "customer")
			end

			if attached {JSON_OBJECT} j.item ("payment_intent") as j_pi then
				create pi.make_with_json (j_pi)
				payment_intent := pi
				payment_intent_id := pi.id
			else
				payment_intent_id := string_8_item (j, "payment_intent")
			end
		end

feature -- Access

	paid: BOOLEAN

	amount: INTEGER_32

	currency: READABLE_STRING_8

	status: detachable READABLE_STRING_8

	description: detachable READABLE_STRING_32

	receipt_url: detachable READABLE_STRING_8

	billing_details: detachable BILLING_DETAILS

	invoice: detachable STRIPE_INVOICE
	invoice_id: detachable READABLE_STRING_8

	customer: detachable STRIPE_CUSTOMER
	customer_id: detachable READABLE_STRING_8

	payment_intent: detachable STRIPE_PAYMENT_INTENT
	payment_intent_id: detachable READABLE_STRING_8


end
