indexing
	description: "Generates uuids according to RFC 4122, Variant 1 0, Version 4."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UUID_GENERATOR

feature -- Access

	generate_uuid: UUID is
			-- Generate a random UUID
        local
            l_segs: ARRAY [NATURAL_8]
            i: INTEGER
        do
        	create l_segs.make (1, 16)
        	from
        		i := 1
        	until
        		i > 16
        	loop
        		l_segs[i] := rand_byte
        		i := i + 1
        	end

				-- put in version
			l_segs[7] := l_segs[7] & 0x0f | 0x40
				-- put in variant
			l_segs[9] := l_segs[9] & 0x3f | 0x80

			create Result.make_from_array (l_segs)
        ensure
        	uuid_not_null: not Result.is_null
		end

feature {NONE} -- Implementation

	rand_byte: NATURAL_8 is
			-- Get a random byte.
		local
			l_count: INTEGER
        do
        	l_count := rand_count.item
        	if l_count = {INTEGER}.max_value then
        			-- Reset
        		l_count := 0
        		rand.set_seed (seed)
        	else
        		l_count := l_count + 1
        	end
            Result := rand.i_th (l_count).as_natural_8
            rand_count.put (l_count)
        ensure
        	rand_count_changed: old rand_count.item /= rand_count.item
        end

	rand: RANDOM is
			-- Random number generator.
		once
			create Result.make
			Result.set_seed (seed)
		ensure
			rand_not_void: Result /= Void
		end

	rand_count: CELL [INTEGER] is
			-- The `rand_count'-th random number was used.
		once
			create Result.put (0)
		ensure
			rand_count_not_void: Result /= Void
		end

	seed: INTEGER is
			-- Seed of the random number generator.
		require
			rand_not_void: rand /= Void
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
			Result := ((l_seed |>> 32).bit_xor (l_seed).as_integer_32 & 0x7FFFFFFF)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class UUID_GENERATOR
