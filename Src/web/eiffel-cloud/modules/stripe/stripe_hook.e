note
	description: "Summary description for {STRIPE_HOOK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STRIPE_HOOK

inherit
	CMS_HOOK

feature -- Hook

	prepare_payment (p: STRIPE_PAYMENT)
		deferred
		end

end
