indexing
	description: "Generates uuids according to RFC 4122, Variant 1 0, Version 4."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UUID_GENERATOR

feature -- Access

	uuid: STRING is
			-- Get a random uuid.
        local
            l_b: ARRAY [NATURAL_8]
            i: INTEGER
        do
        	create Result.make (36)
        	create l_b.make (1, 16)
        	from
        		i := 1
        	until
        		i > 16
        	loop
        		l_b[i] := rand_byte
        		i := i + 1
        	end

				-- put in version
			l_b[7] := l_b[7] & 0x0f | 0x40
				-- put in variant
			l_b[9] := l_b[9] & 0x3f | 0x80

        	from
        		i := 1
        	until
        		i > 16
        	loop
        		Result.append((l_b[i]).to_hex_string)
        		if i = 4 or i = 6 or i = 8 or i = 10 then
        			Result.append_character ('-')
        		end
        		i := i + 1
        	end
        	Result.to_lower
        ensure
        	Valid_uuid: is_valid_uuid (Result)
		end

feature -- Validation

	is_valid_uuid (a_string: STRING): BOOLEAN is
			-- Is `a_string' a valid uuid?
		require
			a_string_not_void: a_string /= Void
		local
			i: INTEGER
		do
			if a_string.count /= 36 then
				Result := False
			else
				Result := True
				from
					i := 1
				until
					not Result or i > 36
				loop
					if i = 9 or i = 14 or i = 19 or i = 24 then
						Result := a_string.item (i) = '-'
					else
						Result := a_string.item (i).is_hexa_digit
					end
					i := i +1
				end
			end
		end


feature {NONE} -- Implementation

	initialize_seed is
			-- Initialize the seed of the random number generator.
		require
			rand_not_void: rand /= Void
		local
			l_seed: NATURAL_64
			l_date: C_DATE
		do
			create l_date
				-- Compute the seed as number of milliseconds since EPOC (January 1st 1970)
			l_seed := l_seed + (l_date.year_now-1970).to_natural_64*12*30*24*60*60*1000
			l_seed := l_seed + l_date.month_now.to_natural_64*30*24*60*60*1000
			l_seed := l_seed + l_date.day_now.to_natural_64*24*60*60*1000
			l_seed := l_seed + l_date.hour_now.to_natural_64*60*60*1000
			l_seed := l_seed + l_date.minute_now.to_natural_64*60*1000
			l_seed := l_seed + l_date.second_now.to_natural_64*1000
			l_seed := l_seed + l_date.millisecond_now.to_natural_64
				-- Use RFC 4122 trick to preserve as much meaning of `l_seed' onto an INTEGER_32.
			rand.set_seed ((l_seed |>> 32).bit_xor (l_seed).as_integer_32 & 0x7FFFFFFF)
		end

	rand_byte: NATURAL_8 is
			-- Get a random byte.
        do
        	if rand_count.item = rand_count.item + 1 then
        		initialize_seed
        		rand_count.put (0)
        	else
				rand_count.put (rand_count.item + 1)
        	end
            Result := rand.i_th (rand_count.item).as_natural_8
        ensure
        	rand_count_changed: old rand_count /= rand_count
        end

	rand: RANDOM is
			-- Random number generator.
		once
			create Result.make
			initialize_seed
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

end
