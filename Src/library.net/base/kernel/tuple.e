indexing

	description: "Implementation of TUPLE"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE

create
	make

feature -- Creation

	make is
			-- Create instance of TUPLE.
		local
			l_count: INTEGER
		do
			l_count := feature {ISE_RUNTIME}.generic_parameter_count (Current)
			create native_array.make (l_count)
		end

feature -- Access

	item, infix "@" (k: INTEGER): ANY is
			-- Entry of key `k'.
		require
			valid_index: valid_index (k)
		do
			Result ?= native_array.item (k - 1)
		end

feature {ROUTINE} -- Fast access

	fast_item (k: INTEGER): SYSTEM_OBJECT is
		require
			valid_index: valid_index (k + 1)
		do
			Result := native_array.item (k)
		end

feature -- Status report

	valid_index (k: INTEGER): BOOLEAN is
			-- Is `k' a valid key?
		do
			Result := k >= 1 and then k <= native_array.count
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

feature -- Element change

	put (v: SYSTEM_OBJECT; k: INTEGER) is
			-- Associate value `v' with key `k'.
		require
			valid_index: valid_index (k)
		do
			native_array.put (k - 1, v)
		end
	
feature -- Type queries

	is_boolean_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a BOOLEAN?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode.item (index - 1) = boolean_code)
		end

	is_character_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a CHARACTER?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode.item (index - 1) = character_code)
		end

	is_double_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a DOUBLE?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode.item (index - 1) = double_code)
		end

	is_integer_8_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode.item (index - 1) = integer_8_code)
		end

	is_integer_16_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode.item (index - 1) = integer_16_code)
		end

	is_integer_item, is_integer_32 (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode.item (index - 1) = integer_code)
		end

	is_integer_64_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode.item (index - 1) = integer_64_code)
		end

	is_pointer_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a POINTER?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode.item (index - 1) = pointer_code)
		end

	is_real_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a REAL?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode.item (index - 1) = real_code)
		end

	is_reference_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a REFERENCE?
		require
			valid_index: valid_index (index)
		do
			Result := (generic_typecode.item (index - 1) = reference_code)
		end

	is_numeric_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a number?
		require
			valid_index: valid_index (index)
		local
			tcode: INTEGER_8
		do
			tcode := generic_typecode.item (index - 1)
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
			if count > 0 then
				Result := is_tuple_uniform (reference_code)
			else
				Result := True
			end
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_boolean: BOOLEAN is
			-- Are all items of type BOOLEAN?
		do
			if count > 0 then
				Result := is_tuple_uniform (boolean_code)
			else
				Result := True
			end
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_character: BOOLEAN is
			-- Are all items of type CHARACTER?
		do
			if count > 0 then
				Result := is_tuple_uniform (character_code)
			else
				Result := True
			end
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_double: BOOLEAN is
			-- Are all items of type DOUBLE?
		do
			if count > 0 then
				Result := is_tuple_uniform (double_code)
			else
				Result := True
			end
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_integer: BOOLEAN is
			-- Are all items of type INTEGER?
		do
			if count > 0 then
				Result := is_tuple_uniform (integer_code)
			else
				Result := True
			end
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_pointer: BOOLEAN is
			-- Are all items of type POINTER?
		do
			if count > 0 then
				Result := is_tuple_uniform (pointer_code)
			else
				Result := True
			end
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_real: BOOLEAN is
			-- Are all items of type REAL?
		do
			if count > 0 then
				Result := is_tuple_uniform (real_code)
			else
				Result := True
			end
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_reference: BOOLEAN is
			-- Are all items of reference type?
		do
			if count > 0 then
				Result := is_tuple_uniform (reference_code)
			else
				Result := True
			end
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
				tcode := generic_typecode.item (i)
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
				tcode := generic_typecode.item (i)
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

