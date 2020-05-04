note
	description: "Summary description for {STRIPE_PAYMENT_VALIDATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_PAYMENT_VALIDATION

create
	make_from_subscription

feature {NONE} -- Initialization

	make_from_subscription (a_sub: STRIPE_SUBSCRIPTION; a_customer: STRIPE_CUSTOMER)
		require
			a_sub.has_id
			a_sub.is_active
		do
			subscription := a_sub
			customer := a_customer
		end

feature -- Access

	subscription: STRIPE_SUBSCRIPTION

	customer: STRIPE_CUSTOMER

	order_id: detachable IMMUTABLE_STRING_32

	metadata: detachable STRING_TABLE [detachable ANY]

feature -- Element change

	set_order_id (v: detachable READABLE_STRING_GENERAL)
		do
			if v = Void then
				order_id := Void
			else
				create order_id.make_from_string_general (v)
			end
		end

	import_metadata (tb: STRING_TABLE [detachable ANY])
		local
			l_metadata: like metadata
		do
			l_metadata := metadata
			if l_metadata = Void then
				create l_metadata.make_caseless (tb.count)
				metadata := l_metadata
			end
			across
				tb as ic
			loop
				l_metadata.force (ic.item, ic.key)
			end
		end

end
