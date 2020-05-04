note
	description: "Summary description for {STRIPE_PAYMENT_SUBSCRIPTION_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_PAYMENT_SUBSCRIPTION_ITEM

inherit
	STRIPE_PAYMENT_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_identifier: READABLE_STRING_GENERAL; a_plan: STRIPE_PLAN; a_quantity: like quantity)
		do
			create orig_identifier.make_from_string_general (a_identifier)
			quantity := a_quantity
			plan := a_plan
		end

feature -- Access

	plan: STRIPE_PLAN

	orig_identifier: IMMUTABLE_STRING_32

	identifier: IMMUTABLE_STRING_32
		do
			if plan.has_id then
				Result := plan.id
			else
				Result := orig_identifier
			end
		end

	currency: detachable IMMUTABLE_STRING_8

end
