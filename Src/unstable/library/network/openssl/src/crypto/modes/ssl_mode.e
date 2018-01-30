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

	validate_for_aglorithm (a_algo: SSL_ALGORITHM): BOOLEAN
			--  Checks that all the necessary invariants of this (mode, algorithm)
        	--	combination are met.
		deferred
		end
end
