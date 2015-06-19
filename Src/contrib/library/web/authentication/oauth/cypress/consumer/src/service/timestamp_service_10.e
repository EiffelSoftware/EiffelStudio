note
	description: "Summary description for {TIMPESTAMP_SERVICE_10}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TIMESTAMP_SERVICE_10

inherit

	TIMESTAMP_SERVICE

feature -- Access

	timestamp_in_seconds: STRING
			-- unix epoch timestamp in seconds
		local
			l_time:  TIMESTAMP_HELPER
		do
			create l_time
			Result := l_time.timestamp_now_utc.out
		end

	nonce:STRING
			-- unique value for each request
		local
			l_nonce: NONCE_GENERATOR
		do
			initialize_random
			create l_nonce
			Result := l_nonce.new_nonce (42)
		end




feature {NONE} -- Implementation

	initialize_random
		local
			l_time: TIME
			l_seed: INTEGER
		do
			create l_time.make_now
			l_seed := l_time.hour
			l_seed := l_seed * 60 + l_time.minute
			l_seed := l_seed * 60 + l_time.second
			l_seed := l_seed * 1000 + l_time.milli_second
			create random_sequence.set_seed (l_seed)
		end

	new_random: INTEGER
			-- Random integer
			-- Each call returns another random number.
		do
			if attached random_sequence as l_random_sequence then
				l_random_sequence.forth
				Result := l_random_sequence.item
			else
				Result := 27
			end
		end

	random_sequence: detachable RANDOM
			-- Random sequence

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