feature -- Access

	boolean_item (index: INTEGER): BOOLEAN is
			-- Boolean item at `index'.
		require
			valid_index: valid_index (index)
			is_boolean: is_boolean_item (index)
		do
			Result ?= item (index)
		end

	character_item (index: INTEGER): CHARACTER is
			-- Character item at `index'.
		require
			valid_index: valid_index (index)
			is_character: is_character_item (index)
		do
			Result ?= item (index)
		end

	double_item (index: INTEGER): DOUBLE is
			-- Double item at `index'.
		require
			valid_index: valid_index (index)
			is_numeric: is_numeric_item (index)
		do
			Result ?= item (index)
		end

	integer_8_item (index: INTEGER): INTEGER_8 is
			-- Integer item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_8_item (index)
		do
			Result ?= item (index)
		end

	integer_16_item (index: INTEGER): INTEGER_16 is
			-- Integer item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_16_item (index)
		do
			Result ?= item (index)
		end

	integer_item, integer_32_item (index: INTEGER): INTEGER is
			-- Integer item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_item (index)
		do
			Result ?= item (index)
		end

	integer_64_item (index: INTEGER): INTEGER_64 is
			-- Integer item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_64_item (index)
		do
			Result ?= item (index)
		end

	pointer_item (index: INTEGER): POINTER is
			-- Pointer item at `index'.
		require
			valid_index: valid_index (index)
			is_pointer: is_pointer_item (index)
		do
			Result ?= item (index)
		end

	real_item (index: INTEGER): REAL is
			-- real item at `index'.
		require
			valid_index: valid_index (index)
			is_real_or_integer: is_real_item (index) or else is_integer_item (index)
		do
			Result ?= item (index)
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
				a ?= item (i)
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
				s ?= item (i)
				Result.put (s, i)
				i := i + 1
			end
		ensure
			exists: Result /= Void
			same_count: Result.count = count
		end

feature {ROUTINE, TUPLE}

	arg_item_code (index: INTEGER): INTEGER_8 is
			-- Type code of item at `index'. Used for
			-- argument processing in ROUTINE
		require
			valid_index: valid_index (index)
		do
				-- FIXME
			Result := generic_typecode.item (index - 1)
		end

	boolean_code: INTEGER_8 is 0
	character_code: INTEGER_8 is 1
	double_code: INTEGER_8 is 2
	real_code: INTEGER_8 is 3
	integer_code: INTEGER_8 is 4
	pointer_code: INTEGER_8 is 5
	reference_code: INTEGER_8 is 6
	integer_8_code: INTEGER_8 is 7
	integer_16_code: INTEGER_8 is 8
	integer_64_code: INTEGER_8 is 9
			-- Code used to identify type in tuple.

	valid_typecode (code: INTEGER_8): BOOLEAN is
			-- Ensure that `code' is indeed a valid typecode.
		do
			Result := code >= 0 and code <= 9
		end
		
feature {NONE} -- Implementation

	native_array: NATIVE_ARRAY [SYSTEM_OBJECT]
			-- Storage where values are kept.

	is_tuple_uniform (code: INTEGER_8): BOOLEAN is
			-- Are all items in `obj' of type `code'?
		require
			valid_count: count > 0
		local
			i, nb: INTEGER
			first_type, type: TYPE
		do
			from
				i := 2
				nb := count
				if code /= reference_code then
					first_type := codemap.item (code)
				else
					first_type := item (1).get_type
				end
			until
				i > nb or not Result
			loop
				Result := first_type.equals_object (item (i))
				i := i + 1
			end
		end

	generic_typecode: NATIVE_ARRAY [INTEGER_8] is
			-- Code for generic parameter `pos' in `obj'.
		do
			check
				False
			end
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
			Result.put (integer_8_code, feature {TYPE}.get_type_string (("System.Int8").to_cil))
			Result.put (integer_16_code, feature {TYPE}.get_type_string (("System.Int16").to_cil))
			Result.put (integer_64_code, feature {TYPE}.get_type_string (("System.Int64").to_cil))
		end
	
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

