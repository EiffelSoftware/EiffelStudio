note
	description: "Summary description for {STRIPE_PAYMENT_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STRIPE_PAYMENT_ITEM

feature -- Access

	identifier: IMMUTABLE_STRING_32
		deferred
		end

	quantity: NATURAL_32

end
