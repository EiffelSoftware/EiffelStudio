note
	description: "Summary description for {SSL_MODE_WITH_NONCE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_MODE_WITH_NONCE

feature -- Access

	nonce: detachable MANAGED_POINTER
			-- The value of the nonce for this mode as bytes.

end
