note
	description: "Object representing a cipher mode with an authentication tag."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=SSL_MODE_WITH_AUTHENTICATION_TAG", "src=https://cryptography.io/en/latest/hazmat/primitives/symmetric-encryption/?highlight=cipher.Mode#cryptography.hazmat.primitives.ciphers.modes.ModeWithAuthenticationTag", "protocol=uri"

class
	SSL_MODE_WITH_AUTHENTICATION_TAG

feature -- Access

	tag: detachable MANAGED_POINTER
			-- The value of the tag (bytes) supplied to the constructor of this mode.
		note
			option: stable
		attribute
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
