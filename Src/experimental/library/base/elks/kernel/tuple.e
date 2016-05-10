note
	description: "Implementation of TUPLE"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE

inherit
	HASHABLE
		redefine
			is_equal
		end

	MISMATCH_CORRECTOR
		redefine
			correct_mismatch, is_equal
		end

	READABLE_INDEXABLE [detachable separate ANY]
		rename
			upper as count
		redefine
			is_equal
		end

create
	default_create

feature -- Access

	item alias "[]", at alias "@" (index: INTEGER): detachable separate ANY assign put
			-- Entry of key `index'.
		do
			inspect eif_item_type ($Current, index)
			when boolean_code then Result := eif_boolean_item ($Current, index)
			when character_8_code then Result := eif_character_8_item ($Current, index)
			when character_32_code then Result := eif_character_32_item ($Current, index)
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

	reference_item (index: INTEGER): detachable separate ANY
			-- Reference item at `index'.
		require
			valid_index: valid_index (index)
			is_reference: is_reference_item (index)
		do
			Result := eif_reference_item ($Current, index)
		end

	boolean_item (index: INTEGER): BOOLEAN
			-- Boolean item at `index'.
		require
			valid_index: valid_index (index)
			is_boolean: is_boolean_item (index)
		do
			Result := eif_boolean_item ($Current, index)
		end

	character_8_item, character_item (index: INTEGER): CHARACTER_8
			-- Character item at `index'.
		require
			valid_index: valid_index (index)
			is_character_8: is_character_8_item (index)
		do
			Result := eif_character_8_item ($Current, index)
		end

	character_32_item, wide_character_item (index: INTEGER): CHARACTER_32
			-- Character item at `index'.
		require
			valid_index: valid_index (index)
			is_character_32: is_character_32_item (index)
		do
			Result := eif_character_32_item ($Current, index)
		end

	real_64_item, double_item (index: INTEGER): REAL_64
			-- Double item at `index'.
		require
			valid_index: valid_index (index)
			is_numeric: is_double_item (index)
		do
			Result := eif_real_64_item ($Current, index)
		end

	natural_8_item (index: INTEGER): NATURAL_8
			-- NATURAL_8 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_8_item (index)
		do
			Result := eif_natural_8_item ($Current, index)
		end

	natural_16_item (index: INTEGER): NATURAL_16
			-- NATURAL_16 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_16_item (index)
		do
			Result := eif_natural_16_item ($Current, index)
		end

	natural_32_item (index: INTEGER): NATURAL_32
			-- NATURAL_32 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_32_item (index)
		do
			Result := eif_natural_32_item ($Current, index)
		end

	natural_64_item (index: INTEGER): NATURAL_64
			-- NATURAL_64 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_64_item (index)
		do
			Result := eif_natural_64_item ($Current, index)
		end

	integer_8_item (index: INTEGER): INTEGER_8
			-- INTEGER_8 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_8_item (index)
		do
			Result := eif_integer_8_item ($Current, index)
		end

	integer_16_item (index: INTEGER): INTEGER_16
			-- INTEGER_16 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_16_item (index)
		do
			Result := eif_integer_16_item ($Current, index)
		end

	integer_item, integer_32_item (index: INTEGER): INTEGER_32
			-- INTEGER_32 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_32_item (index)
		do
			Result := eif_integer_32_item ($Current, index)
		end

	integer_64_item (index: INTEGER): INTEGER_64
			-- INTEGER_64 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_64_item (index)
		do
			Result := eif_integer_64_item ($Current, index)
		end

	pointer_item (index: INTEGER): POINTER
			-- Pointer item at `index'.
		require
			valid_index: valid_index (index)
			is_pointer: is_pointer_item (index)
		do
			Result := eif_pointer_item ($Current, index)
		end

	real_32_item, real_item (index: INTEGER): REAL_32
			-- real item at `index'.
		require
			valid_index: valid_index (index)
			is_real_or_integer: is_real_item (index)
		do
			Result := eif_real_32_item ($Current, index)
		end
