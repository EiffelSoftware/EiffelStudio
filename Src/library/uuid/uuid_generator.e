note
	description: "[
		Generates uuids according to RFC 4122, Variant 1 0, Version 4.
	]"
	remark: "[
		This generator was designed for a single threaded case.
		In a multithreaded environment only one UUID_GENERATOR should be created and then be shared among all threads.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UUID_GENERATOR

feature -- Access

	generate_uuid: UUID
			-- Generate a random UUID.
		do
			create Result.make_from_array (segments (rand_count, rand))
		ensure
			instance_free: class
			uuid_not_null: not Result.is_null
		end

feature {NONE} -- Implementation

	segments (c: like rand_count; r: like rand): ARRAY [NATURAL_8]
			-- Randomly geneated segments of UUID.
		local
			i: INTEGER
			l_count: INTEGER
		do
			create Result.make_filled ({NATURAL_8} 0, 1, 16)
			l_count := c.item
			from
				i := 1
			until
				i > 16
			loop
					-- Generate a random byte.
				if l_count = {INTEGER}.max_value then
						-- Reset.
					l_count := 0
					r.set_seed (seed)
				else
					l_count := l_count + 1
				end
				Result [i] := r.i_th (l_count).as_natural_8
				i := i + 1
			end
			c.put (l_count)
				-- Put in version.
			Result [7] := Result [7] & 0x0f | 0x40
				-- Put in variant.
			Result [9] := Result [9] & 0x3f | 0x80
		ensure
			instance_free: class
			rand_count_changed: -- old rand_count.item /= rand_count.item
		end

	rand: separate RANDOM
			-- Random number generator.
		once ("PROCESS")
			create <NONE> Result.set_seed (seed)
		ensure
			instance_free: class
			rand_not_void: Result /= Void
		end

	rand_count: separate CELL [INTEGER]
			-- The `rand_count'-th random number was used.
		once ("PROCESS")
			create <NONE> Result.put (0)
		ensure
			instance_free: class
			rand_count_not_void: Result /= Void
		end

	seed: INTEGER
			-- Seed of the random number generator.
		local
			l_seed: NATURAL_64
			l_date: C_DATE
		do
			create l_date
				-- Compute the seed as number of milliseconds since EPOC (January 1st 1970)
			l_seed := (l_date.year_now - 1970).to_natural_64 * 12 * 30 * 24 * 60 * 60 * 1000
			l_seed := l_seed + l_date.month_now.to_natural_64 * 30 * 24 * 60 * 60 * 1000
			l_seed := l_seed + l_date.day_now.to_natural_64 * 24 * 60 * 60 * 1000
			l_seed := l_seed + l_date.hour_now.to_natural_64 * 60 * 60 * 1000
			l_seed := l_seed + l_date.minute_now.to_natural_64 * 60 * 1000
			l_seed := l_seed + l_date.second_now.to_natural_64 * 1000
			l_seed := l_seed + l_date.millisecond_now.to_natural_64
				-- Use RFC 4122 trick to preserve as much meaning of `l_seed' onto an INTEGER_32.
			Result := (l_seed |>> 32).bit_xor (l_seed).as_integer_32 & 0x7FFFFFFF
		ensure
			instance_free: class
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
