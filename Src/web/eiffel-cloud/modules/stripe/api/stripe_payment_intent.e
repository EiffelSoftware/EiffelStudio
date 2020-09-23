note
	description: "[
		Summary description for {STRIPE_PAYMENT_INTENT}.

			See also: https://stripe.com/docs/api/payment_intents/object
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_PAYMENT_INTENT

inherit
	STRIPE_OBJECT
		redefine
			make_with_json
		end

create
	make_with_json

feature {NONE} -- Initialization


	make_with_json (j: like json)
		local
			l_invoice: STRIPE_INVOICE
			cust: STRIPE_CUSTOMER
			l_charges: like charges
		do
			create id.make_empty
			client_secret := ""
			currency := "USD"

				-- Default values

			status := status_canceled

			Precursor (j)
				--{
				--  "id": "pi_1FgUamKIFMc3UyxSB3NnGCZW",
				--  "object": "payment_intent",
				--  "amount": 1000,
				--  "amount_capturable": 0,
				--  "amount_received": 0,
				--  "application": null,
				--  "application_fee_amount": null,
				--  "canceled_at": null,
				--  "cancellation_reason": null,
				--  "capture_method": "automatic",
				--  "charges": {
				--    "object": "list",
				--    "data": [],
				--    "has_more": false,
				--    "url": "/v1/charges?payment_intent=pi_1FgUamKIFMc3UyxSB3NnGCZW"
				--  },
				--  "client_secret": "pi_1FgUamKIFMc3UyxSB3NnGCZW_secret_9EbdRmmbPfnZ7ZnO5nTh46ljb",
				--  "confirmation_method": "automatic",
				--  "created": 1574161796,
				--  "currency": "usd",
				--  "customer": null,
				--  "description": null,
				--  "invoice": null,
				--  "last_payment_error": null,
				--  "livemode": false,
				--  "metadata": {},
				--  "next_action": null,
				--  "on_behalf_of": null,
				--  "payment_method": null,
				--  "payment_method_options": {
				--    "card": {
				--      "installments": null,
				--      "request_three_d_secure": "automatic"
				--    }
				--  },
				--  "payment_method_types": [
				--    "card"
				--  ],
				--  "receipt_email": null,
				--  "review": null,
				--  "setup_future_usage": null,
				--  "shipping": null,
				--  "statement_descriptor": null,
				--  "statement_descriptor_suffix": null,
				--  "status": "requires_payment_method",
				--  "transfer_data": null,
				--  "transfer_group": null
				--}			

			if not j.is_empty then
				id := safe_string_8_item (j, "id", id)
				client_secret := safe_string_8_item (j, "client_secret", client_secret)
				if attached {JSON_OBJECT} j.item ("customer") as j_customer then
					create cust.make_with_json (j_customer)
					customer := cust
					customer_id := cust.id
				else
					customer_id := string_32_item (j, "customer")
				end

				if attached {JSON_ARRAY} (j @ "charges" @ "data") as j_data_array then
					create l_charges.make (1)
					charges := l_charges
					across
						j_data_array as ic
					loop
						if attached {JSON_OBJECT} ic.item as j_charge then
							l_charges.force (create {STRIPE_PAYMENT_CHARGE}.make_with_json (j_charge))
						end
					end
				end

				if attached {JSON_OBJECT} j.item ("invoice") as j_invoice then
					create l_invoice.make_with_json (j_invoice)
					invoice := l_invoice
					invoice_id := l_invoice.id
				else
					invoice_id := string_8_item (j, "invoice")
				end

				status := safe_string_8_item (j, "status", status)
				amount := natural_32_item (j, "amount")
				currency := safe_string_8_item (j, "currency", currency)
				receipt_email := string_8_item (j, "receipt_email")
				metadata := table_item (j, "metadata")
				in_livemode := boolean_item (j, "livemode", False)
			end
		end

feature -- Access

	amount: NATURAL_32
			-- Amount intended to be collected by this PaymentIntent.
			-- A positive integer representing how much to charge in the smallest currency unit
			-- (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency).
			-- The minimum amount is $0.50 US or equivalent in charge currency.
			-- The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).

	charges: detachable ARRAYED_LIST [STRIPE_PAYMENT_CHARGE]
			-- List of charges items.

	client_secret: READABLE_STRING_8
			-- The client secret of this PaymentIntent. Used for client-side retrieval using a publishable key.
			-- The client secret can be used to complete a payment from your frontend.
			--	It should not be stored, logged, embedded in URLs, or exposed to anyone other than the customer.
			--	Make sure that you have TLS enabled on any page that includes the client secret.
			--  Refer to stripe.com docs to accept a payment and learn about how client_secret should be handled.

	currency: READABLE_STRING_8
			-- Three-letter ISO currency code, in lowercase. Must be a supported currency.

	customer: detachable STRIPE_CUSTOMER
	customer_id: detachable READABLE_STRING_32
			-- ID of the customer who owns the payment.

	invoice_id: detachable READABLE_STRING_8
			-- ID of the invoice that created this PaymentIntent, if it exists.

	invoice: detachable STRIPE_INVOICE
			-- Invoice that created this PaymentIntent, if it exists.

	metadata: detachable STRING_TABLE [detachable ANY]
			-- Set of key-value pairs that you can attach to an object.
			-- This can be useful for storing additional information about the object in a structured format.

	receipt_email: detachable READABLE_STRING_8
			-- Email address that the receipt for the resulting payment will be sent to.			

	status: READABLE_STRING_8
			-- Status of this PaymentIntent,
			-- one of requires_payment_method, requires_confirmation, requires_action, processing,
			--		  requires_capture, canceled, or succeeded.
			-- Read more about each PaymentIntent

feature -- Status

	succeeded: BOOLEAN
		do
			Result := status.is_case_insensitive_equal_general (status_succeeded)
		end

feature -- Constants
	status_requires_payment_method: STRING = "requires_payment_method"
	status_requires_confirmation: STRING = "requires_confirmation"
	status_requires_action: STRING = "requires_action"
	status_processing: STRING = "processing"
	status_requires_capture: STRING = "requires_capture"
	status_canceled: STRING = "canceled"
	status_succeeded: STRING = "succeeded"

end
