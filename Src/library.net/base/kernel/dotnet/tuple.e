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
		redefine
			copy, is_equal, default_create
		end

create
	default_create, make

feature -- Creation

	default_create is
			-- Create instance of TUPLE.
		local
			l_count: INTEGER
		do
			l_count := {ISE_RUNTIME}.generic_parameter_count (Current)
			create native_array.make (l_count)
		ensure then
			non_void_native_array: native_array /= Void
		end

	make is
			-- Create instance of TUPLE
		obsolete
			"Use no creation procedure to create a TUPLE instance"
		do
			default_create
		end

feature -- Access

	item alias "[]", infix "@" (index: INTEGER): ANY is
			-- Entry of key `index'.
		require
			valid_index: valid_index (index)
		do
				-- If it is a basic type, then we need to do a promotion.
				-- If not, then we simply get the element.
			inspect item_code (index)
			when boolean_code then Result := boolean_item (index)
			when character_code then Result := character_item (index)
			when real_64_code then Result := double_item (index)
			when real_32_code then Result := real_item (index)
			when pointer_code then Result := pointer_item (index)
			when natural_32_code then Result := natural_32_item (index)
			when natural_8_code then Result := natural_8_item (index)
			when natural_16_code then Result := natural_16_item (index)
			when natural_64_code then Result := natural_64_item (index)
			when integer_32_code then Result := integer_32_item (index)
			when integer_8_code then Result := integer_8_item (index)
			when integer_16_code then Result := integer_16_item (index)
			when integer_64_code then Result := integer_64_item (index)
			when reference_code then
				Result := native_array.item (index - 1)
			end
		end

	reference_item (index: INTEGER): ANY is
			-- Reference item at `index'.
		require
			valid_index: valid_index (index)
			is_reference: is_reference_item (index)
		do
			Result := native_array.item (index - 1)
		end

	boolean_item (index: INTEGER): BOOLEAN is
			-- Boolean item at `index'.
		require
			valid_index: valid_index (index)
			is_boolean: is_boolean_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	character_item (index: INTEGER): CHARACTER is
			-- Character item at `index'.
		require
			valid_index: valid_index (index)
			is_character: is_character_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	real_64_item, double_item (index: INTEGER): DOUBLE is
			-- Double item at `index'.
		require
			valid_index: valid_index (index)
			is_numeric: is_double_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	natural_8_item (index: INTEGER): NATURAL_8 is
			-- NATURAL_8 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_8_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	natural_16_item (index: INTEGER): NATURAL_16 is
			-- NATURAL_16 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_16_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	natural_32_item (index: INTEGER): NATURAL_32 is
			-- NATURAL_32 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_32_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	natural_64_item (index: INTEGER): NATURAL_64 is
			-- NATURAL_64 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_natural_64_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	integer_8_item (index: INTEGER): INTEGER_8 is
			-- INTEGER_8 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_8_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	integer_16_item (index: INTEGER): INTEGER_16 is
			-- INTEGER_16 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_16_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	integer_item, integer_32_item (index: INTEGER): INTEGER is
			-- INTEGER_32 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_32_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	integer_64_item (index: INTEGER): INTEGER_64 is
			-- INTEGER_64 item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_64_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	pointer_item (index: INTEGER): POINTER is
			-- Pointer item at `index'.
		require
			valid_index: valid_index (index)
			is_pointer: is_pointer_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	real_32_item, real_item (index: INTEGER): REAL is
			-- real item at `index'.
		require
			valid_index: valid_index (index)
			is_real_or_integer: is_real_item (index)
		do
			Result ?= fast_item (index - 1)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		local
			i, nb: INTEGER
			l_cur, l_other: like native_array
		do
			l_cur := native_array
			l_other := other.native_array
			nb := l_cur.count - 1
			if nb = l_other.count - 1 then
				from
					Result := True
				until
					i > nb or not Result
				loop
					if is_reference_item (i + 1) then
						Result := l_cur.item (i) = l_other.item (i)
					else
						Result := equal (l_cur.item (i), l_other.item (i))
					end
					i := i + 1
				end
			end
		end

feature -- Duplication

	copy (other: like Current) is
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

	hash_code: INTEGER is
			-- Hash code value
		local 
			i, nb: INTEGER 
			l_item: SYSTEM_OBJECT
			l_key: HASHABLE
		do 
			from
				i := 1
				nb := count
			until
				i > nb 
			loop
				l_item := fast_item (i - 1) 
				if is_reference_item (i) then
					l_key ?= l_item
					if l_key /= Void then 
						Result := Result + l_key.hash_code * internal_primes.i_th (i) 
					end
				else
						-- A basic type
					Result := Result + l_item.get_hash_code * internal_primes.i_th (i)
				end
				i := i + 1 
			end 
				-- Ensure it is a positive value.
			Result := Result.hash_code
		end 
		
	valid_index (k: INTEGER): BOOLEAN is
			-- Is `k' a valid key?
		do
			Result := k >= 1 and then k <= native_array.count
		end

	valid_type_for_index (v: SYSTEM_OBJECT; index: INTEGER): BOOLEAN is
			-- Is object `v' a valid target for element at position `index'?
		require
			valid_index: valid_index (index)
		local
			l_code, l_item_code: like item_code
			l_int: INTERNAL
		do
			if v = Void then
					-- A Void entry is always valid.
				Result := True
			else
				l_code := item_code (index)
				l_item_code ?= reverse_lookup.item (v.get_type)
				Result := l_code = l_item_code
				if Result and l_code = reference_code then
						-- Let's check that type of `v' conforms to specified type of
						-- `index'-th arguments of current TUPLE.
					create l_int
					Result := l_int.type_conforms_to (l_int.dynamic_type (v),
						l_int.generic_dynamic_type (Current, index))
				end
			end
		end

	count: INTEGER is
			-- Number of element in Current.
		do
			Result := native_array.count
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
			Result := native_array.count = 0
		end

feature -- Element change

	put (v: SYSTEM_OBJECT; k: INTEGER) is
			-- Associate value `v' with key `k'.
		require
			valid_index: valid_index (k)
			valid_type_for_index: valid_type_for_index (v, k)
		do
			native_array.put (k - 1, v)
		end

	put_reference (v: ANY; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_reference_item (index)
		do
			native_array.put (index - 1, v)
		end
		
	put_boolean (v: BOOLEAN; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_boolean_item (index)
		do
			native_array.put (index - 1, v)
		end
		
	put_character (v: CHARACTER; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_character_item (index)
		do
			native_array.put (index - 1, v)
		end
		
	put_real_64, put_double (v: DOUBLE; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_double_item (index)
		do
			native_array.put (index - 1, v)
		end
		
	put_real_32, put_real (v: REAL; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_real_item (index)
		do
			native_array.put (index - 1, v)
		end
		
	put_pointer (v: POINTER; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_pointer_item (index)
		do
			native_array.put (index - 1, v)
		end

	put_natural_8 (v: NATURAL_8; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_8_item (index)
		do
			native_array.put (index - 1, v)
		end
		
	put_natural_16 (v: NATURAL_16; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_16_item (index)
		do
			native_array.put (index - 1, v)
		end

	put_natural_32 (v: NATURAL_32; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_32_item (index)
		do
			native_array.put (index - 1, v)
		end
		
	put_natural_64 (v: NATURAL_64; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_natural_64_item (index)
		do
			native_array.put (index - 1, v)
		end

	put_integer, put_integer_32 (v: INTEGER; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_32_item (index)
		do
			native_array.put (index - 1, v)
		end
		
	put_integer_8 (v: INTEGER_8; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_8_item (index)
		do
			native_array.put (index - 1, v)
		end
		
	put_integer_16 (v: INTEGER_16; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_16_item (index)
		do
			native_array.put (index - 1, v)
		end
		
	put_integer_64 (v: INTEGER_64; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_64_item (index)
		do
			native_array.put (index - 1, v)
		end

feature -- Type queries

	is_boolean_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a BOOLEAN?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = boolean_code)
		end

	is_character_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a CHARACTER?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = character_code)
		end

	is_double_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a DOUBLE?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = real_64_code)
		end

	is_natural_8_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an NATURAL_8?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = natural_8_code)
		end

	is_natural_16_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an NATURAL_16?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = natural_16_code)
		end

	is_natural_32_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an NATURAL_32?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = natural_32_code)
		end

	is_natural_64_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an NATURAL_64?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = natural_64_code)
		end

	is_integer_8_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = integer_8_code)
		end

	is_integer_16_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = integer_16_code)
		end

	is_integer_item, is_integer_32_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = integer_32_code)
		end

	is_integer_64_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = integer_64_code)
		end

	is_pointer_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a POINTER?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = pointer_code)
		end

	is_real_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a REAL?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = real_32_code)
		end

	is_reference_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a REFERENCE?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode (index - 1) = reference_code)
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
			tcode := generic_typecode (index - 1)
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
				i := 0
				cnt := count
			until
				i >= cnt or else not Result
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
				i := 0
				cnt := count
			until
				i >= cnt or else not Result
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

	arrayed: ARRAY [ANY] is
			-- Items of Current as array
		obsolete
			"Will be removed in future releases"
		local
			i, cnt: INTEGER
			a: ANY
		do
			from
				i := 1
				cnt := count
				create Result.make (1, cnt)
			until
				i > cnt
			loop
				a ?= fast_item (i - 1)
				Result.put (a, i)
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
				s ?= fast_item (i - 1)
				Result.put (s, i)
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
		end

	to_cil: NATIVE_ARRAY [SYSTEM_OBJECT] is
			-- A reference to a CIL form of current tuple.
		do
			Result := native_array
		ensure
			non_void_to_cil: Result /= Void
		end

