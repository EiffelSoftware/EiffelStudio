note
	description: "Object representing a cipher mode with a nonce."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=SSL_MODE_WITH_NONCE", "src=https://cryptography.io/en/latest/hazmat/primitives/symmetric-encryption/?highlight=cipher.Mode#cryptography.hazmat.primitives.ciphers.modes.ModeWithNonce", "protocol=uri"

deferred class
	SSL_MODE_WITH_NONCE

feature -- Access

	nonce: detachable MANAGED_POINTER
			-- The value of the nonce for this mode as bytes.

;note
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
