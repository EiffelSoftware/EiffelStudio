indexing
	description: "Implementation of TUPLE"
	status: "See notice at end of class"
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
			l_count := feature {ISE_RUNTIME}.generic_parameter_count (Current)
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

	item, infix "@" (index: INTEGER): ANY is
			-- Entry of key `index'.
		require
			valid_index: valid_index (index)
		do
			Result ?= native_array.item (index - 1)
			if Result = Void then
					-- This is not an Eiffel reference type, it must be
					-- a basic type. If not we do nothing.
				inspect arg_item_code (index)
				when boolean_code then Result := boolean_item (index)
				when character_code then Result := character_item (index)
				when double_code then Result := double_item (index)
				when real_code then Result := real_item (index)
				when pointer_code then Result := pointer_item (index)
				when integer_code then Result := integer_32_item (index)
				when integer_8_code then Result := integer_8_item (index)
				when integer_16_code then Result := integer_16_item (index)
				when integer_64_code then Result := integer_64_item (index)
				when reference_code then
						-- It is a reference which is not of type ANY. We return
						-- Void for now.
				end
			end
		end

	reference_item (index: INTEGER): ANY is
			-- Reference item at `index'.
		require
			valid_index: valid_index (index)
			is_reference: is_reference_item (index)
		do
			Result ?= native_array.item (index - 1)
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

	double_item (index: INTEGER): DOUBLE is
			-- Double item at `index'.
		require
			valid_index: valid_index (index)
			is_numeric: is_numeric_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	integer_8_item (index: INTEGER): INTEGER_8 is
			-- Integer item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_8_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	integer_16_item (index: INTEGER): INTEGER_16 is
			-- Integer item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_16_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	integer_item, integer_32_item (index: INTEGER): INTEGER is
			-- Integer item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_item (index)
		do
			Result ?= fast_item (index - 1)
		end

	integer_64_item (index: INTEGER): INTEGER_64 is
			-- Integer item at `index'.
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

	real_item (index: INTEGER): REAL is
			-- real item at `index'.
		require
			valid_index: valid_index (index)
			is_real_or_integer: is_real_item (index) or else is_integer_item (index)
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
					Result := l_cur.item (i) = l_other.item (i)
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
				feature {SYSTEM_ARRAY}.copy (other.native_array, native_array, nb)
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
			l_b: BOOLEAN
			l_c: CHARACTER
			l_d: DOUBLE
			l_r: REAL
			l_p: POINTER
			l_i: INTEGER
			l_i8: INTEGER_8
			l_i16: INTEGER_16
			l_i64: INTEGER_64
			retried: BOOLEAN
			l_int: INTERNAL
			l_any: ANY
			l_child, l_parent: TYPE
		do
			if not retried then
				if v = Void then
						-- A Void entry is always valid.
					Result := True
				else
					Result := True
					inspect arg_item_code (index)
					when boolean_code then l_b ?= v
					when character_code then l_c ?= v
					when double_code then l_d ?= v
					when real_code then l_r ?= v
					when pointer_code then l_p ?= v
					when integer_code then l_i ?= v
					when integer_8_code then l_i8 ?= v
					when integer_16_code then l_i16 ?= v
					when integer_64_code then l_i64 ?= v
					when Reference_code then
						l_any ?= v
						if l_any /= Void then
								-- Let's check that type of `v' conforms to specified type of `index'-th
								-- arguments of current TUPLE.
							create l_int
							Result := l_int.type_conforms_to
								(l_int.dynamic_type (l_any), l_int.generic_dynamic_type (Current, index))
						else
								-- Let's check that type of `v' conforms to specified type of `index'-th
								-- arguments of current TUPLE, this time we use simple .NET type conformance.
							l_child := v.get_type
							l_parent := feature {ISE_RUNTIME}.type_of_generic_parameter (Current, index)
							Result := l_parent.is_assignable_from (l_child)
						end
					end
				end
			else
				Result := False
			end
		rescue
				-- It failed most likely because one of the above assignment attempts on basic types failed.
				-- Therefore it is not valid.
			retried := True
			retry
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
		
	put_double (v: DOUBLE; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_double_item (index)
		do
			native_array.put (index - 1, v)
		end
		
	put_real (v: REAL; index: INTEGER) is
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
		
	put_integer, put_integer_32 (v: INTEGER; index: INTEGER) is
			-- Put `v' at position `index' in Current.
		require
			valid_index: valid_index (index)
			valid_type: is_integer_item (index)
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
			Result := (generic_typecode (index - 1) = double_code)
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
			Result := (generic_typecode (index - 1) = integer_code)
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
			Result := (generic_typecode (index - 1) = real_code)
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
		require
			valid_index: valid_index (index)
		local
			tcode: INTEGER_8
		do
			tcode := generic_typecode (index - 1)
			inspect tcode
			when
				integer_8_code, integer_16_code, integer_code,
				integer_64_code, real_code, double_code
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
			Result := is_tuple_uniform (double_code)
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
			Result := is_tuple_uniform (integer_code)
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
			Result := is_tuple_uniform (real_code)
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
		local
			i, cnt: INTEGER
			tcode: INTEGER_8
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
					integer_8_code, integer_16_code, integer_code,
					integer_64_code, real_code, double_code
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
		local
			i, cnt: INTEGER
			tcode: INTEGER_8
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
					integer_8_code, integer_16_code, integer_code,
					integer_64_code, real_code
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
				Result.put (integer_item (i), i)
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
			same_items: -- Items are the same in same order
		end

	pointer_arrayed: ARRAY [POINTER] is
			-- Items of Current as array
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

