note
	description: "Functionality to query the status of an arbitrary precision integer"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The urge to save humanity is almost always a false front for the urge to rule. - H.L. Mencken"

deferred class
	READABLE_INTEGER_X

inherit
	ANY
		undefine
			default_create,
			is_equal,
			copy
		redefine
			out
		select
			out
		end

	DEBUG_OUTPUT
		undefine
			default_create,
			is_equal,
			copy,
			out
		redefine
			debug_output
		end

	NUMERIC
		rename
			plus as plus_value alias "+",
			minus as minus_value alias "-",
			product as product_value alias "*",
			quotient as quotient_value alias "/",
			opposite as opposite_value alias "-"
		undefine
			default_create,
			out
		redefine
			copy,
			is_equal
		end

	COMPARABLE
		undefine
			default_create,
			out
		redefine
			copy,
			is_equal,
			three_way_comparison
		end

	INTEGER_X_ASSIGNMENT
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		export
			{NONE}
				all
		undefine
			default_create,
			is_equal,
			copy,
			out
		end

	INTEGER_X_ACCESS
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special,
			cmp as cmp_special,
			tdiv_qr as tdiv_qr_special,
			sizeinbase as sizeinbase_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		export
			{NONE}
				all
		undefine
			default_create,
			is_equal,
			copy,
			out
		end

	INTEGER_X_ARITHMETIC
		rename
			abs as abs_integer_x,
			cmp as cmp_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		export
			{NONE}
				all
		undefine
			default_create,
			is_equal,
			copy,
			out
		end

	INTEGER_X_COMPARISON
		export
			{NONE}
				all
		undefine
			default_create,
			is_equal,
			copy,
			out
		end

	INTEGER_X_LOGIC
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special,
			bit_and as bit_and_integer_x,
			bit_complement as bit_complement_integer_x,
			bit_or as bit_or_integer_x,
			bit_test as bit_test_integer_x,
			bit_xor as bit_xor_integer_x,
			bit_xor_lshift as bit_xor_lshift_integer_x
		export
			{NONE}
				all
		undefine
			default_create,
			is_equal,
			copy,
			out
		end

	INTEGER_X_IO
		rename
			sizeinbase as sizeinbase_special
		export
			{NONE}
				all
		undefine
			default_create,
			is_equal,
			copy,
			out
		end

	INTEGER_X_RANDOM
		rename
			add as add_special,
			sub as sub_special,
			mul as mul_special,
			cmp as cmp_special,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		export
			{NONE}
				all
		undefine
			default_create,
			is_equal,
			copy,
			out
		end

	INTEGER_X_SIZING
		export
			{NONE}
				all
		undefine
			default_create,
			is_equal,
			copy,
			out
		end

	INTEGER_X_NUMBER_THEORY
		rename
			abs as abs_integer_x,
			mod as mod_integer_x,
			gcd as gcd_integer_x,
			bit_and as bit_and_integer_x,
			bit_complement as bit_complement_integer_x,
			bit_or as bit_or_integer_x,
			bit_test as bit_test_integer_x,
			bit_xor as bit_xor_integer_x,
			powm as powm_integer_x,
			bit_xor_lshift as bit_xor_lshift_integer_x,
			invert_gf as invert_gf_integer_x
		export
			{NONE}
				all
		undefine
			default_create,
			is_equal,
			copy,
			out
		end

	INTEGER_X_DIVISION
		rename
			abs as abs_integer_x,
			cmp as cmp_special,
			mod as mod_integer_x,
			bit_xor_lshift as bit_xor_lshift_special,
			bit_xor as bit_xor_special
		export
			{NONE}
				all
		undefine
			default_create,
			is_equal,
			copy,
			out
		end

	SPECIAL_UTILITY
		export
			{INTEGER_X_FACILITIES}
				all
		undefine
			default_create,
			is_equal,
			copy,
			out
		end