feature -- Comparison

	object_comparison: BOOLEAN
			-- Must search operations use `equal' rather than `='
			-- for comparing references? (Default: no, use `='.)
		do
			Result := eif_boolean_item ($Current, 0)
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		local
			i, nb: INTEGER
			l_object_compare: BOOLEAN
		do
			l_object_compare := object_comparison
			if l_object_compare = other.object_comparison then
				if l_object_compare then
					nb := count
					if nb = other.count then
						from
							Result := True
							i := 1
						until
							i > nb or not Result
						loop
							Result := item (i) ~ other.item (i)
							i := i + 1
						end
					end
				else
					Result := Precursor {HASHABLE} (other)
				end
			end
		end

feature -- Status setting

	compare_objects
			-- Ensure that future search operations will use `equal'
			-- rather than `=' for comparing references.
		do
			eif_put_boolean_item ($Current, 0, True)
		ensure
			object_comparison: object_comparison
		end

	compare_references
			-- Ensure that future search operations will use `='
			-- rather than `equal' for comparing references.
		do
			eif_put_boolean_item ($Current, 0, False)
		ensure
			reference_comparison: not object_comparison
		end

feature -- Status report

	hash_code: INTEGER
			-- Hash code value
		local
			i, nb, l_hash: INTEGER
		do
			from
				i := 1
				nb := count
			until
				i > nb
			loop
				inspect eif_item_type($Current, i)
				when boolean_code then l_hash := eif_boolean_item ($Current, i).hash_code
				when character_8_code then l_hash := eif_character_8_item ($Current, i).hash_code
				when character_32_code then l_hash := eif_character_32_item ($Current, i).hash_code
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
					if attached {HASHABLE} eif_reference_item ($Current, i) as l_key then
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

	valid_index (k: INTEGER): BOOLEAN
			-- Is `k' a valid key?
		do
			Result := k >= 1 and then k <= count
		end

	valid_type_for_index (v: detachable separate ANY; index: INTEGER): BOOLEAN
			-- Is object `v' a valid target for element at position `index'?
		require
			valid_index: valid_index (index)
		local
			l_reflector: REFLECTOR
			l_type_id: INTEGER
		do
			if v = Void then
					-- A Void entry is valid only for references and as long as the expected type
					-- is detachable.
				if eif_item_type ($Current, index) = reference_code then
					Result := not generating_type.generic_parameter_type (index).is_attached
				end
			else
				inspect eif_item_type ($Current, index)
				when boolean_code then Result := attached {BOOLEAN_REF} v as l_b
				when character_8_code then Result := attached {CHARACTER_8_REF} v as l_c
				when character_32_code then Result := attached {CHARACTER_32_REF} v as l_wc
				when real_64_code then Result := attached {REAL_64_REF} v as l_d
				when real_32_code then Result := attached {REAL_32_REF} v as l_r
				when pointer_code then Result := attached {POINTER_REF} v as l_p
				when natural_8_code then Result := attached {NATURAL_8_REF} v as l_ui8
				when natural_16_code then Result := attached {NATURAL_16_REF} v as l_ui16
				when natural_32_code then Result := attached {NATURAL_32_REF} v as l_ui32
				when natural_64_code then Result := attached {NATURAL_64_REF} v as l_ui64
				when integer_8_code then Result := attached {INTEGER_8_REF} v as l_i8
				when integer_16_code then Result := attached {INTEGER_16_REF} v as l_i16
				when integer_32_code then Result := attached {INTEGER_32_REF} v as l_i32
				when integer_64_code then Result := attached {INTEGER_64_REF} v as l_i64
				when Reference_code then
						-- Let's check that type of `v' conforms to specified type of `index'-th
						-- arguments of current TUPLE.
					create l_reflector
						--| FIXME
						--| Replace this line with the commented line once we solve the nature
						--| of type instances in a SCOOP context.
					l_type_id := {ISE_RUNTIME}.dynamic_type (v)
--					l_type_id := v.generating_type.type_id
					Result := l_reflector.field_conforms_to (l_type_id, generating_type.generic_parameter_type (index).type_id)
				end
			end
		end

	count: INTEGER
			-- Number of element in Current.
		external
			"built_in"
		end

	lower: INTEGER = 1
			-- Lower bound of TUPLE.

	upper: INTEGER
			-- Upper bound of TUPLE.
			-- Use `count' instead.
		do
			Result := count
		ensure
			definition: Result = count
		end

	is_empty: BOOLEAN
			-- Is Current empty?
		do
			Result := count = 0
		end

feature -- Element change

	put (v: detachable separate ANY; index: INTEGER)
			-- Insert `v' at position `index'.
		require
			valid_index: valid_index (index)
			valid_type_for_index: valid_type_for_index (v, index)
		do
			inspect eif_item_type ($Current, index)
			when boolean_code then eif_put_boolean_item_with_object ($Current, index, $v)
			when character_8_code then eif_put_character_8_item_with_object ($Current, index, $v)
			when character_32_code then eif_put_character_32_item_with_object ($Current, index, $v)
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

	put_reference (v: detachable separate ANY; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type_for_index: valid_type_for_index (v, index)
			valid_type: is_reference_item (index)
		do
			eif_put_reference_item_with_object ($Current, index, $v)
		end

	put_boolean (v: BOOLEAN; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_boolean_item (index)
		do
			eif_put_boolean_item ($Current, index, v)
		end

	put_character_8, put_character (v: CHARACTER_8; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_character_8_item (index)
		do
			eif_put_character_8_item ($Current, index, v)
		end

	put_character_32, put_wide_character (v: CHARACTER_32; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_character_32_item (index)
		do
			eif_put_character_32_item ($Current, index, v)
		end

	put_real_64, put_double (v: REAL_64; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_double_item (index)
		do
			eif_put_real_64_item ($Current, index, v)
		end

	put_real_32, put_real (v: REAL_32; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_real_item (index)
		do
			eif_put_real_32_item ($Current, index, v)
		end

	put_pointer (v: POINTER; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_pointer_item (index)
		do
			eif_put_pointer_item ($Current, index, v)
		end

	put_natural_8 (v: NATURAL_8; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_8_item (index)
		do
			eif_put_natural_8_item ($Current, index, v)
		end

	put_natural_16 (v: NATURAL_16; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_16_item (index)
		do
			eif_put_natural_16_item ($Current, index, v)
		end

	put_natural_32 (v: NATURAL_32; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_32_item (index)
		do
			eif_put_natural_32_item ($Current, index, v)
		end

	put_natural_64 (v: NATURAL_64; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_64_item (index)
		do
			eif_put_natural_64_item ($Current, index, v)
		end

	put_integer, put_integer_32 (v: INTEGER_32; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_32_item (index)
		do
			eif_put_integer_32_item ($Current, index, v)
		end

	put_integer_8 (v: INTEGER_8; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_8_item (index)
		do
			eif_put_integer_8_item ($Current, index, v)
		end

	put_integer_16 (v: INTEGER_16; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_16_item (index)
		do
			eif_put_integer_16_item ($Current, index, v)
		end

	put_integer_64 (v: INTEGER_64; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_64_item (index)
		do
			eif_put_integer_64_item ($Current, index, v)
		end

feature -- Type queries

	is_boolean_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a BOOLEAN?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = boolean_code)
		end

	is_character_8_item, is_character_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a CHARACTER_8?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = character_8_code)
		end

	is_character_32_item, is_wide_character_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a CHARACTER_32?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = character_32_code)
		end

	is_double_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a REAL_64?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = real_64_code)
		end

	is_natural_8_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an NATURAL_8?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = natural_8_code)
		end

	is_natural_16_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an NATURAL_16?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = natural_16_code)
		end

	is_natural_32_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an NATURAL_32?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = natural_32_code)
		end

	is_natural_64_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an NATURAL_64?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = natural_64_code)
		end

	is_integer_8_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an INTEGER_8?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = integer_8_code)
		end

	is_integer_16_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an INTEGER_16?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = integer_16_code)
		end

	is_integer_item, is_integer_32_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an INTEGER_32?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = integer_32_code)
		end

	is_integer_64_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an INTEGER_64?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = integer_64_code)
		end

	is_pointer_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a POINTER?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = pointer_code)
		end

	is_real_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a REAL_32?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = real_32_code)
		end

	is_reference_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a REFERENCE?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_item_type ($Current, index) = reference_code)
		end

	is_numeric_item (index: INTEGER): BOOLEAN
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

	is_uniform: BOOLEAN
			-- Are all items of the same basic type or all of reference type?
		do
			Result := is_tuple_uniform (any_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_boolean: BOOLEAN
			-- Are all items of type BOOLEAN?
		do
			Result := is_tuple_uniform (boolean_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_character_8, is_uniform_character: BOOLEAN
			-- Are all items of type CHARACTER_8?
		do
			Result := is_tuple_uniform (character_8_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_character_32, is_uniform_wide_character: BOOLEAN
			-- Are all items of type CHARACTER_32?
		do
			Result := is_tuple_uniform (character_32_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_double: BOOLEAN
			-- Are all items of type REAL_64?
		do
			Result := is_tuple_uniform (real_64_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_natural_8: BOOLEAN
			-- Are all items of type NATURAL_8?
		do
			Result := is_tuple_uniform (natural_8_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_natural_16: BOOLEAN
			-- Are all items of type NATURAL_16?
		do
			Result := is_tuple_uniform (natural_16_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_natural_32: BOOLEAN
			-- Are all items of type NATURAL_32?
		do
			Result := is_tuple_uniform (natural_32_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_natural_64: BOOLEAN
			-- Are all items of type NATURAL_64?
		do
			Result := is_tuple_uniform (natural_64_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_integer_8: BOOLEAN
			-- Are all items of type INTEGER_8?
		do
			Result := is_tuple_uniform (integer_8_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_integer_16: BOOLEAN
			-- Are all items of type INTEGER_16?
		do
			Result := is_tuple_uniform (integer_16_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_integer, is_uniform_integer_32: BOOLEAN
			-- Are all items of type INTEGER?
		do
			Result := is_tuple_uniform (integer_32_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_integer_64: BOOLEAN
			-- Are all items of type INTEGER_64?
		do
			Result := is_tuple_uniform (integer_64_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_pointer: BOOLEAN
			-- Are all items of type POINTER?
		do
			Result := is_tuple_uniform (pointer_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_real: BOOLEAN
			-- Are all items of type REAL_32?
		do
			Result := is_tuple_uniform (real_32_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_reference: BOOLEAN
			-- Are all items of reference type?
		do
			Result := is_tuple_uniform (reference_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

feature -- Access

	plus alias "+" (a_other: TUPLE): detachable like Current
			-- Concatenation of `Current' with `a_other'
			--| note: it may be Void if the result exceeds the allowed capacity for a tuple.
			--| warning: this function has poor performance, use it with parsimony.
		local
			l_reflector: REFLECTOR
			i, n1,n2: INTEGER
			t1, t2: TYPE [detachable TUPLE]
			l_type_id: INTEGER
			l_items: SPECIAL [detachable separate ANY]
			l_type_string: STRING
		do
			n1 := count
			n2 := a_other.count

			if n1 = 0 then
					-- There is no way to type this but we know that if
					-- Current is a tuple without any actual generic parameter
					-- then `a_other' does conform to `like Current'.
				if attached {like plus} a_other.twin as l_res then
					Result := l_res
				else
					check current_is_empty_tuple: count = 0 end
				end
			elseif n2 = 0 then
				Result := twin
			else
				create l_type_string.make_from_string ("TUPLE [")

				create l_items.make_empty (n1 + n2)
				from
					t1 := generating_type
					check same_count: t1.generic_parameter_count = n1 end
					i := 1
				until
					i > n1
				loop
					if i > 1 then
						l_type_string.append_character (',')
					end
					l_type_string.append (t1.generic_parameter_type (i).name)
					l_items.force (item (i), i - 1)
					i := i + 1
				end
				from
					t2 := a_other.generating_type
					check same_count: t2.generic_parameter_count = n2 end
				until
					i > n1 + n2
				loop
					l_type_string.append_character (',')
					l_type_string.append (t2.generic_parameter_type (i - n1).name)
					l_items.force (a_other.item (i - n1), i - 1)
					i := i + 1
				end

				l_type_string.append_character (']')
				create l_reflector
				l_type_id := l_reflector.dynamic_type_from_string (l_type_string)
				if l_type_id >= 0 then
					if attached {like plus} l_reflector.new_tuple_from_special (l_type_id, l_items) as res then
						Result := res
					end
				else
						--| It may be that the maximum tuple capacity was reached.
						--| better return Void than a truncated tuple.
				end
			end
		ensure
			has_expected_count: Result /= Void implies Result.count = count + a_other.count
			has_expected_items: Result /= Void implies (
						(across 1 |..| count as ic_1 all Result[ic_1.item] = item (ic_1.item) end) and
						(across 1 |..| a_other.count as ic_2 all Result[count + ic_2.item] = a_other [ic_2.item] end)
					)
		end

feature -- Type conversion queries

	convertible_to_double: BOOLEAN
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

	convertible_to_real: BOOLEAN
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

	arrayed: ARRAY [detachable separate ANY]
			-- Items of Current as array
		obsolete
			"Will be removed in future releases"
		local
			i, cnt: INTEGER
		do
			from
				i := 1
				cnt := count
				create Result.make_filled (Void, 1, cnt)
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

	boolean_arrayed: ARRAY [BOOLEAN]
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
				create Result.make_filled (False, 1, cnt)
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

	character_8_arrayed, character_arrayed: ARRAY [CHARACTER_8]
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
				create Result.make_filled (' ', 1, cnt)
			until
				i > cnt
			loop
				Result.put (character_8_item (i), i)
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
			same_items: -- Items are the same in same order
		end

	double_arrayed: ARRAY [REAL_64]
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
				create Result.make_filled ({REAL_64} 0.0, 1, cnt)
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

	integer_arrayed: ARRAY [INTEGER]
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
				create Result.make_filled ({INTEGER} 0, 1, cnt)
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

	pointer_arrayed: ARRAY [POINTER]
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
				create Result.make_filled (Default_pointer, 1, cnt)
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

	real_arrayed: ARRAY [REAL_32]
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
				create Result.make_filled ({REAL_32} 0.0, 1, cnt)
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

	string_arrayed: ARRAY [detachable STRING]
			-- Items of Current as array
			-- NOTE: Items with a type not cconforming to
			--       type STRING are set to Void.
		obsolete
			"Will be removed in future releases"
		local
			i, cnt: INTEGER
		do
			from
				i := 1
				cnt := count
				create Result.make_filled (Void, 1, cnt)
			until
				i > cnt
			loop
				if attached {STRING} item (i) as s then
					Result.put (s, i)
				end
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
		end

feature -- Retrieval

	correct_mismatch
			-- Attempt to correct object mismatch using `mismatch_information'.
		local
			i, nb: INTEGER
			l_any: ANY
		do
				-- Old version of TUPLE had a SPECIAL [ANY] to store all values.
				-- If we can get access to it, then most likely we can recover this
				-- old TUPLE implementation.
			if attached {SPECIAL [ANY]} Mismatch_information.item (area_name) as l_area then
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

	item_code (index: INTEGER): NATURAL_8
			-- Type code of item at `index'. Used for
			-- argument processing in ROUTINE
		require
			valid_index: valid_index (index)
		do
			Result := eif_item_type ($Current, index)
		end

	reference_code: NATURAL_8 = 0x00
	boolean_code: NATURAL_8 = 0x01
	character_8_code, character_code: NATURAL_8 = 0x02
	real_64_code: NATURAL_8 = 0x03
	real_32_code: NATURAL_8 = 0x04
	pointer_code: NATURAL_8 = 0x05
	integer_8_code: NATURAL_8 = 0x06
	integer_16_code: NATURAL_8 = 0x07
	integer_32_code: NATURAL_8 = 0x08
	integer_64_code: NATURAL_8 = 0x09
	natural_8_code: NATURAL_8 = 0x0A
	natural_16_code: NATURAL_8 = 0x0B
	natural_32_code: NATURAL_8 = 0x0C
	natural_64_code: NATURAL_8 = 0x0D
	character_32_code, wide_character_code: NATURAL_8 = 0x0E
	any_code: NATURAL_8 = 0xFF
			-- Code used to identify type in TUPLE.

feature {NONE} -- Implementation

	area_name: STRING = "area"
			-- Name of attributes where TUPLE elements were stored.

	is_tuple_uniform (code: like item_code): BOOLEAN
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

	internal_primes: PRIMES
			-- For quick access to prime numbers.
		once
			create Result
		end

feature {NONE} -- Externals: Access

	eif_item_type (obj: POINTER; pos: INTEGER): NATURAL_8
			-- Code for generic parameter `pos' in `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		alias
			"eif_item_type"
		end

	eif_boolean_item (obj: POINTER; pos: INTEGER): BOOLEAN
			-- Boolean item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_character_8_item (obj: POINTER; pos: INTEGER): CHARACTER_8
			-- Character item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_character_32_item (obj: POINTER; pos: INTEGER): CHARACTER_32
			-- Wide character item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_real_64_item (obj: POINTER; pos: INTEGER): REAL_64
			-- Double item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_real_32_item (obj: POINTER; pos: INTEGER): REAL_32
			-- Real item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_pointer_item (obj: POINTER; pos: INTEGER): POINTER
			-- Pointer item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_natural_8_item (obj: POINTER; pos: INTEGER): NATURAL_8
			-- NATURAL_8 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_natural_16_item (obj: POINTER; pos: INTEGER):  NATURAL_16
			-- NATURAL_16 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_natural_32_item (obj: POINTER; pos: INTEGER):  NATURAL_32
			-- NATURAL_32 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_natural_64_item (obj: POINTER; pos: INTEGER):  NATURAL_64
			-- NATURAL_64 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_integer_8_item (obj: POINTER; pos: INTEGER): INTEGER_8
			-- INTEGER_8 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_integer_16_item (obj: POINTER; pos: INTEGER): INTEGER_16
			-- INTEGER_16 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_integer_32_item (obj: POINTER; pos: INTEGER): INTEGER_32
			-- INTEGER_32 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_integer_64_item (obj: POINTER; pos: INTEGER): INTEGER_64
			-- INTEGER_64 item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_reference_item (obj: POINTER; pos: INTEGER): detachable ANY
			-- Reference item at position `pos' in tuple `obj'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

feature {NONE} -- Externals: Setting

	eif_put_boolean_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set boolean item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_character_8_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set character item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_character_32_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set wide character item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_real_64_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set double item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_real_32_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set real item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_pointer_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set pointer item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_8_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set NATURAL_8 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_16_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set NATURAL_16 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_32_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set NATURAL_32 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_64_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set NATURAL_64 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_8_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set integer_8 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_16_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set integer_16 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_32_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set integer_32 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_64_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set integer_64 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_reference_item_with_object (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set reference item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_boolean_item (obj: POINTER; pos: INTEGER; v: BOOLEAN)
			-- Set boolean item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_character_8_item (obj: POINTER; pos: INTEGER; v: CHARACTER_8)
			-- Set character_8 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_character_32_item (obj: POINTER; pos: INTEGER; v: CHARACTER_32)
			-- Set character_32 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_real_64_item (obj: POINTER; pos: INTEGER; v: REAL_64)
			-- Set double item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_real_32_item (obj: POINTER; pos: INTEGER; v: REAL_32)
			-- Set real item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_pointer_item (obj: POINTER; pos: INTEGER; v: POINTER)
			-- Set pointer item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_8_item (obj: POINTER; pos: INTEGER; v: NATURAL_8)
			-- Set NATURAL_8 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_16_item (obj: POINTER; pos: INTEGER; v: NATURAL_16)
			-- Set NATURAL_16 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_32_item (obj: POINTER; pos: INTEGER; v: NATURAL_32)
			-- Set NATURAL_32 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_natural_64_item (obj: POINTER; pos: INTEGER; v: NATURAL_64)
			-- Set NATURAL_64 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_8_item (obj: POINTER; pos: INTEGER; v: INTEGER_8)
			-- Set integer_8 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_16_item (obj: POINTER; pos: INTEGER; v: INTEGER_16)
			-- Set integer_16 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_32_item (obj: POINTER; pos: INTEGER; v: INTEGER_32)
			-- Set integer_32 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_put_integer_64_item (obj: POINTER; pos: INTEGER; v: INTEGER_64)
			-- Set integer_64 item at position `pos' in tuple `obj' with `v'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
