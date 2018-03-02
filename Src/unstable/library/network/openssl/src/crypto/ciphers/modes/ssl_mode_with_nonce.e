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

end
