note
	description: "[
		Object representing cryptographic algorithms supported by OpenSSL like
		AES, Blowfish, Camellia, SEED, CAST-128, DES, IDEA, RC2, RC4, RC5, Triple DES, GOST 28147-89
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=OpenSSL algorithms", "src=https://en.wikipedia.org/wiki/OpenSSL#Algorithms", "protocol=uri"

deferred class
	SSL_ALGORITHM

feature -- Access

	key: STRING_8
			-- String representation.

	key_bytes: MANAGED_POINTER
			-- key represented as bytes.
		deferred
		end

	key_sizes: ARRAY [INTEGER]
			-- valid key sizes.
		deferred
		end

	key_size: INTEGER
			-- key size of the current algorithm.
		do
			Result := key_bytes.count * 8
		end

feature -- Status Report

	verify_key_size: BOOLEAN
			-- has the current algorithm a valid key size?
		do
			Result := key_sizes.has (key_size)
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
