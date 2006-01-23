indexing
	description: "Implementation of TUPLE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE

inherit
	HASHABLE

	MISMATCH_CORRECTOR
		redefine
			correct_mismatch
		end

create
	default_create, make

feature -- Creation

	make is
		obsolete
			"Use no creation procedure to create a TUPLE instance"
		do
		end

feature -- Access

	item alias "[]", infix "@" (index: INTEGER): ANY assign put is
			-- Entry of key `index'.
		require
			valid_index: valid_index (index)
		do
			inspect eif_item_type ($Current, index)
			when boolean_code then Result := eif_boolean_item ($Current, index)
			when character_code then Result := eif_character_item ($Current, index)
			when wide_character_code then Result := eif_wide_character_item ($Current, index)
			when real_64_code then Result := eif_real_64_item ($Current, index)
			when real_32_code then Result := eif_real_32_item ($Current, index)
			when pointer_code then Result := eif_pointer_item ($Current, index)
			when natural_8_code then Result := eif_natural_8_item ($Current, index)
			when natural_16_code then Result := eif_natural_16_item ($Current, index)
			when natural_32_code then Result := eif_natural_32_item ($Current, index)
			when natural_64_code then Result := eif_natural_64_item ($Current, index)
			when integer_8_code then Result := eif_integer_8_item ($Current, index)
			when integer_16_code then Result := eif_integer_16_item ($Current, index)
			when integer_32_code then Result := eif_integer_32_item ($Current, index)
			when integer_64_code then Result := eif_integer_64_item ($Current, index)
			when Reference_code then Result := eif_reference_item ($Current, index)
			end
		end

	reference_item (index: INTEGER): ANY is
			-- Reference item at `index'.
		require
			valid_index: valid_index (index)
			is_reference: is_reference_item (index)
		do
			Result := eif_reference_item ($Current, index)
		end

	boolean_item (index: INTEGER): BOOLEAN is
			-- Boolean item at `index'.
		require
			valid_index: valid_index (index)
			is_boolean: is_boolean_item (index)
		do
			Result := eif_boolean_item ($Current, index)
		end

	character_item (index: INTEGER): CHARACTER is
			-- Character item at `index'.
		require
			valid_index: valid_index (index)
			is_character: is_character_item (index)
		do
			Result := eif_character_item ($Current, index)
		end

	wide_character_item (index: INTEGER): WIDE_CHARACTER is
			-- Character item at `index'.
		require
			valid_index: valid_index (index)
			is_wide_character: is_wide_character_item (index)
		do
			Result := eif_wide_character_item ($Current, index)
		end

	real_64_item, double_item (index: INTEGER): DOUBLE is
			-- Double item at `index'.
		require
			valid_index: valid_index (index)
			is_numeric: is_double_item (index)
		do
			Result := eif_real_64_item ($Current, index)
		end

	natural_8_item (index: INTEGER): NATURAL_8 is
			-- NATURAL_8 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_8_item (index)
		do
			Result := eif_natural_8_item ($Current, index)
		end

	natural_16_item (index: INTEGER): NATURAL_16 is
			-- NATURAL_16 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_16_item (index)
		do
			Result := eif_natural_16_item ($Current, index)
		end

	natural_32_item (index: INTEGER): NATURAL_32 is
			-- NATURAL_32 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_32_item (index)
		do
			Result := eif_natural_32_item ($Current, index)
		end

	natural_64_item (index: INTEGER): NATURAL_64 is
			-- NATURAL_64 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_64_item (index)
		do
			Result := eif_natural_64_item ($Current, index)
		end

	integer_8_item (index: INTEGER): INTEGER_8 is
			-- INTEGER_8 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_8_item (index)
		do
			Result := eif_integer_8_item ($Current, index)
		end

	integer_16_item (index: INTEGER): INTEGER_16 is
			-- INTEGER_16 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_16_item (index)
		do
			Result := eif_integer_16_item ($Current, index)
		end

	integer_item, integer_32_item (index: INTEGER): INTEGER is
			-- INTEGER_32 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_32_item (index)
		do
			Result := eif_integer_32_item ($Current, index)
		end

	integer_64_item (index: INTEGER): INTEGER_64 is
			-- INTEGER_64 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_64_item (index)
		do
			Result := eif_integer_64_item ($Current, index)
		end

	pointer_item (index: INTEGER): POINTER is
			-- Pointer item at `index'.
		require
			valid_index: valid_index (index)
			is_pointer: is_pointer_item (index)
		do
			Result := eif_pointer_item ($Current, index)
		end

	real_32_item, real_item (index: INTEGER): REAL is
			-- real item at `index'.
		require
			valid_index: valid_index (index)
			is_real_or_integer: is_real_item (index)
		do
			Result := eif_real_32_item ($Current, index)
		end