feature {ROUTINE} -- Fast access

	fast_item (k: INTEGER): SYSTEM_OBJECT is
		require
			valid_index: valid_index (k + 1)
		do
			Result := native_array.item (k)
		end

feature -- Access

	item_code (index: INTEGER): NATURAL_8 is
			-- Type code of item at `index'. Used for
			-- argument processing in ROUTINE
		require
			valid_index: valid_index (index)
		do
			Result := generic_typecode (index - 1)
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
	any_code: NATURAL_8 is 0xFF
			-- Code used to identify type in tuple.
		
feature {TUPLE} -- Implementation

	native_array: NATIVE_ARRAY [SYSTEM_OBJECT]
			-- Storage where values are kept.

feature {NONE} -- Implementation

	is_tuple_uniform (code: like item_code): BOOLEAN is
			-- Are all items of type `code'?
		local
			i, nb: INTEGER
			first_type, type: SYSTEM_TYPE
			l_val: SYSTEM_OBJECT
		do
			Result := True
			if count > 0 then
				from
					i := 2
					nb := count
					if code = any_code then
						l_val := fast_item (0)
						if l_val /= Void then
							first_type := l_val.get_type
						end
					else
						first_type := codemap.item (code)
					end
				until
					i > nb or not Result
				loop
					l_val := fast_item (i - 1)
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

	generic_typecode (pos: INTEGER): NATURAL_8 is
			-- Code for generic parameter `pos' in `obj'.
		local
			l_item: SYSTEM_OBJECT
		do
			l_item := fast_item (pos)
			if l_item /= Void then
					-- We already have an item stored in TUPLE, so get its type.
				l_item := reverse_lookup.item (l_item.get_type)
			else
					-- Void element we need to retrieve type from actual generic
					-- parameter.
				l_item := reverse_lookup.item (
					 {ISE_RUNTIME}.type_of_generic_parameter (Current, pos + 1))
			end
			if l_item /= Void then
				Result ?= l_item
			else
				Result := reference_code
			end
		end

	reverse_lookup: HASHTABLE is
			-- Given a SYSTEM_TYPE object, returns its associated `typecode'.
		once
			create Result.make_from_capacity (10)
			Result.set_item (({BOOLEAN}).to_cil, boolean_code)
			Result.set_item (({CHARACTER}).to_cil, character_code)
			Result.set_item (({DOUBLE}).to_cil, real_64_code)
			Result.set_item (({REAL}).to_cil, real_32_code)
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
		
	codemap: NATIVE_ARRAY [SYSTEM_TYPE] is
			-- Conversion between `code' type and SYSTEM_TYPE object.
		once
			create Result.make (128)
			Result.put (boolean_code, {BOOLEAN})
			Result.put (character_code, {CHARACTER})
			Result.put (real_64_code, {DOUBLE})
			Result.put (real_32_code, {REAL})
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

	internal_primes: PRIMES is
			-- For quick access to prime numbers.
		once 
			create Result
		end

invariant
	non_void_native_array: native_array /= Void

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

