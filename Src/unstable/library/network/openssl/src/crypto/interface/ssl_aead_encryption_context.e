note
	description: "Summary description for {SSL_AEAD_ENCRYPTION_CONTEXT}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_AEAD_ENCRYPTION_CONTEXT

feature -- Tag

	tag: detachable MANAGED_POINTER
			-- Returns tag bytes. This is only available after encryption is finalized.
		deferred
		end
end
