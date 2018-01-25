note
	description: "Summary description for {SSL_AEAD_CIPHER_CONTEXT}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_AEAD_CIPHER_CONTEXT

feature -- Aditional data

	authenticate_additional_data(a_data: MANAGED_POINTER)
			-- Authenticates the provided bytes.
		deferred
		end

end
