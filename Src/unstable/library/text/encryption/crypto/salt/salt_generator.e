note
	description: "Generic {SALT_GENERATOR}, with common functionality to most salt generator."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SALT_GENERATOR

feature -- Access

	new_sequence: ARRAY [NATURAL_8]
			-- New random sequence
		local
			i, n: INTEGER
		do
			n := salt_length
			create Result.make_filled ({NATURAL_8} 0, 1, n)
			from
				i := 1
			until
				i > n
			loop
				Result [i] := (new_random & 0xFF).as_natural_8
				i := i + 1
			end
		end

feature -- Initialization

	make (a_length: INTEGER)
			-- Initialize salt generator
		local
			l_time: TIME
			l_seed: INTEGER
		do
			salt_length := a_length
			create l_time.make_now
			l_seed := l_time.hour
			l_seed := l_seed * 60 + l_time.minute
			l_seed := l_seed * 60 + l_time.second
			l_seed := l_seed * 1000 + l_time.milli_second
			set_seed (l_seed)
		ensure
			salt_length_set: salt_length = a_length
		end

feature -- {NONE} Implementation

	set_seed (a_seed: INTEGER)
			-- Set `seed' with `a_seed'
		deferred
		end

	new_random: INTEGER_64
			-- Random integer
			-- Each call returns another random number.
		deferred
		end

	salt_length: INTEGER
			-- password length.

	;

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