feature {NONE} -- Initialization

	default_create
			-- Initialize `Current' to zero
		do
			create item.make_filled (0, 1)
			count := 0
		ensure then
			zero: is_zero
		end

	make_set (other: READABLE_INTEGER_X)
			-- Initialize `Current' to be a copy of `other'
		do
			create item.make_filled (0, 0)
			set_from_other (other)
		ensure
			equal: Current ~ other
		end

	make_from_integer (i: INTEGER)
			-- Initialize `Current' from `i'.
		do
			default_create
			set_from_integer (i)
		ensure
			set: as_integer = i
		end

	make_from_integer_64 (i: INTEGER_64)
			-- Initialize `Current' from `i'.
		do
			default_create
			set_from_integer_64 (i)
		ensure
			set: as_integer_64 = i
		end

	make_from_integer_32 (i: INTEGER_32)
			-- Initialize `Current' from `i'.
		do
			default_create
			set_from_integer_32 (i)
		ensure
			set: as_integer_32 = i
		end

	make_from_integer_16 (i: INTEGER_16)
			-- Initialize `Current' from `i'.
		do
			default_create
			set_from_integer_16 (i)
		ensure
			set: as_integer_16 = i
		end

	make_from_integer_8 (i: INTEGER_8)
			-- Initialize `Current' from `i'.
		do
			default_create
			set_from_integer_8 (i)
		ensure
			set: as_integer_8 = i
		end

	make_from_natural (n: NATURAL)
			-- Initialize `Current' from `n'.
		do
			default_create
			set_from_natural (n)
		ensure
			set: as_natural = n
		end

	make_from_natural_64 (n: NATURAL_64)
			-- Initialize `Current' from `n'.
		do
			default_create
			set_from_natural_64 (n)
		ensure
			set: as_natural_64 = n
		end

	make_from_natural_32 (n: NATURAL_32)
			-- Initialize `Current' from `n'.
		do
			default_create
			set_from_natural_32 (n)
		ensure
			set: as_natural_32 = n
		end

	make_from_natural_16 (n: NATURAL_16)
			-- Initialize `Current' from `n'.
		do
			default_create
			set_from_natural_16 (n)
		ensure
			set: as_natural_16 = n
		end

	make_from_natural_8 (n: NATURAL_8)
			-- Initialize `Current' from `n'.
		do
			default_create
			set_from_natural_8 (n)
		ensure
			set: as_natural_8 = n
		end

	make_from_string (s: STRING)
			-- Initialize `Current' from `s' where `s' is a base 10 string
		require
			s_not_empty: not s.is_empty
		do
			default_create
			set_str (Current, s, 10)
		end

	make_from_hex_string (s: STRING)
			-- Initialize `Current' from `s' where `s' is a base 16 string
		require
			s_not_empty: not s.is_empty
		do
			default_create
			set_str (Current, s, 16)
		end

	make_from_string_base (s: STRING base: INTEGER)
			-- Initialize `Current' from `s' where `s' is a string of base `base'
		require
			s_not_empty: not s.is_empty
			base_too_small: base >= 2
			base_too_big: base <= 62
		do
			default_create
			set_str (Current, s, base)
		end

	make_random (bits_a: INTEGER)
			-- Initialize as a random number of `bits_a' bits
		require
			valid_bits: bits_a > 0
		do
			default_create
			set_random (bits_a)
		ensure
			correct_bits: bits <= bits_a
		end

	make_random_prime (bits_a: INTEGER)
			-- Initialise a random number of `bits_a' bits that is probably prime
		require
			valid_bits: bits_a > 0
		do
			default_create
			from
				set_random (bits_a)
			until
				is_probably_prime
			loop
				set_random (bits_a)
			end
		ensure
			prime: is_probably_prime
			correct_bits: bits <= bits_a
		end

	make_from_bytes (bytes_array: SPECIAL[NATURAL_8] first: INTEGER last: INTEGER)
			-- Initialize from byte array
		require
			last_after_first: last >= first
			valid_offset: bytes_array.valid_index (first)
			valid_end: bytes_array.valid_index (last)
		do
			default_create
			input (Current, last - first + 1, 1, 1, -1, bytes_array, first)
		end

	make_random_max (max_value: like Current)
			--Generate a uniform random integer in the range 0 to max_value-1, inclusive.
		require
			positive_max: max_value.is_positive
		do
			default_create
			urandomm (Current, random_state, max_value)
		ensure
			valid_range: Current < max_value
		end

	make_limbs (limbs: INTEGER)
			-- Initialize `Current' with space for `limbs' limbs in the internal representation
		do
			create item.make_filled (0, limbs)
			count := 0
		ensure
			is_zero
		end

	make_bits (bits_a: INTEGER)
		do
			create item.make_filled (0, (bits_a + (limb_bits - 1)) // limb_bits)
			count := 0
		ensure
			is_zero
		end

feature -- Constants

	one: like Current
			-- Neutral element for "*" and "/"
		deferred
		end

	zero: like Current
			-- Neutral element for "+" and "-"
		deferred
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := three_way_comparison (other) < 0
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := three_way_comparison (other) = 0
		end

	three_way_comparison (other: like Current): INTEGER
			-- Perform a three way comparison between `Current' and `other'
		do
			Result := compare (Current, other).three_way_comparison (0)
		end

feature -- Measurement

	bytes: INTEGER
			-- Minimum number of bytes the absolute value of this number would occupy
		do
			Result := (bits + 7).bit_and (0xfffffff8).bit_shift_right (3)
		end

	bits: INTEGER
			-- Minimum number of bits the absolute value of this number would occupy
		do
			Result := size_in_base (2)
		ensure
			valid_result: Result >= 1
		end

feature -- Status report

	divisible (other: like Current): BOOLEAN
			-- May `Current' be divided by `other'?
		do
			Result := not other.is_zero
		end

	exponentiable (other: NATURAL_32_REF): BOOLEAN
			-- May `Current' be elevated to the power `other'?
		do
			Result := True
		end

	fits_natural: BOOLEAN
			-- Does `Current' fit in a {NATURAL} without truncation?
		do
			Result := fits_natural_32
		end

	fits_natural_64: BOOLEAN
			-- Does `Current' fit in a {NATURAL_64} without truncation?
		local
			n: INTEGER
		do
			resize (2)
			n := count
			Result := n >= 0 and n <= 2
		end

	fits_natural_32: BOOLEAN
			-- Does `Current' fit in a {NATURAL_32} without truncation?
		local
			n: INTEGER
		do
			n := count
			Result := n = 0 or n = 1
		end

	fits_natural_16: BOOLEAN
			-- Does `Current' fit in a {NATURAL_16} without truncation?
		local
			n: INTEGER_32
		do
			n := count
			Result := n = 0 or (n = 1 and then item [0] <= (0).to_natural_16.max_value)
		end

	fits_natural_8: BOOLEAN
			-- Does `Current' fit in a {NATURAL_8} without truncation?
		local
			n: INTEGER_32
		do
			n := count
			Result := n = 0 or (n = 1 and then item [0] <= (0).to_natural_8.max_value)
		end

	fits_integer: BOOLEAN
			-- Does `Current' fit in an {INTEGER} without truncation?
		do
			Result := fits_integer_32
		end

	fits_integer_64: BOOLEAN
			-- Does `Current' fit in an {INTEGER_64} without truncation?
		local
			n: INTEGER
			limb1: NATURAL_32
			limb2: NATURAL_32
		do
			n := count
			limb1 := item [0]
			if n = 0 or n = 1 or n = -1 then
				Result := True
			elseif n = 2 then
				limb2 := item [1]
				Result := not limb2.bit_test (31)
			elseif n = -2 then
				limb2 := item [1]
				if limb2.bit_test (31) then
					Result := limb2.bit_and (0x7fffffff) = 0 and limb1 = 0
				else
					Result := True
				end
			end
		end

	fits_integer_32: BOOLEAN
			-- Does `Current' fit in an {INTEGER_32} without truncation?
		local
			n: INTEGER_32
			limb: NATURAL_32
		do
			n := count
			limb := item [0]
			if
				n = 0
			then
				Result := True
			elseif n = 1 then
				Result := not limb.bit_test (31)
			elseif n = -1 then
				if limb.bit_test (31) then
					Result := limb.bit_and (0x7fffffff) = 0
				else
					Result := True
				end
			end
		end

	fits_integer_16: BOOLEAN
			-- Does `Current' fit in an {INTEGER_16} without truncation?
		local
			n: INTEGER
			limb: NATURAL_32
		do
			n := count
			limb := item [0]
			if n = 0 then
				Result := True
			elseif n = 1 then
				Result := limb <= (0).to_integer_16.max_value.to_natural_32
			elseif n = -1 then
				Result := limb <= (0).to_integer_16.min_value.to_integer_32.abs.to_natural_32
			else
				Result := False
			end
		end

	fits_integer_8: BOOLEAN
			-- Does `Current' fit in an {INTEGER_8} without truncation?
		local
			n: INTEGER
			limb: NATURAL_32
		do
			n := count
			limb := item [0]
			if n = 0 then
				Result := True
			elseif n = 1 then
				Result := limb <= (0).to_integer_8.max_value.to_natural_32
			elseif n = -1 then
				Result := limb <= (0).to_integer_8.min_value.to_integer_32.abs.to_natural_32
			end
		end

	is_odd: BOOLEAN
			-- Is `Current' odd
		do
			Result := count /= 0 and then item [0].bit_test (0)
		end

	is_even: BOOLEAN
			-- Is `Current' even?
		do
			Result := not is_odd
		end

	is_zero: BOOLEAN
			-- Is `Current' equal to zero
		do
			Result := sign = 0
		end

	is_positive: BOOLEAN
			-- Is `Current' positive
		do
			Result := sign = 1
		end

	is_negative: BOOLEAN
			-- Is `Current' negative
		do
			Result := sign = -1
		end

	sign: INTEGER
			-- Return the sign of `Current' where -1 is negative, 0 is zero, and 1 is positive
		do
			Result := count.three_way_comparison (0)
		ensure
			is_positive implies (Result = 1)
			is_zero implies (Result = 0)
			is_negative implies (Result = -1)
		end

	size_in_base (base: INTEGER): INTEGER
			-- What is the size of the string representing the absolute value of `Current' in base `base'
		require
			base_too_small: base >= 2
			base_too_big: base <= 62
		do
			Result := sizeinbase (Current, base)
		end

feature -- Primality testing

	is_composite: BOOLEAN
			-- Is `Current' a composite number?
		do
			Result := probab_prime_p (Current, 10) = 0
		end

	is_prime: BOOLEAN
			-- Is `Current' definitely a prime number?
		do
			Result := probab_prime_p (Current, 10) = 2
		end

	is_probably_prime: BOOLEAN
			-- Is `Current' probably a prime number?
			-- May return `False' if `Current' is actually prime.
		do
			Result := probab_prime_p (Current, 10) > 0
		end

feature {INTEGER_X_FACILITIES}-- Element change

	set_from_other (other: READABLE_INTEGER_X)
		local
			other_count: INTEGER
		do
			other_count := other.count
			resize (other_count)
			item.copy_data (other.item, 0, 0, other_count)
			count := other_count
		end

	set_from_integer (value_a: INTEGER)
			-- Initialize `Current' from `value_a'.
		do
			set_from_integer_32 (value_a)
		ensure
			value_a > 0 implies count = 1
			value_a = 0 implies count = 0
			value_a < 0 implies count = -1
			fits_integer
			as_integer = value_a
		end

	set_from_integer_64 (value_a: INTEGER_64)
			-- Initialize `Current' from `value_a'
		local
			new_value: NATURAL_64
			upper_limb: NATURAL_32
			new_count: INTEGER
		do
			resize (2)
			new_value := value_a.abs.to_natural_64
			item [0] := new_value.to_natural_32
			upper_limb := (new_value |>> 32).to_natural_32
			item [1] := upper_limb
			new_count := value_a.three_way_comparison (0)
			new_count := new_count * ((upper_limb /= 0).to_integer + 1)
			count_set (new_count)
		ensure
			value_a > 0 implies (count = 1 or count = 2)
			value_a = 0 implies (count = 0)
			value_a < 0 implies (count = -1 or count = -2)
			fits_integer_64
			as_integer_64 = value_a
		end

	set_from_integer_32 (value_a: INTEGER_32)
			-- Initialize `Current' from `value_a'.
		local
			limb: NATURAL_32
		do
			if value_a < 0 then
				limb := value_a.to_natural_32.bit_not + 1
			else
				limb := value_a.to_natural_32
			end
			item [0] := limb
			count_set (value_a.three_way_comparison (0))
		ensure
			value_a > 0 implies count = 1
			value_a = 0 implies count = 0
			value_a < 0 implies count = -1
			fits_integer_32
			as_integer_32 = value_a
		end

	set_from_integer_16 (value_a: INTEGER_16)
			-- Initialize `Current' from `value_a'.
		local
			limb: NATURAL_32
		do
			if value_a < 0 then
				limb := value_a.to_natural_32.bit_not + 1
			else
				limb := value_a.to_natural_32
			end
			item [0] := limb
			count_set (value_a.three_way_comparison (0))
		ensure
			value_a > 0 implies count = 1
			value_a = 0 implies count = 0
			value_a < 0 implies count = -1
			fits_integer_16
			as_integer_16 = value_a
		end

	set_from_integer_8 (value_a: INTEGER_8)
			-- Initialize `Current' from `value_a'.
		local
			limb: NATURAL_32
		do
			if value_a < 0 then
				limb := value_a.to_natural_32.bit_not + 1
			else
				limb := value_a.to_natural_32
			end
			item [0] := limb
			count_set (value_a.three_way_comparison (0))
		ensure
			value_a > 0 implies count = 1
			value_a = 0 implies count = 0
			value_a < 0 implies count = -1
			fits_integer_8
			as_integer_8 = value_a
		end

	set_from_natural (value_a: NATURAL)
			-- Initialize `Current' from `value_a'.
		do
			set_from_natural_32 (value_a)
		ensure
			value_a = 0 implies count = 0
			value_a /= 0 implies count = 1
			fits_natural
			as_natural = value_a
		end

	set_from_natural_64 (value_a: NATURAL_64)
			-- Initialize `Current' from `value_a'.
		local
			upper_limb: NATURAL_32
			new_count: INTEGER
		do
			resize (2)
			item [0] := value_a.to_natural_32
			upper_limb := (value_a |>> 32).to_natural_32
			item [1] := upper_limb
			new_count := value_a.three_way_comparison (0)
			new_count := new_count + (upper_limb /= 0).to_integer
			count_set (new_count)
		ensure
			value_a = 0 implies count = 0
			value_a /= 0 implies (count = 1 or count = 2)
			fits_natural_64
			as_natural_64 = value_a
		end

	set_from_natural_32 (value_a: NATURAL_32)
			-- Initialize `Current' from `value_a'.
		do
			item [0] := value_a
			if
				value_a /= 0
			then
				count_set (1)
			else
				count_set (0)
			end
		ensure
			value_a = 0 implies count = 0
			value_a /= 0 implies count = 1
			fits_natural_32
			as_natural_32 = value_a
		end

	set_from_natural_16 (value_a: NATURAL_16)
			-- Initialize `Current' from `value_a'.
		do
			item [0] := value_a.to_natural_32
			if
				value_a /= 0
			then
				count_set (1)
			else
				count_set (0)
			end
		ensure
			value_a = 0 implies count = 0
			value_a /= 0 implies count = 1
			fits_natural_16
			as_natural_16 = value_a
		end

	set_from_natural_8 (value_a: NATURAL_8)
			-- Initialize `Current' from `value_a'.
		do
			item [0] := value_a.to_natural_32
			if
				value_a /= 0
			then
				count_set (1)
			else
				count_set (0)
			end
		ensure
			value_a = 0 implies count = 0
			value_a /= 0 implies count = 1
			fits_natural_8
			as_natural = value_a
		end

	set_from_string (s: STRING)
			-- Initialize `Current' from `s' where `s' is a base 10 string
		require
			s_not_empty: not s.is_empty
		do
			set_str (Current, s, 10)
		end

	set_random (bits_a: INTEGER)
			-- Initialize `Current' to random bits up to `bits_a' bits
		require
			valid_bits: bits_a >= 1
		do
			urandomb (Current, random_state, bits_a)
		ensure
			bits <= bits_a
		end

feature -- Conversion with possible truncation.
		-- Negatives wrap around in the negatives, non-negatives wrap around in the non-negatives

	as_integer: INTEGER
			-- Return the value of `Current' truncated to an {INTEGER}
		do
			Result := as_integer_32
		end

	as_integer_64: INTEGER_64
			-- Return the value of `Current' truncated to an {INTEGER_64}
		local
			size: INTEGER
			unsigned_result: NATURAL_64
		do
			size := count
			if size > 1 then
				unsigned_result := item [1].to_natural_64.bit_shift_left (32)
			end
			unsigned_result := unsigned_result.bit_or (item [0].to_natural_64)
			if size > 0 then
				Result := unsigned_result.to_integer_64.bit_and (0x7fff_ffff_ffff_ffff)
			elseif size < 0 then
				Result := (unsigned_result.to_integer_64 - 1).bit_and (0x7fff_ffff_ffff_ffff).bit_not
			else
				Result := 0
			end
		end

	as_integer_32: INTEGER_32
			-- Return the value of `Current' truncated to an {INTEGER_32}
		local
			size: INTEGER
			zl: NATURAL_32
		do
			size := count
			zl := item [0]
			if size > 0 then
				Result := zl.to_integer_32.bit_and (0x7fffffff)
			elseif size < 0 then
				Result := (zl.to_integer_32 - 1).bit_and (0x7fffffff).bit_not
			else
				Result := 0
			end
		end

	as_integer_16: INTEGER_16
			-- Return the value of `Current' truncated to an {INTEGER_16}
		local
			size: INTEGER
			limb: NATURAL_32
		do
			size := count
			limb := item [0]
			if size > 0 then
				Result := limb.to_integer_16.bit_and (0x7fff)
			elseif size < 0 then
				Result := (limb.to_integer_16 - 1).bit_and (0x7fff).bit_not
			else
				Result := 0
			end
		end

	as_integer_8: INTEGER_8
			-- Return the value of `Current' truncated to an {INTEGER_8}
		local
			size: INTEGER
			limb: NATURAL_32
		do
			size := count
			limb := item [0]
			if size > 0 then
				Result := limb.to_integer_8.bit_and (0x7f)
			elseif size < 0 then
				Result := (limb.to_integer_8 - 1).bit_and (0x7f).bit_not
			else
				Result := 0
			end
		end

	as_natural: NATURAL
			-- Return the value of the absolute value of `Current' truncated to a {NATURAL}
		do
			Result := as_natural_32
		end

	as_natural_64: NATURAL_64
			-- Return the value of the absolute value of `Current' truncated to a {NATURAL_64}
		local
			n: INTEGER
			data: SPECIAL [NATURAL_32]
		do
			n := count
			data := item
			if
				n = 0
			then
				Result := 0
			elseif n = 1 then
				Result := data [0]
			else
				Result := data [1]
				Result := Result |<< 32
				Result := Result.bit_or (data [0])
			end
		end

	as_natural_32: NATURAL_32
			-- Return the value of the absolute value of `Current' truncated to a {NATURAL_32}
		do
			if
				count = 0
			then
				Result := 0
			else
				Result := item [0]
			end
		end

	as_natural_16: NATURAL_16
			-- Return the value of the absolute value of `Current' truncated to a {NATURAL_16}
		do
			if
				count = 0
			then
				Result := 0
			else
				Result := item [0].as_natural_16
			end
		end

	as_natural_8: NATURAL_8
			-- Return the value of the absolute value of `Current' truncated to a {NATURAL_8}
		do
			if
				count = 0
			then
				Result := 0
			else
				Result := item [0].as_natural_8
			end
		end

feature -- Lossless conversion

	to_integer: INTEGER
			-- Return the value of `Current' as an {INTEGER}
		require
			fits: fits_integer_32
		do
			Result := as_integer_32
		ensure
			Current ~ (create {INTEGER_X}.make_from_integer (Result))
		end

	to_integer_64: INTEGER_64
			-- Return the value of `Current' as an {INTEGER_64}
		require
			fits: fits_integer_64
		do
			Result := as_integer_64
		ensure
			Current ~ (create {INTEGER_X}.make_from_integer_64 (Result))
		end

	to_integer_32: INTEGER_32
			-- Return the value of `Current' as an {INTEGER_32}
		require
			fits: fits_integer_32
		do
			Result := as_integer_32
		ensure
			Current ~ (create {INTEGER_X}.make_from_integer_32 (Result))
		end

	to_integer_16: INTEGER_16
			-- Return the value of `Current' as an {INTEGER_16}
		require
			fits: fits_integer_16
		do
			Result := as_integer_16
		ensure
			Current ~ (create {INTEGER_X}.make_from_integer_16 (Result))
		end

	to_integer_8: INTEGER_8
			-- Return the value of `Current' as an {INTEGER_8}
		require
			fits: fits_integer_8
		do
			Result := as_integer_8
		ensure
			Current ~ (create {INTEGER_X}.make_from_integer_8 (Result))
		end

	to_natural: NATURAL_32
			-- Return the value of `Current' as a {NATURAL}
		require
			fits: fits_natural
		do
			Result := to_natural_32
		ensure
			Current ~ (create {INTEGER_X}.make_from_natural (Result))
		end

	to_natural_64: NATURAL_64
			-- Return the value of `Current' as a {NATURAL_64}
		require
			fits: fits_natural_64
		do
			Result := as_natural_64
		ensure
			Current ~ (create {INTEGER_X}.make_from_natural_64 (Result))
		end

	to_natural_32: NATURAL_32
			-- Return the value of `Current' as a {NATURAL_32}
		require
			fits: fits_natural_32
		do
			Result := as_natural_32
		ensure
			Current ~ (create {INTEGER_X}.make_from_natural_32 (Result))
		end

	to_natural_16: NATURAL_16
			-- Return the value of `Current' as a {NATURAL_16}
		require
			fits: fits_natural_16
		do
			Result := as_natural_16
		ensure
			Current ~ (create {INTEGER_X}.make_from_natural_16 (Result))
		end

	to_natural_8: NATURAL_8
			-- Return the value of `Current' as a {NATURAL_8}
		require
			fits: fits_natural_8
		do
			Result := as_natural_8
		ensure
			Current ~ (create {INTEGER_X}.make_from_natural_8 (Result))
		end

	to_bytes (target: SPECIAL [NATURAL_8] offset: INTEGER)
			-- Convert the absolute value of `Current' to a byte array
		require
			big_enough: bytes <= target.upper - offset + 1
		local
			junk: TUPLE [junk: INTEGER]
		do
			create junk
			output (target, offset, junk, 1, 1, -1, Current)
		ensure
			reversable: (create {INTEGER_X}.make_from_bytes (target, offset, offset + bytes - 1)) ~ Current
		end

	as_bytes: SPECIAL[NATURAL_8]
			-- Convert the absolute value of `Current' to a byte array
		do
			create Result.make_filled (0, bytes)
			to_bytes (Result, Result.lower)
		ensure
			reversable: (create {INTEGER_X}.make_from_bytes (Result, Result.lower, Result.upper)) ~ Current
		end

	to_fixed_width_byte_array (target: SPECIAL [NATURAL_8] first: INTEGER last: INTEGER)
		require
			valid_first: target.valid_index (first)
			valid_last: target.valid_index (last)
			enough_space: last - bytes + 1 >= first
		local
			junk: TUPLE [junk: INTEGER_32]
		do
			create junk
			target.fill_with (0x0, first, last)
			output (target, first + (last - first - bytes + 1), junk, 1, 1, -1, Current)
		ensure
			reversable: (create {INTEGER_X}.make_from_bytes (target, first, last)) ~ Current
		end

	as_fixed_width_byte_array (byte_size: INTEGER): SPECIAL[NATURAL_8]
			-- Convert the absolute value of `Current' to a byte array of `byte_size' bytes
		require
			enough_space: bytes <= byte_size
		do
			create Result.make_filled (0, byte_size)
			to_fixed_width_byte_array (Result, 0, byte_size - 1)
		ensure
			reversable: (create {INTEGER_X}.make_from_bytes (Result, Result.lower, Result.upper)) ~ Current
		end

feature -- Duplication

	copy (other: like Current)
			-- Update `Current' to be a copy of `other'
		local
			usize: INTEGER
			size: INTEGER
		do
			usize := other.count
			size := usize.abs
			resize (size)
			item.copy_data (other.item, 0, 0, size)
			count := usize
		end

feature {INTEGER_X_FACILITIES}-- Basic operations stateful

	abs
			-- Modify `Current' to be non-negative
		do
			abs_integer_x (Current, Current)
		ensure
			non_negative: not is_negative
		end

	plus (other: like Current)
			-- Modify `Current' to be the sum of `Current' and `other'
		do
			add (Current, Current, other)
		end

	minus (other: like Current)
			-- Modify `Current' to be the subtraction of `Current' and `other'
		do
			sub (Current, Current, other)
		end

	product (other: like Current)
			-- Modify `Current' to be the product of `Current' and `other'
		do
			mul (Current, Current, other)
		end

	quotient (other: like Current)
			-- Modify `Current' to be the quotient by truncation division of `Current' by `other'
		do
			tdiv_q (Current, Current, other)
		end

	opposite
			-- Modify `Current' to be the opposite sign or do nothing if `Current'.is_zero
		do
			neg (Current, Current)
		end

feature -- Basic operations stateless
	abs_value: like Current
			-- Return the absolute value of `Current'
		do
			Result := identity
			Result.abs
		ensure
			non_negative: not Result.is_negative
			same_absolute_value: (Result ~ (Current)) or (Result ~ (-Current))
		end

	plus_value alias "+" (other: like Current): like Current
			-- Return the sum of `Current' and `other'
		do
			Result := identity
			Result.plus (other)
		ensure then
			Result - Current ~ other
			Result - other ~ Current
		end

	minus_value alias "-" (other: like Current): like Current
			-- Return the subtraction of `Current' and `other'
		do
			Result := identity
			Result.minus (other)
		ensure then
			Result + other ~ Current
			Current - Result ~ other
		end

	product_value alias "*" (other: like Current): like Current
			-- Return the product of `Current' and `other'
		do
			Result := identity
			Result.product (other)
		ensure then
			Result / Current ~ other
			Result / other ~ Current
		end

	quotient_value alias "/" (other: like Current): like Current
			-- Return the integer quotient by truncation division of `Current' by `other'
		do
			Result := identity
			Result.quotient (other)
		end

	identity alias "+": like Current
			-- Return the identity of `Current'
		do
			Result := deep_twin
		end

	opposite_value alias "-": like Current
			-- Return the negative of `Current'
		do
			Result := identity
			Result.opposite
		end

feature {INTEGER_X_FACILITIES}-- Bit operations stateful

	bit_complement (bit_a: INTEGER)
			-- Modify `Current' to have bit `bit_a' complemented
		do
			bit_complement_integer_x (Current, bit_a)
		ensure
			is_negative implies not old is_positive
			is_positive implies not old is_negative
		end

	bit_and (other: like Current)
			-- Modify `Current' to be the bitwise AND of `Current' and `other'
		do
			bit_and_integer_x (Current, Current, other)
		ensure
			is_negative implies not old is_positive
			is_positive implies not old is_negative
		end

	bit_or (other: like Current)
			-- Modify `Current' to be the bitwise OR of `Current' and `other'
		do
			bit_or_integer_x (Current, Current, other)
		ensure
			is_negative implies not old is_positive
			is_positive implies not old is_negative
		end

	bit_xor (other: like Current)
			-- Modify `Current' to be the bitwise XOR of `Current' and `other'
		do
			bit_xor_integer_x (Current, Current, other)
		ensure
			is_negative implies not old is_positive
			is_positive implies not old is_negative
		end

	bit_not
			-- Modify `Current' to be a bitwise NOT of `Current'
		do
			bit_one_complement (Current, Current)
		ensure
			is_negative implies not old is_positive
			is_positive implies not old is_negative
		end

	bit_xor_left_shift (other: like Current left_shift_bits: INTEGER)
			-- Modify `Current' to be the bitwise XOR of `Current' and (`other' shifted left `left_shift_bits' bits)
		do
			bit_xor_lshift_integer_x (Current, Current, other, left_shift_bits)
		ensure
			is_negative implies not old is_positive
			is_positive implies not old is_negative
		end

	bit_shift_right (bits_a: INTEGER)
			-- Modify `Current' to be bit shifted right `bits_a' bits
		do
			tdiv_q_2exp (Current, Current, bits_a)
		ensure
			is_negative implies not old is_positive
			is_positive implies not old is_negative
		end

	bit_shift_left (bits_a: INTEGER)
			-- Modify `Current' to be bit shifted left `bits_a' bits
		do
			mul_2exp (Current, Current, bits_a)
		ensure
			is_negative implies not old is_positive
			is_positive implies not old is_negative
		end

	set_bit (value: BOOLEAN; bit_a: INTEGER)
			-- Modify `Current' and set bit `bit_a' if `value' is True
		do
			if value then
				bit_set (Current, bit_a)
			else
				bit_clear (Current, bit_a)
			end
		ensure
			is_negative implies not old is_positive
			is_positive implies not old is_negative
		end

feature -- Bit operations stateless
		-- All bit operations are performed as if the number was stored in two-complement format

	bit_complement_value (bit_a: INTEGER): like Current
			-- Return a copy of `Current' with bit `bit_a' complemented
		require
			valid_i: bit_a >= 0
		do
			Result := identity
			Result.bit_complement (bit_a)
		ensure
			is_negative implies not Result.is_positive
			is_positive implies not Result.is_negative
		end

	bit_and_value alias "&" (other: like Current): like Current
			-- Return the bitwise AND of `Current' and `other'
		do
			Result := identity
			Result.bit_and (other)
		ensure
			is_negative implies not Result.is_positive
			is_positive implies not Result.is_negative
		end

	bit_or_value alias "|" (other: like Current): like Current
			-- Return the bitwise OR of `Current' and `other'
		do
			Result := identity
			Result.bit_or (other)
		ensure
			is_negative implies not Result.is_positive
			is_positive implies not Result.is_negative
		end

	bit_xor_value (other: like Current): like Current
			-- Return the bitwise XOR of `Current' and `other'
		do
			Result := identity
			Result.bit_xor (other)
		ensure
			Result.bit_xor_value (Current) ~ other
			Result.bit_xor_value (other) ~ Current
		end

	bit_xor_left_shift_value (other: like Current left_shift_bits: INTEGER): like Current
			-- Return the bitwise XOR of `Current' and (`other' shifted left `left_shift_bits' bits)
		do
			Result := identity
			Result.bit_xor_left_shift (other, left_shift_bits)
		ensure
			is_negative implies not old is_positive
			is_positive implies not old is_negative
		end

	bit_not_value: like Current
			-- Return the a bitwise NOT of `Current'
		do
			Result := identity
			Result.bit_not
		ensure
			is_negative implies not Result.is_positive
			is_positive implies not Result.is_negative
		end

	bit_shift_left_value alias "|<<" (bits_a: INTEGER): like Current
			-- Return `Current' bit shifted left `bits_a' bits
		require
			n_nonnegative: bits_a >= 0
		do
			Result := identity
			Result.bit_shift_left (bits_a)
		ensure
			is_negative implies not Result.is_positive
			is_positive implies not Result.is_negative
		end

	bit_shift_right_value alias "|>>" (bits_a: INTEGER): like Current
			-- Return `Current' bit shifted right `bits_a' bits, truncating lower bits
		require
			n_nonnegative: bits_a >= 0
		do
			Result := identity
			Result.bit_shift_right (bits_a)
		ensure
			is_negative implies not Result.is_positive
			is_positive implies not Result.is_negative
		end

	bit_test (bit_a: INTEGER): BOOLEAN
			-- Is bit at position `bit_a' set
		require
			n_nonnegative: bit_a >= 0
		do
			Result := bit_test_integer_x (Current, bit_a)
		end

	set_bit_value (value: BOOLEAN; bit_a: INTEGER): like Current
			-- Return a copy of `Current' with bit `bit_a' set if `value' is True
		require
			n_nonnegative: bit_a >= 0
		do
			Result := identity
			Result.set_bit (value, bit_a)
		ensure
			is_negative implies not Result.is_positive
			is_positive implies not Result.is_negative
		end

feature {INTEGER_X_FACILITIES}-- Discrete operations stateful

	powm (exponent: like Current; modulus: like Current)
			-- Modify `Current' to be (`Current' raised to `exponent') modulo `modulus'
			-- Negative `exponent' is supported if an inverse base^-1 mod mod exists {INTEGER_X}.invert
			-- If `exponent' does not have an inverse modulo `modulus', an {INVERSE_EXCEPTION} will be raised
		do
			powm_integer_x (Current, Current, exponent, modulus)
		end

	inverse (modulus: like Current)
			-- Set `Current' to be the inverse of `Current' modulo `modulus'
			-- If `Current' does not have an inverse modulo `modulus', an {INVERSE_EXCEPTION} will be raised
		local
			has_inverse: BOOLEAN
		do
			has_inverse := invert (Current, Current, modulus)
			if not has_inverse then
				(create {INVERSE_EXCEPTION}).raise
			end
		ensure
			coprime: coprime (modulus)
		end

	modulo (mod: like Current)
			-- Set `Current' to `Current' modulo `modulus'
		do
			mod_integer_x (Current, Current, mod)
		end

	gcd (op1: like Current; op2: like Current)
			-- Set `Current' to the Greatest Common Divisor between `op1' and `op2'
		do
			gcd_integer_x (Current, op1, op2)
		ensure
			positive_result: Current.is_positive
			op1.coprime (op2) = (Current ~ one)
		end