feature {ROUTINE, TUPLE}

	arg_item_code (index: INTEGER): INTEGER_8 is
			-- Type code of item at `index'. Used for
			-- argument processing in ROUTINE
		require
			valid_index: valid_index (index)
		do
				-- FIXME
			Result := generic_typecode (index - 1)
		end

	reference_code: INTEGER_8 is 0x00
	boolean_code: INTEGER_8 is 0x01
	character_code: INTEGER_8 is 0x02
	double_code: INTEGER_8 is 0x03
	real_code: INTEGER_8 is 0x04
	pointer_code: INTEGER_8 is 0x05
	integer_8_code: INTEGER_8 is 0x06
	integer_16_code: INTEGER_8 is 0x07
	integer_code: INTEGER_8 is 0x08
	integer_64_code: INTEGER_8 is 0x09
	any_code: INTEGER_8 is 0xFF
			-- Code used to identify type in tuple.

	valid_typecode (code: INTEGER_8): BOOLEAN is
			-- Ensure that `code' is indeed a valid typecode.
		do
			Result := code >= 0 and code <= 9
		end
		
feature {TUPLE} -- Implementation

	native_array: NATIVE_ARRAY [SYSTEM_OBJECT]
			-- Storage where values are kept.

feature {NONE} -- Implementation

	is_tuple_uniform (code: INTEGER_8): BOOLEAN is
			-- Are all items of type `code'?
		local
			i, nb: INTEGER
			first_type, type: TYPE
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
					Result := feature {SYSTEM_OBJECT}.equals_object_object (first_type, type)
					i := i + 1
				end
			end
		end

	generic_typecode (pos: INTEGER): INTEGER_8 is
			-- Code for generic parameter `pos' in `obj'.
		local
			l_item: SYSTEM_OBJECT
		do
			l_item := fast_item (pos)
			if l_item /= Void then
				l_item := reverse_lookup.item (l_item.get_type)
				if l_item /= Void then
					Result ?= l_item
				else
					Result := reference_code
				end
			else
				Result := reference_code
			end
		end

	reverse_lookup: HASHTABLE is
			-- Given a TYPE object, returns its associated `typecode'.
		once
			create Result.make_from_capacity (10)
			Result.set_item (feature {TYPE}.get_type_string (("System.Boolean").to_cil), boolean_code)
			Result.set_item (feature {TYPE}.get_type_string (("System.Char").to_cil), character_code)
			Result.set_item (feature {TYPE}.get_type_string (("System.Double").to_cil), double_code)
			Result.set_item (feature {TYPE}.get_type_string (("System.Single").to_cil), real_code)
			Result.set_item (feature {TYPE}.get_type_string (("System.Int32").to_cil), integer_code)
			Result.set_item (feature {TYPE}.get_type_string (("System.IntPtr").to_cil), pointer_code)
			Result.set_item (feature {TYPE}.get_type_string (("System.Object").to_cil), reference_code)
			Result.set_item (feature {TYPE}.get_type_string (("System.Byte").to_cil), integer_8_code)
			Result.set_item (feature {TYPE}.get_type_string (("System.Int16").to_cil), integer_16_code)
			Result.set_item (feature {TYPE}.get_type_string (("System.Int64").to_cil), integer_64_code)
		end
		
	codemap: NATIVE_ARRAY [TYPE] is
			-- Conversion between `code' type and TYPE object.
		once
			create Result.make (128)
			Result.put (boolean_code, feature {TYPE}.get_type_string (("System.Boolean").to_cil))
			Result.put (character_code, feature {TYPE}.get_type_string (("System.Char").to_cil))
			Result.put (double_code, feature {TYPE}.get_type_string (("System.Double").to_cil))
			Result.put (real_code, feature {TYPE}.get_type_string (("System.Single").to_cil))
			Result.put (integer_code, feature {TYPE}.get_type_string (("System.Int32").to_cil))
			Result.put (pointer_code, feature {TYPE}.get_type_string (("System.IntPtr").to_cil))
			Result.put (reference_code, feature {TYPE}.get_type_string (("System.Object").to_cil))
			Result.put (integer_8_code, feature {TYPE}.get_type_string (("System.Byte").to_cil))
			Result.put (integer_16_code, feature {TYPE}.get_type_string (("System.Int16").to_cil))
			Result.put (integer_64_code, feature {TYPE}.get_type_string (("System.Int64").to_cil))
		end

	internal_primes: PRIMES is
			-- For quick access to prime numbers.
		once 
			create Result
		end

invariant
	non_void_native_array: native_array /= Void

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class TUPLE

