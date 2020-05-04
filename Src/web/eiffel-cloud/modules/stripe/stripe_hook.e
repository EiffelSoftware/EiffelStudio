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

	validate_payment (a_validation: STRIPE_PAYMENT_VALIDATION)
		deferred
		end

end
