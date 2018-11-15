note
	description: "[
		Represent a block cipher algorithm.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SSL_BLOCK_CIPHER_ALGORITHM

feature -- Access

   	block_size: INTEGER
			-- The size of a block as an integer in bits (e.g. 64, 128).
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
