note
	description: "[
		Summary description for {STRIPE_INVOICE}.

			See also: https://stripe.com/docs/api/invoices/line_item
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_INVOICE_LINE

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

			Precursor (j)

			if not j.is_empty then
				id := safe_string_8_item (j, "id", id)

				amount := natural_32_item (j, "amount")
				currency := string_8_item (j, "currency")
				description := string_32_item (j, "description")

				if attached {JSON_OBJECT} j.item ("period") as j_period then
					period_timestamps := [
							integer_32_item (j_period, "start"),
							integer_32_item (j_period, "end")
						]
				end
				quantity := natural_32_item (j, "quantity")

				subscription_id := string_8_item (j, "subscription")
				subscription_item_id := string_8_item (j, "subscription_item")

				type := string_8_item (j, "type")

				if attached {JSON_OBJECT} j.item ("plan") as j_plan then
					create plan.make_with_json (j_plan)
				end

				metadata := table_item (j, "metadata")
			end
		end

feature -- Access

	amount: NATURAL_32

	currency: detachable READABLE_STRING_8

	description: detachable READABLE_STRING_32

	quantity: NATURAL_32

	period_timestamps: detachable TUPLE [start_date, end_date: INTEGER]

	subscription_id,
	subscription_item_id: detachable READABLE_STRING_8

	type: detachable READABLE_STRING_8
			-- subscription or invoiceitem

	is_subscription_type: BOOLEAN
		do
			Result := attached type as t and then t.is_case_insensitive_equal ("subscription")
		end

	is_item_type: BOOLEAN
		do
			Result := attached type as t and then t.is_case_insensitive_equal ("invoiceitem")
		end

	plan: detachable STRIPE_PLAN

	metadata: detachable STRING_TABLE [detachable ANY]
			-- Set of key-value pairs that you can attach to an object.
			-- This can be useful for storing additional information about the object in a structured format.

end
