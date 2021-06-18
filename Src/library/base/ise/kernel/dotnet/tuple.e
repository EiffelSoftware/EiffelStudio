note
	description: "Implementation of TUPLE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE

inherit
	HASHABLE
		redefine
			copy, is_equal, default_create
		end

	READABLE_INDEXABLE [detachable separate ANY]
		redefine
			copy, is_equal, default_create
		end

create
	default_create, make

feature -- Creation

	default_create
			-- Create instance of TUPLE.
		do
			native_array := dummy_array
			create native_array.make ({ISE_RUNTIME}.generic_parameter_count (Current) + 1)
		ensure then
			non_void_native_array: native_array /= Void
		end

	make
			-- Create instance of TUPLE
		obsolete
			"Use no creation procedure to create a TUPLE instance. [2017-05-31]"
		do
			default_create
		end

feature -- Access

	item alias "[]", at alias "@" (index: INTEGER): detachable separate SYSTEM_OBJECT assign put
			-- Entry of key `index'.
		local
			l_result: detachable separate ANY
		do
				-- If it is a basic type, then we need to do a promotion.
				-- If not, then we simply get the element.
			inspect item_code (index)
			when boolean_code then l_result := boolean_item (index)
			when character_8_code then l_result := character_8_item (index)
			when character_32_code then l_result := character_32_item (index)
			when real_64_code then l_result := double_item (index)
			when real_32_code then l_result := real_item (index)
			when pointer_code then l_result := pointer_item (index)
			when natural_32_code then l_result := natural_32_item (index)
			when natural_8_code then l_result := natural_8_item (index)
			when natural_16_code then l_result := natural_16_item (index)
			when natural_64_code then l_result := natural_64_item (index)
			when integer_32_code then l_result := integer_32_item (index)
			when integer_8_code then l_result := integer_8_item (index)
			when integer_16_code then l_result := integer_16_item (index)
			when integer_64_code then l_result := integer_64_item (index)
			when reference_code then
				l_result := native_array.item (index)
			end
			Result := l_result
		end

	reference_item (index: INTEGER): detachable separate ANY
			-- Reference item at `index'.
		require
			valid_index: valid_index (index)
			is_reference: is_reference_item (index)
		do
			Result := native_array.item (index)
		end

	boolean_item (index: INTEGER): BOOLEAN
			-- Boolean item at `index'.
		require
			valid_index: valid_index (index)
			is_boolean: is_boolean_item (index)
		do
			check
				from_precondition: attached {BOOLEAN} native_array.item (index) as b
			then
				Result := b
			end
		end

	character_8_item, character_item (index: INTEGER): CHARACTER_8
			-- Character item at `index'.
		require
			valid_index: valid_index (index)
			is_character_8: is_character_8_item (index)
		do
			check
				from_precondition: attached {CHARACTER_8} native_array.item (index) as c
			then
				Result := c
			end
		end

	character_32_item (index: INTEGER): CHARACTER_32
			-- Character item at `index'.
		require
			valid_index: valid_index (index)
			is_character_32: is_character_32_item (index)
		do
			check
				from_precondition: attached {CHARACTER_32} native_array.item (index) as c
			then
				Result := c
			end
		end

	real_64_item, double_item (index: INTEGER): REAL_64
			-- Double item at `index'.
		require
			valid_index: valid_index (index)
			is_numeric: is_double_item (index)
		do
			check
				from_precondition: attached {REAL_64} native_array.item (index) as r
			then
				Result := r
			end
		end

	natural_8_item (index: INTEGER): NATURAL_8
			-- NATURAL_8 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_8_item (index)
		do
			check
				from_precondition: attached {NATURAL_8} native_array.item (index) as n
			then
				Result := n
			end
		end

	natural_16_item (index: INTEGER): NATURAL_16
			-- NATURAL_16 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_16_item (index)
		do
			check
				from_precondition: attached {NATURAL_16} native_array.item (index) as n
			then
				Result := n
			end
		end

	natural_32_item (index: INTEGER): NATURAL_32
			-- NATURAL_32 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_32_item (index)
		do
			check
				from_precondition: attached {NATURAL_32} native_array.item (index) as n
			then
				Result := n
			end
		end

	natural_64_item (index: INTEGER): NATURAL_64
			-- NATURAL_64 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_64_item (index)
		do
			check
				from_precondition: attached {NATURAL_64} native_array.item (index) as n
			then
				Result := n
			end
		end

	integer_8_item (index: INTEGER): INTEGER_8
			-- INTEGER_8 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_8_item (index)
		do
			check
				from_precondition: attached {INTEGER_8} native_array.item (index) as i
			then
				Result := i
			end
		end

	integer_16_item (index: INTEGER): INTEGER_16
			-- INTEGER_16 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_16_item (index)
		do
			check
				from_precondition: attached {INTEGER_16} native_array.item (index) as i
			then
				Result := i
			end
		end

	integer_item, integer_32_item (index: INTEGER): INTEGER
			-- INTEGER_32 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_32_item (index)
		do
			check
				from_precondition: attached {INTEGER_32} native_array.item (index) as i
			then
				Result := i
			end
		end

	integer_64_item (index: INTEGER): INTEGER_64
			-- INTEGER_64 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_64_item (index)
		do
			check
				from_precondition: attached {INTEGER_64} native_array.item (index) as i
			then
				Result := i
			end
		end

	pointer_item (index: INTEGER): POINTER
			-- Pointer item at `index'.
		require
			valid_index: valid_index (index)
			is_pointer: is_pointer_item (index)
		do
			check
				from_precondition: attached {POINTER} native_array.item (index) as p
			then
				Result := p
			end
		end

	real_32_item, real_item (index: INTEGER): REAL_32
			-- real item at `index'.
		require
			valid_index: valid_index (index)
			is_real_or_integer: is_real_item (index)
		do
			check
				from_precondition: attached {REAL_32} native_array.item (index) as r
			then
				Result := r
			end
		end

