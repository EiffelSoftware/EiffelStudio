note
	description: "Summary description for {PAYMENT_INTENT_SUCCEEDED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PAYMENT_INTENT_SUCCEEDED

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
			l_charges: ARRAYED_LIST [STRIPE_PAYMENT_CHARGE]
		do
			Precursor (j)
			create l_charges.make (1)
			charges := l_charges
			currency := "usd" -- Default
			id := safe_string_8_item (j, "id", "")
			if attached {JSON_OBJECT} (j @ "data" @ "object") as jobj then
				if attached {JSON_NUMBER} jobj.number_item ("amount") as j_amount then
					amount := j_amount.integer_64_item.to_integer_32
				end
				if attached {JSON_STRING} jobj.string_item ("currency") as j_currency then
					currency := j_currency.unescaped_string_8
				end
				if attached {JSON_STRING} jobj.string_item ("status") as j_status then
					if j_status.same_caseless_string ("succeeded") then
						status := status_succeeded
					else
						status := 0
					end
				end

				if attached {JSON_ARRAY} (jobj @ "charges" @ "data") as j_data_array then
					across
						j_data_array as ic
					loop
						if attached stripe_charge (ic.item) as l_charge then
							l_charges.force (l_charge)
						end
					end
				end
			end
		end

feature -- Access

	amount: INTEGER
			-- Amount in cents.

	currency: IMMUTABLE_STRING_8

	status: NATURAL_8

	charges: LIST [STRIPE_PAYMENT_CHARGE]

feature -- Constants

	status_succeeded: NATURAL_8 = 1

feature -- Factory

	stripe_charge (j: JSON_VALUE): detachable STRIPE_PAYMENT_CHARGE
		do
			if attached {JSON_OBJECT} j as j_charge then
				create Result.make_with_json (j_charge)
			end
		end

end
