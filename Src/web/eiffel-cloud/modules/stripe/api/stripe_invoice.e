note
	description: "[
		Summary description for {STRIPE_INVOICE}.

			See also: https://stripe.com/docs/api/invoices/object
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_INVOICE

inherit
	STRIPE_OBJECT
		redefine
			make_with_json
		end

create
	make_with_json

feature {NONE} -- Initialization

	make_with_json (j: like json)
		do
			create id.make_empty
			create lines.make (0)

			Precursor (j)

			if not j.is_empty then
				id := safe_string_8_item (j, "id", id)

				customer_id := string_8_item (j, "customer")
				customer_email := string_8_item (j, "customer_email")

				amount_due := natural_32_item (j, "amount_due")
				amount_paid := natural_32_item (j, "amount_paid")
				amount_remaining := natural_32_item (j, "amount_remaining")

				currency := string_8_item (j, "currency")

				creation_timestamp := integer_32_item (j, "created")

				hosted_invoice_url := string_8_item (j, "hosted_invoice_url")
				invoice_pdf := string_8_item (j, "invoice_pdf")

				if
					attached {JSON_OBJECT} j.item ("lines") as j_lines and then
					attached {JSON_ARRAY} j_lines.item ("data") as j_data
				then
					across
						j_data as ic
					loop
						if attached {JSON_OBJECT} ic.item as j_line then
							lines.force (create {STRIPE_INVOICE_LINE}.make_with_json (j_line))
						end
					end
				end

				metadata := table_item (j, "metadata")
			end
		end

feature -- Access

	customer_id: detachable READABLE_STRING_8
	customer_email: detachable READABLE_STRING_8

	amount_due,
	amount_paid,
	amount_remaining: NATURAL_32

	currency: detachable READABLE_STRING_8

	creation_timestamp: INTEGER

	hosted_invoice_url,
	invoice_pdf: detachable READABLE_STRING_8

	lines: ARRAYED_LIST [STRIPE_INVOICE_LINE]

	metadata: detachable STRING_TABLE [detachable ANY]
			-- Set of key-value pairs that you can attach to an object.
			-- This can be useful for storing additional information about the object in a structured format.

end
