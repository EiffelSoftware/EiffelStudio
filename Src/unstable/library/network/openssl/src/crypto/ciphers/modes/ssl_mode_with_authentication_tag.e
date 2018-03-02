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

end
