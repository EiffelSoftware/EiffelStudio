note
	description: "Summary description for {NONCE_GENERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NONCE_GENERATOR

feature -- Factory

	new_nonce (n: INTEGER): STRING_8
			-- Generate a unique token
		local
			l_chars: STRING
			rand: RANDOM
			i, r: INTEGER
		do
			l_chars := "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789"
			from
				i := 1
				create Result.make (n)
				create rand.set_seed ((create {TIME}.make_now).fine_seconds.truncated_to_integer)
			until
				i > n - 1
			loop
				r := 1 + (l_chars.count * (rand.i_th (i) / rand.modulus)).truncated_to_integer
				Result.append_character (l_chars.item (r))
				i := i + 1
			end
			last_nonce_number := 1 + (last_nonce_number + 1 ) \\ l_chars.count
			Result.append_character (l_chars.item (last_nonce_number))
		end

feature {NONE} -- Implementation

	last_nonce_number: INTEGER

;note
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
