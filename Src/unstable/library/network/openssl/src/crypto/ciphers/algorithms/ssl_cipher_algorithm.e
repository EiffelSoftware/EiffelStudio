note
	description: "{
		Represent a Cipher Algorithm
	}"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_CIPHER_ALGORITHM

feature -- Access

	name: STRING
			-- name of the algorithm.
		deferred
		end

	key_size: INTEGER
			-- The size of the key being used as an integer in bits (e.g. 128, 256).
		deferred
		end

end
