note
	description: "Summary description for {SSL_AEAD_ENCRYPTION_CONTEXT}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_AEAD_DECRYPTION_CONTEXT


feature -- Finalize

    finalize_with_tag (a_tag: MANAGED_POINTER): MANAGED_POINTER
			--	Returns the results of processing the final block as bytes and allows
			--	delayed passing of the authentication tag.
		deferred
		end


end
