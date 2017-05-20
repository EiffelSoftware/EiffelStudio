note
	description: "[
		Streams that provide pseudorandom integer values
		(using linear congruential pseudorandom number generator).
	]"
	author: "Nadia Polikarpova."
	updated_by: "Alexander Kogtenkov"
	model: bit_sequence

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
		do
			set_seed (current_time_millis)
		end

	set_seed (seed: NATURAL_64)
			-- Create a random stream with a specified `seed'.
		do
			value := seed.bit_xor (Multiplier) & (({NATURAL_64} 1 |<< Random_bit_count) - 1)
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
			n := item.to_natural_32 \\ (max.to_integer_64 - min.to_integer_64 + 1).to_natural_32
			Result := (min + n.to_integer_64).to_integer_32
		ensure
			result_in_bounds: min <= Result and Result <= max
		end

	long_item: INTEGER_64
			-- Random 64-bit integer.
		do
			Result := (random_bits (value, 32).to_integer_64 |<< 32) + random_bits (next_value, 32)
		end

	real_item: REAL
			-- Random real number from [0.0..1.0).
		do
			Result := random_bits (value, 24) / (1 |<< 24).to_real
		ensure
			result_in_bounds: 0.0 <= Result and Result < 1.0
		end

	double_item: DOUBLE
			-- Random 64-bit real number from [0.0..1.0).
		do
			Result := (random_bits (value, 26).to_natural_64 |<< 27 + random_bits (next_value, 27).to_natural_64) /
				({NATURAL_64} 1 |<< 53).to_real_64
		ensure
			result_in_bounds: 0.0 <= Result and Result < 1.0
		end

	fair_bit: BOOLEAN
			-- True with probability 1/2.
		do
			Result := random_bits (value, 1) /= 0
		end

	unfair_bit (p: REAL): BOOLEAN
			-- True with probability `p'.
		require
			p_is_probability: p >= 0.0 and then p <= 1.0
		do
			Result := real_item < p
		ensure
			definition: Result = (real_item < p)
		end

feature -- Status report

	off: BOOLEAN = False
			-- Is current position off scope?

feature -- Cursor movement

	forth
			-- Move one position forward.
		note
			modify: bit_sequence
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
		require
			n_in_bounds: 1 <= n and n <= 32
		do
			Result := (v |>> (Random_bit_count - n)).as_integer_32
		end

	next (v: NATURAL_64): NATURAL_64
			-- Next random bit string after `v'.
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

feature -- Specification

	bit_sequence: MML_SEQUENCE [BOOLEAN]
			-- Bit sequence from which current random values are derived.
		local
			i: INTEGER
		do
			create Result
			from
				i := 0
			until
				i >= Random_bit_count
			loop
				Result := Result & ((value |>> i) & {NATURAL_64} 1 = 1)
				i := i + 1
			end
			from
				i := 0
			until
				i >= Random_bit_count
			loop
				Result := Result & ((value |>> i) & {NATURAL_64} 1 = 1)
				i := i + 1
			end
		end

invariant
	box_constraint: box.count = 1
	--- box_item_definition: box.any_item = function (bit_sequence)
	--- long_item_definition: long_item = function (bit_sequence)
	--- real_item_definition: real_item = function (bit_sequence)
	--- double_item_definition: double_item = function (bit_sequence)
	fair_bit_definition: fair_bit = bit_sequence [Random_bit_count]
end
