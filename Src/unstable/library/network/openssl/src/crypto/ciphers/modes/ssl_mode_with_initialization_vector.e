note
	description: "Object representing a cipher mode with an initialization vector"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=SSL_MODE_WITH_INITIALIZATION_VECTOR", "src=https://cryptography.io/en/latest/hazmat/primitives/symmetric-encryption/?highlight=cipher.Mode#cryptography.hazmat.primitives.ciphers.modes.ModeWithInitializationVector", "protocol=uri"

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

	is_valid_iv_length (a_algo: SSL_ALGORITHM): BOOLEAN
		do
				-- Todo check if this is the right place to add this feature.
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