feature -- Discrete operations stateless

	powm_value (exponent: like Current; modulus: like Current): like Current
			-- Return (`Current' raised to `exponent') modulo `modulus'.
			-- Negative `exponent' is supported if an inverse base^-1 mod mod exists {INTEGER_X}.invert
			-- If an inverse doesn't exist then a divide by zero is raised
		do
			Result := identity
			Result.powm (exponent, modulus)
		end

	inverse_value (modulus: like Current): like Current
			-- Return the inverse of `Current' modulo `modulus'
			-- If `Current' does not have an inverse modulo `modulus', an {INVERSE_EXCEPTION} will be raised
		do
			Result := identity
			Result.inverse (modulus)
		ensure
			correct_result: ((Result * Current) \\ modulus) ~ (one)
			coprime: coprime (modulus)
		end

	modulo_value alias "\\" (modulus: like Current): like Current
			-- Return `Current' modulo `modulus'
		do
			Result := identity
			Result.modulo (modulus)
		end

	gcd_value (other: like Current): like Current
			-- Return the Greatest Common Divisor between `Current' and `other'
		do
			Result := identity
			Result.gcd (Current, other)
		ensure
			positive_result: Result.is_positive
			coprime (other) = (Result ~ one)
		end

	coprime (other: like Current): BOOLEAN
			-- Are `Current' and `other' coprime?
		do
			Result := gcd_value (other) ~ (one)
		ensure
			Result = (gcd_value (other) ~ (one))
		end

feature {INTEGER_X_FACILITIES}-- Galois field arithmetic stateful
	invert_gf (other: like Current)
		require
			not is_negative
			not other.is_negative
		do
			invert_gf_integer_x (Current, Current, other)
		ensure
			not is_negative
			other.identity ~ old other.identity
		end

feature -- Galois field arithmetic stateless
	invert_gf_value (other: like Current): like Current
		require
			not is_negative
			not other.is_negative
		do
			Result := identity
			Result.invert_gf (other)
		ensure
			not Result.is_negative
			identity ~ old identity
			other.identity ~ old other.identity
		end

feature -- Output

	debug_output: STRING
			-- Return a debug string of `Current'
		do
			Result := out_hex
		end

	out: STRING
			-- Return a hexicedimal representation of the value of `Current'
		do
			Result := out_hex
		end

	out_decimal: STRING
			-- Return a decimal representation of the value of `Current'
		do
			Result := out_base (10)
		end

	out_hex: STRING
			-- Return a hexidecimal representation ofthe value of `Current'
		do
			Result := out_base (16)
		end

	out_base (base: INTEGER_32): STRING
			-- Return a representation of `Current' in base `base'
		require
			base_too_small: base >= 2
			base_too_big: base <= 62
		do
			Result := get_string (Current, base)
		end

feature {NONE} -- Implementation

	random_state: RANDOM_NUMBER_GENERATOR
		once
			create {LINEAR_CONGRUENTIAL_RNG}Result.make (32)
		end

feature {INTEGER_X_FACILITIES}

	normalized: BOOLEAN
			-- Does `count' represent the number of non-zero limbs in `item'
		do
			Result := normalize (item, 0, count) = count
		end

	components_set (item_value: SPECIAL [NATURAL_32] count_value: INTEGER)
			-- Set `item' and `count' simultaneously
		do
			item_set (item_value)
			count_set (count_value)
		end

	capacity: INTEGER
			-- Number of limbs allocated in `item'
		do
			Result := item.capacity
		end

	item: SPECIAL [NATURAL_32] assign item_set
			-- Backing storage for the number

	item_set (value_a: SPECIAL [NATURAL_32])
			-- Change `item' to `value_a'
		do
			item := value_a
		end

	count: INTEGER assign count_set
			-- `count.abs' is the number of limbs in `item' that have meaning
			-- If `size' is negative this is a negative number.
		attribute
		end

	count_set (value_a: INTEGER)
			-- Change `count' to `value_a'
		do
			count := value_a
		end

	resize (new_alloc: INTEGER)
			-- Change the space for integer to at least `new_alloc' limbs.
		local
			allocate_size: INTEGER_32
		do
			if new_alloc > capacity then
				allocate_size := new_alloc.max (1)
				item := item.aliased_resized_area_with_default (0, allocate_size)
			end
		end

	set_components (item_a: SPECIAL [NATURAL_32] count_a: INTEGER)
		do
			item := item_a
			count := count_a
		end

invariant
--	normalized: normalized
	capacity >= 1
	count <= item.count
	item.count = item.capacity
end