feature -- Status report

	hash_code: INTEGER is
			-- Hash code value
		local
			i, nb, l_hash: INTEGER
			l_key: HASHABLE
		do
			from
				i := 1
				nb := count
			until
				i > nb
			loop
				inspect eif_item_type($Current, i)
				when boolean_code then l_hash := eif_boolean_item ($Current, i).hash_code
				when character_code then l_hash := eif_character_item ($Current, i).hash_code
				when wide_character_code then l_hash := eif_wide_character_item ($Current, i).hash_code
				when real_64_code then l_hash := eif_real_64_item ($Current, i).hash_code
				when real_32_code then l_hash := eif_real_32_item ($Current, i).hash_code
				when pointer_code then l_hash := eif_pointer_item ($Current, i).hash_code
				when natural_8_code then l_hash := eif_natural_8_item ($Current, i).hash_code
				when natural_16_code then l_hash := eif_natural_16_item ($Current, i).hash_code
				when natural_32_code then l_hash := eif_natural_32_item ($Current, i).hash_code
				when natural_64_code then l_hash := eif_natural_64_item ($Current, i).hash_code
				when integer_8_code then l_hash := eif_integer_8_item ($Current, i).hash_code
				when integer_16_code then l_hash := eif_integer_16_item ($Current, i).hash_code
				when integer_32_code then l_hash := eif_integer_32_item ($Current, i).hash_code
				when integer_64_code then l_hash := eif_integer_64_item ($Current, i).hash_code
				when reference_code then
					l_key ?= eif_reference_item ($Current, i)
					if l_key /= Void then
						l_hash := l_key.hash_code
					else
						l_hash := 0
					end
				end
				Result := Result + l_hash * internal_primes.i_th (i)
				i := i + 1
			end
				-- Ensure it is a positive value.
			Result := Result.hash_code
		end

	valid_index (k: INTEGER): BOOLEAN is
			-- Is `k' a valid key?
		do
			Result := k >= 1 and then k <= count
		end

	valid_type_for_index (v: ANY; index: INTEGER): BOOLEAN is
			-- Is object `v' a valid target for element at position `index'?
		require
			valid_index: valid_index (index)
		local
			l_b: BOOLEAN_REF
			l_c: CHARACTER_REF
			l_wc: WIDE_CHARACTER_REF
			l_d: DOUBLE_REF
			l_r: REAL_REF
			l_p: POINTER_REF
			l_ui8: NATURAL_8_REF
			l_ui16: NATURAL_16_REF
			l_ui32: NATURAL_32_REF
			l_ui64: NATURAL_64_REF
			l_i8: INTEGER_8_REF
			l_i16: INTEGER_16_REF
			l_i32: INTEGER_REF
			l_i64: INTEGER_64_REF
			l_int: INTERNAL
		do
			if v = Void then
					-- A Void entry is always valid.
				Result := True
			else
				inspect eif_item_type ($Current, index)
				when boolean_code then l_b ?= v; Result := l_b /= Void
				when character_code then l_c ?= v; Result := l_c /= Void
				when wide_character_code then l_wc ?= v; Result := l_wc /= Void
				when real_64_code then l_d ?= v; Result := l_d /= Void
				when real_32_code then l_r ?= v; Result := l_r /= Void
				when pointer_code then l_p ?= v; Result := l_p /= Void
				when natural_8_code then l_ui8 ?= v; Result := l_ui8 /= Void
				when natural_16_code then l_ui16 ?= v; Result := l_ui16 /= Void
				when natural_32_code then l_ui32 ?= v; Result := l_ui32 /= Void
				when natural_64_code then l_ui64 ?= v; Result := l_ui64 /= Void
				when integer_8_code then l_i8 ?= v; Result := l_i8 /= Void
				when integer_16_code then l_i16 ?= v; Result := l_i16 /= Void
				when integer_32_code then l_i32 ?= v; Result := l_i32 /= Void
				when integer_64_code then l_i64 ?= v; Result := l_i64 /= Void
				when Reference_code then	
						-- Let's check that type of `v' conforms to specified type of `index'-th
						-- arguments of current TUPLE.
					create l_int
					Result := l_int.type_conforms_to
						(l_int.dynamic_type (v), l_int.generic_dynamic_type (Current, index))
				end
			end
		end

	count: INTEGER is
			-- Number of element in Current.
		do
				-- `-1' because we always allocate one item more to avoid
				-- to do `-1' each time we want to access or store an item
				-- of current.
			Result := {ISE_RUNTIME}.sp_count ($Current) - 1
		end

	lower: INTEGER is 1
			-- Lower bound of TUPLE.

	upper: INTEGER is
			-- Upper bound of TUPLE.
		do
			Result := count
		end

	is_empty: BOOLEAN is
			-- Is Current empty?
		do
			Result := count = 0
		end

feature -- Element change

	put (v: ANY; index: INTEGER) is
			-- Insert `v' at position `index'.
		require
			valid_index: valid_index (index)
			valid_type_for_index: valid_type_for_index (v, index)
		do
			inspect eif_item_type ($Current, index)
			when boolean_code then eif_put_boolean_item_with_object ($Current, index, $v)
			when character_code then eif_put_character_item_with_object ($Current, index, $v)
			when wide_character_code then eif_put_wide_character_item_with_object ($Current, index, $v)
			when real_64_code then eif_put_real_64_item_with_object ($Current, index, $v)
			when real_32_code then eif_put_real_32_item_with_object ($Current, index, $v)
			when pointer_code then eif_put_pointer_item_with_object ($Current, index, $v)
			when natural_8_code then eif_put_natural_8_item_with_object ($Current, index, $v)
			when natural_16_code then eif_put_natural_16_item_with_object ($Current, index, $v)
			when natural_32_code then eif_put_natural_32_item_with_object ($Current, index, $v)
			when natural_64_code then eif_put_natural_64_item_with_object ($Current, index, $v)
			when integer_8_code then eif_put_integer_8_item_with_object ($Current, index, $v)
			when integer_16_code then eif_put_integer_16_item_with_object ($Current, index, $v)
			when integer_32_code then eif_put_integer_32_item_with_object ($Current, index, $v)
			when integer_64_code then eif_put_integer_64_item_with_object ($Current, index, $v)
			when Reference_code then eif_put_reference_item_with_object ($Current, index, $v)
			end
		end

	put_reference (v: ANY; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_reference_item (index)
		do
			eif_put_reference_item_with_object ($Current, index, $v)
		end

	put_boolean (v: BOOLEAN; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_boolean_item (index)
		do
			eif_put_boolean_item ($Current, index, v)
		end

	put_character (v: CHARACTER; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_character_item (index)
		do
			eif_put_character_item ($Current, index, v)
		end

	put_wide_character (v: WIDE_CHARACTER; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_wide_character_item (index)
		do
			eif_put_wide_character_item ($Current, index, v)
		end

	put_real_64, put_double (v: DOUBLE; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_double_item (index)
		do
			eif_put_real_64_item ($Current, index, v)
		end

	put_real_32, put_real (v: REAL; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_real_item (index)
		do
			eif_put_real_32_item ($Current, index, v)
		end

	put_pointer (v: POINTER; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_pointer_item (index)
		do
			eif_put_pointer_item ($Current, index, v)
		end

	put_natural_8 (v: NATURAL_8; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_8_item (index)
		do
			eif_put_natural_8_item ($Current, index, v)
		end

	put_natural_16 (v: NATURAL_16; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_16_item (index)
		do
			eif_put_natural_16_item ($Current, index, v)
		end

	put_natural_32 (v: NATURAL_32; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_32_item (index)
		do
			eif_put_natural_32_item ($Current, index, v)
		end

	put_natural_64 (v: NATURAL_64; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_64_item (index)
		do
			eif_put_natural_64_item ($Current, index, v)
		end

	put_integer, put_integer_32 (v: INTEGER; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_32_item (index)
		do
			eif_put_integer_32_item ($Current, index, v)
		end

	put_integer_8 (v: INTEGER_8; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_8_item (index)
		do
			eif_put_integer_8_item ($Current, index, v)
		end

	put_integer_16 (v: INTEGER_16; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_16_item (index)
		do
			eif_put_integer_16_item ($Current, index, v)
		end

	put_integer_64 (v: INTEGER_64; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_64_item (index)
		do
			eif_put_integer_64_item ($Current, index, v)
		end

feature -- Type queries

	is_boolean_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a BOOLEAN?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = boolean_code)
		end

	is_character_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a CHARACTER?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = character_code)
		end

	is_wide_character_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a WIDE_CHARACTER?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = wide_character_code)
		end

	is_double_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a DOUBLE?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = real_64_code)
		end

	is_natural_8_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an NATURAL_8?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = natural_8_code)
		end

	is_natural_16_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an NATURAL_16?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = natural_16_code)
		end

	is_natural_32_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an NATURAL_32?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = natural_32_code)
		end

	is_natural_64_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an NATURAL_64?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = natural_64_code)
		end

	is_integer_8_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER_8?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = integer_8_code)
		end

	is_integer_16_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER_16?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = integer_16_code)
		end

	is_integer_item, is_integer_32_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER_32?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = integer_32_code)
		end

	is_integer_64_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER_64?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = integer_64_code)
		end

	is_pointer_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a POINTER?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = pointer_code)
		end

	is_real_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a REAL?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = real_32_code)
		end

	is_reference_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a REFERENCE?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = reference_code)
		end

	is_numeric_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a number?
		obsolete
			"Use the precise type query instead."
		require
			valid_index: valid_index (index)
		local
			tcode: like item_code
		do
			tcode := eif_item_type ($Current, index)
			inspect tcode
			when
				integer_8_code, integer_16_code, integer_32_code,
				integer_64_code, real_32_code, real_64_code
			then
				Result := True
			else
				-- Nothing to do here since Result already initialized to False.
			end
		end

	is_uniform: BOOLEAN is
			-- Are all items of the same basic type or all of reference type?
		do
			Result := is_tuple_uniform (any_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_boolean: BOOLEAN is
			-- Are all items of type BOOLEAN?
		do
			Result := is_tuple_uniform (boolean_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_character: BOOLEAN is
			-- Are all items of type CHARACTER?
		do
			Result := is_tuple_uniform (character_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_wide_character: BOOLEAN is
			-- Are all items of type WIDE_CHARACTER?
		do
			Result := is_tuple_uniform (wide_character_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_double: BOOLEAN is
			-- Are all items of type DOUBLE?
		do
			Result := is_tuple_uniform (real_64_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_natural_8: BOOLEAN is
			-- Are all items of type NATURAL_8?
		do
			Result := is_tuple_uniform (natural_8_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_natural_16: BOOLEAN is
			-- Are all items of type NATURAL_16?
		do
			Result := is_tuple_uniform (natural_16_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_natural_32: BOOLEAN is
			-- Are all items of type NATURAL_32?
		do
			Result := is_tuple_uniform (natural_32_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_natural_64: BOOLEAN is
			-- Are all items of type NATURAL_64?
		do
			Result := is_tuple_uniform (natural_64_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_integer_8: BOOLEAN is
			-- Are all items of type INTEGER_8?
		do
			Result := is_tuple_uniform (integer_8_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_integer_16: BOOLEAN is
			-- Are all items of type INTEGER_16?
		do
			Result := is_tuple_uniform (integer_16_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_integer, is_uniform_integer_32: BOOLEAN is
			-- Are all items of type INTEGER?
		do
			Result := is_tuple_uniform (integer_32_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_integer_64: BOOLEAN is
			-- Are all items of type INTEGER_64?
		do
			Result := is_tuple_uniform (integer_64_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_pointer: BOOLEAN is
			-- Are all items of type POINTER?
		do
			Result := is_tuple_uniform (pointer_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_real: BOOLEAN is
			-- Are all items of type REAL?
		do
			Result := is_tuple_uniform (real_32_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_reference: BOOLEAN is
			-- Are all items of reference type?
		do
			Result := is_tuple_uniform (reference_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

feature -- Type conversion queries

	convertible_to_double: BOOLEAN is
			-- Is current convertible to an array of doubles?
		obsolete
			"Will be removed in future releases"
		local
			i, cnt: INTEGER
			tcode: like item_code
		do
			Result := True
			from
				i := 1
				cnt := count
			until
				i > cnt or else not Result
			loop
				tcode := eif_item_type ($Current, i)
				inspect tcode
				when
					integer_8_code, integer_16_code, integer_32_code,
					integer_64_code, real_32_code, real_64_code
				then
					Result := True
				else
					Result := False
				end
				i := i + 1
			end
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	convertible_to_real: BOOLEAN is
			-- Is current convertible to an array of reals?
		obsolete
			"Will be removed in future releases"
		local
			i, cnt: INTEGER
			tcode: like item_code
		do
			Result := True
			from
				i := 1
				cnt := count
			until
				i > cnt or else not Result
			loop
				tcode := eif_item_type ($Current, i)
				inspect tcode
				when
					integer_8_code, integer_16_code, integer_32_code,
					integer_64_code, real_32_code
				then
					Result := True
				else
					Result := False
				end
				i := i + 1
			end
		ensure
			yes_if_empty: (count = 0) implies Result
		end

feature -- Conversion

	arrayed: ARRAY [ANY] is
			-- Items of Current as array
		obsolete
			"Will be removed in future releases"
		local
			i, cnt: INTEGER
		do
			from
				i := 1
				cnt := count
				create Result.make (1, cnt)
			until
				i > cnt
			loop
				Result.put (item (i), i)
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
			same_items: -- Items are the same in same order
		end

	boolean_arrayed: ARRAY [BOOLEAN] is
			-- Items of Current as array
		obsolete
			"Will be removed in future releases"
		require
			is_uniform_boolean: is_uniform_boolean
		local
			i, cnt: INTEGER
		do
			from
				i := 1
				cnt := count
				create Result.make (1, cnt)
			until
				i > cnt
			loop
				Result.put (boolean_item (i), i)
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
			same_items: -- Items are the same in same order
		end

	character_arrayed: ARRAY [CHARACTER] is
			-- Items of Current as array
		obsolete
			"Will be removed in future releases"
		require
			is_uniform_character: is_uniform_character
		local
			i, cnt: INTEGER
		do
			from
				i := 1
				cnt := count
				create Result.make (1, cnt)
			until
				i > cnt
			loop
				Result.put (character_item (i), i)
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
			same_items: -- Items are the same in same order
		end

	double_arrayed: ARRAY [DOUBLE] is
			-- Items of Current as array
		obsolete
			"Will be removed in future releases"
		require
			convertible: convertible_to_double
		local
			i, cnt: INTEGER
		do
			from
				i := 1
				cnt := count
				create Result.make (1, cnt)
			until
				i > cnt
			loop
				Result.put (double_item (i), i)
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
			same_items: -- Items are the same in same order
		end

	integer_arrayed: ARRAY [INTEGER] is
			-- Items of Current as array
		obsolete
			"Will be removed in future releases"
		require
			is_uniform_integer: is_uniform_integer
		local
			i, cnt: INTEGER
		do
			from
				i := 1
				cnt := count
				create Result.make (1, cnt)
			until
				i > cnt
			loop
				Result.put (integer_32_item (i), i)
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
			same_items: -- Items are the same in same order
		end

	pointer_arrayed: ARRAY [POINTER] is
			-- Items of Current as array
		obsolete
			"Will be removed in future releases"
		require
			is_uniform_pointer: is_uniform_pointer
		local
			i, cnt: INTEGER
		do
			from
				i := 1
				cnt := count
				create Result.make (1, cnt)
			until
				i > cnt
			loop
				Result.put (pointer_item (i), i)
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
			same_items: -- Items are the same in same order
		end

	real_arrayed: ARRAY [REAL] is
			-- Items of Current as array
		obsolete
			"Will be removed in future releases"
		require
			convertible: convertible_to_real
		local
			i, cnt: INTEGER
		do
			from
				i := 1
				cnt := count
				create Result.make (1, cnt)
			until
				i > cnt
			loop
				Result.put (real_item (i), i)
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
			same_items: -- Items are the same in same order
		end

	string_arrayed: ARRAY [STRING] is
			-- Items of Current as array
			-- NOTE: Items with a type not cconforming to
			--       type STRING are set to Void.
		obsolete
			"Will be removed in future releases"
		local
			i, cnt: INTEGER
			s: STRING
		do
			from
				i := 1
				cnt := count
				create Result.make (1, cnt)
			until
				i > cnt
			loop
				s ?= item (i)
				Result.put (s, i)
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
		end

feature -- Retrieval

	correct_mismatch is
			-- Attempt to correct object mismatch using `mismatch_information'.
		local
			l_area: SPECIAL [ANY]
			i, nb: INTEGER
			l_any: ANY
		do
				-- Old version of TUPLE had a SPECIAL [ANY] to store all values.
				-- If we can get access to it, then most likely we can recover this
				-- old TUPLE implementation.
			l_area ?= Mismatch_information.item (area_name)
			if l_area /= Void then
				from
					i := 1
					nb := l_area.count
				until
					i > nb
				loop
					l_any := l_area.item (i - 1)
					if valid_type_for_index (l_any, i) then
						put (l_any, i)
					else
							-- We found an unexpected type in old special. We cannot go on.
						Precursor {MISMATCH_CORRECTOR}
					end
					i := i + 1
				end
			else
				Precursor {MISMATCH_CORRECTOR}
			end
		end

feature -- Access

	item_code (index: INTEGER): NATURAL_8 is
			-- Type code of item at `index'. Used for
			-- argument processing in ROUTINE
		require
			valid_index: valid_index (index)
		do
			Result := eif_item_type ($Current, index)
		end

	reference_code: NATURAL_8 is 0x00
	boolean_code: NATURAL_8 is 0x01
	character_code: NATURAL_8 is 0x02
	real_64_code: NATURAL_8 is 0x03
	real_32_code: NATURAL_8 is 0x04
	pointer_code: NATURAL_8 is 0x05
	integer_8_code: NATURAL_8 is 0x06
	integer_16_code: NATURAL_8 is 0x07
	integer_32_code: NATURAL_8 is 0x08
	integer_64_code: NATURAL_8 is 0x09
	natural_8_code: NATURAL_8 is 0x0A
	natural_16_code: NATURAL_8 is 0x0B
	natural_32_code: NATURAL_8 is 0x0C
	natural_64_code: NATURAL_8 is 0x0D
	wide_character_code: NATURAL_8 is 0x0E
	any_code: NATURAL_8 is 0xFF
			-- Code used to identify type in TUPLE.

feature {NONE} -- Implementation

	area_name: STRING is "area"
			-- Name of attributes where TUPLE elements were stored.

	is_tuple_uniform (code: like item_code): BOOLEAN is
			-- Are all items of type `code'?
		local
			i, nb: INTEGER
			l_code: like item_code
		do
			Result := True
			if count > 0 then
				from
					nb := count
					if code = any_code then
							-- We take first type code and compare all the remaining ones
							-- against it.
						i := 2
						l_code := eif_item_type ($Current, 1)
					else
						i := 1
						l_code := code
					end
				until
					i > nb or not Result
				loop
					Result := l_code = eif_item_type ($Current, i)
					i := i + 1
				end
			end
		end

	internal_primes: PRIMES is
			-- For quick access to prime numbers.
		once
			create Result
		end

feature {NONE} -- Externals: Access

	eif_item_type (obj: POINTER; pos: INTEGER): NATURAL_8 is
			-- Code for generic parameter `pos' in `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		alias
			"eif_item_type"
		end

	eif_boolean_item (obj: POINTER; pos: INTEGER): BOOLEAN is
			-- Boolean item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_character_item (obj: POINTER; pos: INTEGER): CHARACTER is
			-- Character item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_wide_character_item (obj: POINTER; pos: INTEGER): WIDE_CHARACTER is
			-- Wide character item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_real_64_item (obj: POINTER; pos: INTEGER): DOUBLE is
			-- Double item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_real_32_item (obj: POINTER; pos: INTEGER): REAL is
			-- Real item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_pointer_item (obj: POINTER; pos: INTEGER): POINTER is
			-- Pointer item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_natural_8_item (obj: POINTER; pos: INTEGER): NATURAL_8 is
			-- NATURAL_8 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_natural_16_item (obj: POINTER; pos: INTEGER):  NATURAL_16 is
			-- NATURAL_16 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_natural_32_item (obj: POINTER; pos: INTEGER):  NATURAL_32 is
			-- NATURAL_32 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_natural_64_item (obj: POINTER; pos: INTEGER):  NATURAL_64 is
			-- NATURAL_64 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_integer_8_item (obj: POINTER; pos: INTEGER): INTEGER_8 is
			-- INTEGER_8 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_integer_16_item (obj: POINTER; pos: INTEGER): INTEGER_16 is
			-- INTEGER_16 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_integer_32_item (obj: POINTER; pos: INTEGER): INTEGER is
			-- INTEGER_32 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_integer_64_item (obj: POINTER; pos: INTEGER): INTEGER_64 is
			-- INTEGER_64 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_reference_item (obj: POINTER; pos: INTEGER): ANY is
			-- Reference item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

feature {NONE} -- Externals: Setting

	eif_put_boolean_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set boolean item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_character_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set character item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_wide_character_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set wide character item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_real_64_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set double item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_real_32_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set real item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_pointer_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set pointer item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_8_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set NATURAL_8 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_16_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set NATURAL_16 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_32_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set NATURAL_32 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_64_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set NATURAL_64 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_8_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set integer_8 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_16_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set integer_16 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_32_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set integer_32 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_64_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set integer_64 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_reference_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set reference item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_boolean_item (obj: POINTER; pos: INTEGER; v: BOOLEAN) is
			-- Set boolean item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_character_item (obj: POINTER; pos: INTEGER; v: CHARACTER) is
			-- Set character item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_wide_character_item (obj: POINTER; pos: INTEGER; v: WIDE_CHARACTER) is
			-- Set wide character item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_real_64_item (obj: POINTER; pos: INTEGER; v: DOUBLE) is
			-- Set double item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_real_32_item (obj: POINTER; pos: INTEGER; v: REAL) is
			-- Set real item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_pointer_item (obj: POINTER; pos: INTEGER; v: POINTER) is
			-- Set pointer item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_8_item (obj: POINTER; pos: INTEGER; v: NATURAL_8) is
			-- Set NATURAL_8 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_16_item (obj: POINTER; pos: INTEGER; v: NATURAL_16) is
			-- Set NATURAL_16 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_32_item (obj: POINTER; pos: INTEGER; v: NATURAL_32) is
			-- Set NATURAL_32 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_64_item (obj: POINTER; pos: INTEGER; v: NATURAL_64) is
			-- Set NATURAL_64 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_8_item (obj: POINTER; pos: INTEGER; v: INTEGER_8) is
			-- Set integer_8 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_16_item (obj: POINTER; pos: INTEGER; v: INTEGER_16) is
			-- Set integer_16 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_32_item (obj: POINTER; pos: INTEGER; v: INTEGER) is
			-- Set integer_32 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_64_item (obj: POINTER; pos: INTEGER; v: INTEGER_64) is
			-- Set integer_64 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"







end -- class TUPLE

