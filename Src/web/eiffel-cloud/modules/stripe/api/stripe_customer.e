note
	description: "[
		Summary description for {STRIPE_CUSTOMER}.

			See also: https://stripe.com/docs/api/customers/object
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_CUSTOMER

inherit
	STRIPE_OBJECT
		redefine
			make_with_json
		end

create
	make_with_email,
	make_with_json

feature {NONE} -- Initialization

	make_with_email (a_email: READABLE_STRING_8)
		do
			make_empty
			email := a_email
		end

	make_with_json (j: like json)
		do
			create id.make_empty

			Precursor (j)


				--{
				--  "id": "cus_H9Hd0D3f7UZIO9",
				--  "object": "customer",
				--  "address": null,
				--  "balance": 0,
				--  "created": 1587625298,
				--  "currency": "usd",
				--  "default_source": null,
				--  "delinquent": false,
				--  "description": null,
				--  "discount": null,
				--  "email": null,
				--  "invoice_prefix": "59B0082",
				--  "invoice_settings": {
				--    "custom_fields": null,
				--    "default_payment_method": null,
				--    "footer": null
				--  },
				--  "livemode": false,
				--  "metadata": {},
				--  "name": null,
				--  "next_invoice_sequence": 1,
				--  "phone": null,
				--  "preferred_locales": [],
				--  "shipping": null,
				--  "sources": {
				--    "object": "list",
				--    "data": [],
				--    "has_more": false,
				--    "url": "/v1/customers/cus_H9Hd0D3f7UZIO9/sources"
				--  },
				--  "subscriptions": {
				--    "object": "list",
				--    "data": [],
				--    "has_more": false,
				--    "url": "/v1/customers/cus_H9Hd0D3f7UZIO9/subscriptions"
				--  },
				--  "tax_exempt": "none",
				--  "tax_ids": {
				--    "object": "list",
				--    "data": [],
				--    "has_more": false,
				--    "url": "/v1/customers/cus_H9Hd0D3f7UZIO9/tax_ids"
				--  }
				--}

			if not j.is_empty then
				id := safe_string_8_item (j, "id", id)
				if attached {JSON_OBJECT} j.object_item ("address") as j_address then
					create address.make_with_json (j_address)
				end
				email := string_8_item (j, "email")
				name := string_32_item (j, "name")
				description := string_32_item (j, "description")
				phone := string_8_item (j, "phone")
				if attached {JSON_STRING} (j / "invoice_settings" / "default_payment_method") as j_payment_method then
					set_default_payment_method_id (j_payment_method.unescaped_string_8)
				end
				if attached {JSON_ARRAY} (j / "subscriptions" / "data") as j_arr then
					subscriptions := {JSON_OBJECT} / (j / "subscriptions")
				end
				metadata := table_item (j, "metadata")
			end
		end

feature -- Access

	email: detachable READABLE_STRING_8

	name: detachable READABLE_STRING_32

	address: detachable STRIPE_ADDRESS assign set_address

	description: detachable READABLE_STRING_32
			-- Associated plan the customer is subscribed to.
			-- Only set if the subscription contains a single plan.	

	phone: detachable READABLE_STRING_8

	payment_method_id: detachable READABLE_STRING_8
		do
			if attached invoice_settings as l_invoice_settings then
				Result := l_invoice_settings.default_payment_method_id
			end
		end

	invoice_settings: detachable TUPLE [custom_fields: detachable JSON_VALUE; default_payment_method_id: detachable READABLE_STRING_8; footer: detachable READABLE_STRING_32]

	subscriptions: detachable JSON_OBJECT
--	subscriptions: detachable LIST [STRIPE_SUBSCRIPTION]

	metadata: detachable STRING_TABLE [detachable ANY]
			-- Set of key-value pairs that you can attach to an object.
			-- This can be useful for storing additional information about the object in a structured format.

feature -- Element change

	set_email (v: READABLE_STRING_8)
		do
			email := v
		end

	set_name (v: READABLE_STRING_GENERAL)
		do
			name := v.to_string_32
		end

	set_description (v: READABLE_STRING_GENERAL)
		do
			description := v.to_string_32
		end

	set_default_payment_method_id (a_payment_method_id: READABLE_STRING_8)
		do
			invoice_settings := [Void, a_payment_method_id, Void]
		end

	set_address (add: like address)
		do
			address := add
		end

	set_phone (p: like phone)
		do
			phone := p
		end

end

