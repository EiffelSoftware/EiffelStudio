note
	description: "{
		Represent a block cipher algorithm.
	}"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_BLOCK_CIPHER_ALGORITHM

feature -- Access

   	block_size: INTEGER
			-- The size of a block as an integer in bits (e.g. 64, 128).
		deferred
		end

end
