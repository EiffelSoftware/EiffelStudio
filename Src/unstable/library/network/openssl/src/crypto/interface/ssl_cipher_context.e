note
	description: "Summary description for {SSL_CIPHER_CONTEXT}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_CIPHER_CONTEXT

feature -- Update

	update (a_data: MANAGED_POINTER): MANAGED_POINTER
			-- Processes the provided bytes through the cipher and returns the results as bytes.
		deferred
		end

   update_into(a_data, a_buf: MANAGED_POINTER): INTEGER
			-- Processes the provided bytes and writes the resulting data into the
			-- provided buffer. Returns the number of bytes written.
		deferred
		end
		
feature -- Finalize

   finalize: MANAGED_POINTER
			-- Returns the results of processing the final block as bytes.
		deferred
		end

end
