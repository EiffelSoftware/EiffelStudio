note
	description: "[
		Streams that provide pseudorandom integer values
		(using linear congruential pseudorandom number generator).
	]"
	author: "Nadia Polikarpova."
	model: box

class
	V_RANDOM

inherit
	V_INPUT_STREAM [INTEGER]
		redefine
			default_create
		end

create
	default_create,
	set_seed

feature -- Initialization

	default_create
			-- Create a random stream using milliseconds of current time as seed.
		note
			status: creator
			explicit: wrapping
		do
			set_seed (current_time_millis)
		end

	set_seed (seed: NATURAL_64)
			-- Create a random stream with a specified `seed'.
		note
			status: creator
		do
			value := (seed.bit_xor (Multiplier) & (({NATURAL_64} 1 |<< Random_bit_count) - 1))
			next_value := next (value)
		end

feature -- Access

	item: INTEGER
			-- Random integer.
		do
			Result := random_bits (value, 32)
		end

	bounded_item (min, max: INTEGER): INTEGER
			-- Random integer from [min..max].
		require
			bounds_valid: max >= min
		local
			n: NATURAL
		do
			if min = {INTEGER}.min_value and max = {INTEGER}.max_value then
				Result := item
			else
				n := item.to_natural_32 \\ (max.to_integer_64 - min.to_integer_64 + 1).to_natural_32
				Result := (min + n.to_integer_64).to_integer_32
			end
		ensure
			result_in_bounds: min <= Result and Result <= max
		end

	long_item: INTEGER_64
			-- Random 64-bit integer.
		do
			Result := (random_bits (value, 32).to_integer_64 |<< 32) + random_bits (next_value, 32)
		end

--	real_item: REAL
--			-- Random real number from [0.0..1.0).
--		do
--			Result := random_bits (value, 24).to_real / (1 |<< 24).to_real
--		ensure
--			result_in_bounds: 0.0 <= Result and Result < 1.0
--		end

--	double_item: DOUBLE
--			-- Random 64-bit real number from [0.0..1.0).
--		do
--			Result := (random_bits (value, 26).to_natural_64 |<< 27 + random_bits (next_value, 27).to_natural_64) /
--				({NATURAL_64} 1 |<< 53).to_real_64
--		ensure
--			result_in_bounds: 0.0 <= Result and Result < 1.0
--		end

	fair_bit: BOOLEAN
			-- True with probability 1/2.
		do
			Result := random_bits (value, 1) /= 0
		end

--	unfair_bit (p: REAL): BOOLEAN
--			-- True with probability `p'.
--		require
--			p_is_probability: p >= 0.0 and then p <= 1.0
--		do
--			Result := real_item < p
--		end

feature -- Status report

	off: BOOLEAN
			-- Is current position off scope?
		do
			Result := False
		end

feature -- Cursor movement

	forth
			-- Move one position forward.
		do
			value := next (next_value)
			next_value := next (value)
		end

feature {NONE} -- Implementation

	value: NATURAL_64
			-- Current random bit string.

	next_value: NATURAL_64
			-- Next random bit string.

	Random_bit_count: INTEGER = 48
			-- Number of random bits in `value' and `next_value'.

	Multiplier: NATURAL_64 = 0x5DEECE66D
			-- Multiplier used for generation.

	Increment: NATURAL_64 = 0xB
			-- Increment used for generation.

	random_bits (v: NATURAL_64; n: INTEGER): INTEGER
			-- Upper `n' random bits of `v'.
		note
			explicit: contracts
		require
			n_in_bounds: 1 <= n and n <= 32
			reads ([])
		do
			Result := (v |>> (Random_bit_count - n)).as_integer_32
		end

	next (v: NATURAL_64): NATURAL_64
			-- Next random bit string after `v'.
		note
			explicit: contracts
		require
			reads ([])
		do
			Result := (v * Multiplier + Increment) & (({NATURAL_64} 1 |<< Random_bit_count) - 1)
		end

	current_time_millis: NATURAL_64
			-- Milliseconds of current time.
		external
			"C inline use <time.h>, <sys/timeb.h>"
		alias
			"[
				struct timeb t;
				ftime(&t);
				return (unsigned long long int)time(NULL) * 1000 + t.millitm;
			]"
		end

invariant
	box_implementation: box = create {like box}.singleton (random_bits (value, 32))

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
