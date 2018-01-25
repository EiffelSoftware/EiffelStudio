note
	description: "Summary description for {SSL_MODE_WITH_TWEAK}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_MODE_WITH_TWEAK

feature -- Access

	tweak: detachable MANAGED_POINTER
			-- The value of the tweak for this mode as bytes.
end
