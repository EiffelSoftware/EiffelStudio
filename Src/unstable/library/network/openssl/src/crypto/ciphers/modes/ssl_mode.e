note
	description: "Object representing modes that can be used for OpenSSL crypto algorithms"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=OpenSSL modes", "src=https://wiki.openssl.org/index.php/Manual:Des_modes(3)", "protocol=uri"
	EIS: "name=SSL_MODE", "src=https://cryptography.io/en/latest/hazmat/primitives/symmetric-encryption/?highlight=cipher.Mode#cryptography.hazmat.primitives.ciphers.modes.Mode", "protocol=uri"

deferred class
	SSL_MODE

feature
	name: STRING
			-- name of the mode like `ECB`, 'GCM'.
		deferred
		end

	is_valid_for_algorithm (a_algo: SSL_ALGORITHM): BOOLEAN
			--  Checks that all the necessary invariants of this mode, algorithm `a_algo`
        	--	combination are met.
		deferred
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