feature -- Comparison

	object_comparison: BOOLEAN
			-- Must search operations use `equal' rather than `='
			-- for comparing references? (Default: no, use `='.)
		do
				-- `Void' means `False', otherwise the stored value.
			Result := attached {BOOLEAN} native_array.item (0) as b and then b
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		local
			i, nb: INTEGER
			l_cur, l_other: like native_array
			l_object_compare: BOOLEAN
		do
			l_cur := native_array
			l_other := other.native_array
			nb := l_cur.count
			if nb = l_other.count then
				l_object_compare := object_comparison
				Result := l_object_compare = other.object_comparison
				if Result then
					from
						i := 1
					until
						i = nb or not Result
					loop
						if is_reference_item (i) then
							if l_object_compare then
								Result := equal (l_cur.item (i), l_other.item (i))
							else
								Result := l_cur.item (i) = l_other.item (i)
							end
						else
							Result := equal (l_cur.item (i), l_other.item (i))
						end
						i := i + 1
					end
				end
			end
		end

feature -- Status setting

	compare_objects
			-- Ensure that future search operations will use `equal'
			-- rather than `=' for comparing references.
		do
			native_array.put (0, True)
		ensure
			object_comparison: object_comparison
		end

	compare_references
			-- Ensure that future search operations will use `='
			-- rather than `equal' for comparing references.
		do
			native_array.put (0, False)
		ensure
			reference_comparison: not object_comparison
		end

feature -- Duplication

	copy (other: like Current)
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		local
			nb: INTEGER
		do
			if other /= Current then
				standard_copy (other)
				nb := other.native_array.count
				create native_array.make (nb)
				{SYSTEM_ARRAY}.copy (other.native_array, native_array, nb)
			end
		end

feature -- Status report

	hash_code: INTEGER
			-- Hash code value
		local
			i, nb: INTEGER
			l_item: detachable SYSTEM_OBJECT
		do
			from
				i := 1
				nb := count
			until
				i > nb
			loop
				l_item := native_array.item (i)
				if is_reference_item (i) then
					if attached {separate HASHABLE} l_item as l_key then
						Result := Result + l_key.hash_code * internal_primes.i_th (i)
					end
				else
						-- A basic type
					if l_item /= Void then
						Result := Result + l_item.get_hash_code * internal_primes.i_th (i)
					end
				end
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

	valid_type_for_index (v: detachable separate SYSTEM_OBJECT; index: INTEGER): BOOLEAN
			-- Is object `v' a valid target for element at position `index'?
		require
			valid_index: valid_index (index)
		local
			l_code: like item_code
		do
			if v = Void then
					-- A Void entry is always valid.
				Result := True
			else
				l_code := item_code (index)
				if attached {like item_code} reverse_lookup.item (v.get_type) as l_item_code then
					Result := l_code = l_item_code
				else
					Result := l_code = 0
				end
				if Result and l_code = reference_code then
						-- Let's check that type of `v' conforms to specified type of
						-- `index'-th arguments of current TUPLE.
					Result := v.generating_type.conforms_to (generating_type.generic_parameter_type (index))
				end
			end
		end

	count: INTEGER
			-- Number of element in Current.
		do
			Result := native_array.count - 1
		end

	lower: INTEGER = 1
			-- Lower bound of TUPLE.

	upper: INTEGER
			-- Upper bound of TUPLE.
		do
			Result := count
		end

	is_empty: BOOLEAN
			-- Is Current empty?
		do
			Result := native_array.count <= 1
		end

feature -- Element change

	put (v: detachable separate SYSTEM_OBJECT; k: INTEGER)
			-- Associate value `v' with key `k'.
		require
			valid_index: valid_index (k)
			valid_type_for_index: valid_type_for_index (v, k)
		do
			native_array.put (k, v)
		end

	put_reference (v: detachable separate ANY; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type_for_index: valid_type_for_index (v, index)
			valid_type: is_reference_item (index)
		do
			native_array.put (index, v)
		end

	put_boolean (v: BOOLEAN; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_boolean_item (index)
		do
			native_array.put (index, v)
		end

	put_character_8, put_character (v: CHARACTER_8; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_character_8_item (index)
		do
			native_array.put (index, v)
		end

	put_character_32, put_wide_character (v: CHARACTER_32; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_character_32_item (index)
		do
			native_array.put (index, v)
		end

	put_real_64, put_double (v: REAL_64; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_double_item (index)
		do
			native_array.put (index, v)
		end

	put_real_32, put_real (v: REAL_32; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_real_item (index)
		do
			native_array.put (index, v)
		end

	put_pointer (v: POINTER; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_pointer_item (index)
		do
			native_array.put (index, v)
		end

	put_natural_8 (v: NATURAL_8; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_8_item (index)
		do
			native_array.put (index, v)
		end

	put_natural_16 (v: NATURAL_16; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_16_item (index)
		do
			native_array.put (index, v)
		end

	put_natural_32 (v: NATURAL_32; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_32_item (index)
		do
			native_array.put (index, v)
		end

	put_natural_64 (v: NATURAL_64; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_64_item (index)
		do
			native_array.put (index, v)
		end

	put_integer, put_integer_32 (v: INTEGER_32; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_32_item (index)
		do
			native_array.put (index, v)
		end

	put_integer_8 (v: INTEGER_8; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_8_item (index)
		do
			native_array.put (index, v)
		end

	put_integer_16 (v: INTEGER_16; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_16_item (index)
		do
			native_array.put (index, v)
		end

	put_integer_64 (v: INTEGER_64; index: INTEGER)
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_64_item (index)
		do
			native_array.put (index, v)
		end

feature -- Type queries

	is_boolean_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a BOOLEAN?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = boolean_code
		end

	is_character_8_item, is_character_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a CHARACTER_8?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = character_8_code
		end

	is_character_32_item, is_wide_character_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a CHARACTER_32?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = character_32_code
		end

	is_double_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a REAL_64?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = real_64_code
		end

	is_natural_8_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an NATURAL_8?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = natural_8_code
		end

	is_natural_16_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an NATURAL_16?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = natural_16_code
		end

	is_natural_32_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an NATURAL_32?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = natural_32_code
		end

	is_natural_64_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an NATURAL_64?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = natural_64_code
		end

	is_integer_8_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an INTEGER_8?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = integer_8_code
		end

	is_integer_16_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an INTEGER_16?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = integer_16_code
		end

	is_integer_item, is_integer_32_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an INTEGER_32?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = integer_32_code
		end

	is_integer_64_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an INTEGER_64?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = integer_64_code
		end

	is_pointer_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a POINTER?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = pointer_code
		end

	is_real_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a REAL_32?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = real_32_code
		end

	is_reference_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a REFERENCE?
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index) = reference_code
		end

	is_numeric_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a number?
		obsolete
			"Use the precise type query instead. [2017-05-31]"
		require
			valid_index: valid_index (index)
		local
			tcode: like item_code
		do
			tcode := generic_typecode (index)
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
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_boolean: BOOLEAN
			-- Are all items of type BOOLEAN?
		do
			Result := is_tuple_uniform (boolean_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_character_8, is_uniform_character: BOOLEAN
			-- Are all items of type CHARACTER_8?
		do
			Result := is_tuple_uniform (character_8_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_character_32, is_uniform_wide_character: BOOLEAN
			-- Are all items of type CHARACTER_32?
		do
			Result := is_tuple_uniform (character_32_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_double: BOOLEAN
			-- Are all items of type REAL_64?
		do
			Result := is_tuple_uniform (real_64_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_natural_8: BOOLEAN
			-- Are all items of type NATURAL_8?
		do
			Result := is_tuple_uniform (natural_8_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_natural_16: BOOLEAN
			-- Are all items of type NATURAL_16?
		do
			Result := is_tuple_uniform (natural_16_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_natural_32: BOOLEAN
			-- Are all items of type NATURAL_32?
		do
			Result := is_tuple_uniform (natural_32_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_natural_64: BOOLEAN
			-- Are all items of type NATURAL_64?
		do
			Result := is_tuple_uniform (natural_64_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_integer_8: BOOLEAN
			-- Are all items of type INTEGER_8?
		do
			Result := is_tuple_uniform (integer_8_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_integer_16: BOOLEAN
			-- Are all items of type INTEGER_16?
		do
			Result := is_tuple_uniform (integer_16_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_integer, is_uniform_integer_32: BOOLEAN
			-- Are all items of type INTEGER?
		do
			Result := is_tuple_uniform (integer_32_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_integer_64: BOOLEAN
			-- Are all items of type INTEGER_64?
		do
			Result := is_tuple_uniform (integer_64_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_pointer: BOOLEAN
			-- Are all items of type POINTER?
		do
			Result := is_tuple_uniform (pointer_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_real: BOOLEAN
			-- Are all items of type REAL_32?
		do
			Result := is_tuple_uniform (real_32_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

	is_uniform_reference: BOOLEAN
			-- Are all items of reference type?
		do
			Result := is_tuple_uniform (reference_code)
		ensure
			yes_if_empty: count = 0 implies Result
		end

feature -- Access

	plus alias "+" (a_other: TUPLE): detachable like Current
			-- Concatenation of `Current' with `a_other'
			--| note: it may be Void if the result exceeds the allowed capacity for a tuple.
			--| warning: this function has poor performance, use it with parsimony.
		local
			l_reflector: REFLECTOR
			i, n1, n2: INTEGER
			t1, t2: TYPE [detachable TUPLE]
			l_type_id: INTEGER
			l_items: SPECIAL [detachable separate ANY]
			l_type_string: STRING
		do
			n1 := count
			n2 := a_other.count

			if n1 = 0 then
				Result := a_other.twin
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
				if
					l_type_id >= 0 and then
					attached {like plus} l_reflector.new_tuple_from_special (l_type_id, l_items) as res
				then
					Result := res
				else
						--| It may be that the maximum tuple capacity was reached.
						--| better return Void than a truncated tuple.
				end
			end
		ensure
			has_expected_count: Result /= Void implies Result.count = count + a_other.count
			has_expected_items: Result /= Void implies (
					(∀ k: 1 |..| count ¦ Result [k] = item (k)) and
					(∀ k: 1 |..| a_other.count ¦ Result [count + k] = a_other [k])
				)
		end

feature -- Type conversion queries

	convertible_to_double: BOOLEAN
			-- Is current convertible to an array of doubles?
		obsolete
			"Will be removed in future releases. [2017-05-31]"
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
				tcode := generic_typecode (i)
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
			"Will be removed in future releases. [2017-05-31]"
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
				tcode := generic_typecode (i)
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
			"Will be removed in future releases. [2017-05-31]"
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
				if attached {separate ANY} native_array.item (i) as a then
					Result.put (a, i)
				end
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
			"Will be removed in future releases. [2017-05-31]"
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

	character_8_arrayed, character_arrayed: ARRAY [CHARACTER_8]
			-- Items of Current as array
		obsolete
			"Will be removed in future releases. [2017-05-31]"
		require
			is_uniform_character_8: is_uniform_character_8
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
			"Will be removed in future releases. [2017-05-31]"
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

	integer_arrayed: ARRAY [INTEGER]
			-- Items of Current as array
		obsolete
			"Will be removed in future releases. [2017-05-31]"
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

	pointer_arrayed: ARRAY [POINTER]
			-- Items of Current as array
		obsolete
			"Will be removed in future releases. [2017-05-31]"
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

	real_arrayed: ARRAY [REAL_32]
			-- Items of Current as array
		obsolete
			"Will be removed in future releases. [2017-05-31]"
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

	string_arrayed: ARRAY [detachable STRING]
			-- Items of Current as array
			-- NOTE: Items with a type not cconforming to
			--       type STRING are set to Void.
		obsolete
			"Will be removed in future releases. [2017-05-31]"
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
				if attached {STRING} native_array.item (i) as s then
					Result.put (s, i)
				end
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
		end

	to_cil: NATIVE_ARRAY [detachable SYSTEM_OBJECT]
			-- A reference to a CIL form of current tuple.
		local
			nb: INTEGER
		do
			nb := count
			create Result.make (nb)
			{SYSTEM_ARRAY}.copy (native_array, 0, Result, 0, nb)
		ensure
			non_void_to_cil: Result /= Void
			no_sharing: Result /= native_array
		end

feature {ROUTINE} -- Fast access

	fast_item (k: INTEGER): detachable SYSTEM_OBJECT
		require
			valid_index: valid_index (k)
		do
			Result := native_array.item (k)
		end

feature -- Access

	item_code (index: INTEGER): NATURAL_8
			-- Type code of item at `index'. Used for
			-- argument processing in ROUTINE
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index)
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
			-- Code used to identify type in tuple.

feature {TUPLE} -- Implementation

	native_array: NATIVE_ARRAY [detachable separate SYSTEM_OBJECT]
			-- Storage where values are kept.

feature {NONE} -- Implementation

	dummy_array: NATIVE_ARRAY [detachable separate SYSTEM_OBJECT]
		once
			create Result.make (0)
		end

	is_tuple_uniform (code: like item_code): BOOLEAN
			-- Are all items of type `code'?
		local
			i, nb: INTEGER
			first_type, type: detachable SYSTEM_TYPE
			l_val: detachable SYSTEM_OBJECT
		do
			Result := True
			nb := count
			if nb > 1 then
				from
					i := 2
					if code = any_code then
						l_val := native_array.item (1)
						if l_val /= Void then
							first_type := l_val.get_type
						end
					else
						first_type := codemap.item (code)
					end
				until
					i > nb or not Result
				loop
					l_val := native_array.item (i)
					if l_val /= Void then
						type := l_val.get_type
					else
						type := Void
					end
					Result := {SYSTEM_OBJECT}.equals_object_object (first_type, type)
					i := i + 1
				end
			end
		end

	generic_typecode (pos: INTEGER): NATURAL_8
			-- Code for generic parameter `pos' in `obj'.
		local
			l_item: detachable SYSTEM_OBJECT
		do
			l_item := native_array.item (pos)
			if l_item /= Void then
					-- We already have an item stored in TUPLE, so get its type.
				l_item := reverse_lookup.item (l_item.get_type)
			else
					-- Void element we need to retrieve type from actual generic
					-- parameter.
				l_item := reverse_lookup.item ({ISE_RUNTIME}.type_of_generic_parameter (Current, pos))
			end
			if l_item = Void then
				Result := reference_code
			elseif attached {NATURAL_8} l_item as n then
				Result := n
			end
		end

	reverse_lookup: HASHTABLE
			-- Given a SYSTEM_TYPE object, returns its associated `typecode'.
		once
			create Result.make_from_capacity (10)
			Result.set_item (({BOOLEAN}).to_cil, boolean_code)
			Result.set_item (({CHARACTER_8}).to_cil, character_8_code)
			Result.set_item (({REAL_64}).to_cil, real_64_code)
			Result.set_item (({REAL_32}).to_cil, real_32_code)
			Result.set_item (({POINTER}).to_cil, pointer_code)
			Result.set_item (({SYSTEM_OBJECT}).to_cil, reference_code)
			Result.set_item (({NATURAL_8}).to_cil, natural_8_code)
			Result.set_item (({NATURAL_16}).to_cil, natural_16_code)
			Result.set_item (({NATURAL_32}).to_cil, natural_32_code)
			Result.set_item (({NATURAL_64}).to_cil, natural_64_code)
			Result.set_item (({INTEGER_8}).to_cil, integer_8_code)
			Result.set_item (({INTEGER_16}).to_cil, integer_16_code)
			Result.set_item (({INTEGER}).to_cil, integer_32_code)
			Result.set_item (({INTEGER_64}).to_cil, integer_64_code)
		end

	codemap: NATIVE_ARRAY [SYSTEM_TYPE]
			-- Conversion between `code' type and SYSTEM_TYPE object.
		once
			create Result.make (128)
			Result.put (boolean_code, {BOOLEAN})
			Result.put (character_8_code, {CHARACTER_8})
			Result.put (real_64_code, {REAL_64})
			Result.put (real_32_code, {REAL_32})
			Result.put (pointer_code, {POINTER})
			Result.put (reference_code, {SYSTEM_OBJECT})
			Result.put (natural_8_code, {NATURAL_8})
			Result.put (natural_16_code, {NATURAL_16})
			Result.put (natural_32_code, {NATURAL_32})
			Result.put (natural_64_code, {NATURAL_64})
			Result.put (integer_8_code, {INTEGER_8})
			Result.put (integer_16_code, {INTEGER_16})
			Result.put (integer_32_code, {INTEGER})
			Result.put (integer_64_code, {INTEGER_64})
		end

	internal_primes: PRIMES
			-- For quick access to prime numbers.
		once
			create Result
		end

invariant
	non_void_native_array: native_array /= Void

note
	library: "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
