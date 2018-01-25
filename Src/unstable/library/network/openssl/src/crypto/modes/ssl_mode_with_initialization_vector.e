note
	description: "Summary description for {SSL_MODE_WITH_INITIALIZATION_VECTOR}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_MODE_WITH_INITIALIZATION_VECTOR

feature -- Access

	initialization_vector: detachable MANAGED_POINTER
			--  The value of the initialization vector for this mode as bytes.
		note
			option: stable
		attribute
		end

feature -- Status Report

	check_iv_length (a_algo: SSL_ALGORITHM): BOOLEAN
		do
			if
				attached {SSL_BLOCK_CIPHER_ALGORITHM} a_algo as l_algo and then
				attached initialization_vector as l_vector and then
				l_vector.count * 8 /= l_algo.block_size
			then
				Result := False
					-- Invalid IV size.
			else
				Result := True
			end
		end


end
