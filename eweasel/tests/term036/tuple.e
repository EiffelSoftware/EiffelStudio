note

	description: "Implementation of TUPLE"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE

inherit
	ARRAY [detachable separate ANY]
		rename
			make as array_make
		end

create
	make

create {TUPLE} 
	array_make

feature -- Creation

	make

		do
			array_make (1, eif_gen_count ($Current))
		end

feature -- Type queries

	is_boolean_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a BOOLEAN?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_gen_typecode ($Current, index) = boolean_code)
		end

	is_character_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a CHARACTER?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_gen_typecode ($Current, index) = character_code)
		end

	is_double_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a DOUBLE?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_gen_typecode ($Current, index) = double_code)
		end

	is_integer_8_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an INTEGER_8?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_gen_typecode ($Current, index) = integer_8_code)
		end

	is_integer_16_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an INTEGER_16?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_gen_typecode ($Current, index) = integer_16_code)
		end

	is_integer_item, is_integer_32_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an INTEGER?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_gen_typecode ($Current, index) = integer_code)
		end

	is_integer_64_item (index: INTEGER): BOOLEAN
			-- Is item at `index' an INTEGER_64?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_gen_typecode ($Current, index) = integer_64_code)
		end

	is_pointer_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a POINTER?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_gen_typecode ($Current, index) = pointer_code)
		end

	is_real_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a REAL?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_gen_typecode ($Current, index) = real_code)
		end

	is_reference_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a REFERENCE?
		require
			valid_index: valid_index (index)
		do
			Result := (eif_gen_typecode ($Current, index) = reference_code)
		end

	is_numeric_item (index: INTEGER): BOOLEAN
			-- Is item at `index' a number?
		require
			valid_index: valid_index (index)
		local
			tcode: CHARACTER
		do
			tcode := eif_gen_typecode ($Current, index)
			Result := (tcode = integer_code) or else
					 (tcode = real_code) or else
					 (tcode = double_code)
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

	is_uniform_character: BOOLEAN
			-- Are all items of type CHARACTER?
		do
			Result := is_tuple_uniform (character_code)
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_double: BOOLEAN
			-- Are all items of type DOUBLE?
		do
			Result := is_tuple_uniform (double_code)
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
			Result := is_tuple_uniform (integer_code)
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
			-- Are all items of type REAL?
		do
			Result := is_tuple_uniform (real_code)
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

feature -- Type conversion queries

	convertible_to_double: BOOLEAN
			-- Is current convertible to an array of doubles?
		local
			i, cnt: INTEGER
			tcode: CHARACTER
		do
			Result := True
			from
				i := 1
				cnt := count
			until
				i > cnt or else not Result
			loop
				tcode := eif_gen_typecode ($Current, i)
				Result := (tcode = integer_code) or else 
						 (tcode = real_code) or else 
						 (tcode = double_code)
				i := i + 1
			end
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	convertible_to_real: BOOLEAN
			-- Is current convertible to an array of reals?
		local
			i, cnt: INTEGER
			tcode: CHARACTER
		do
			Result := True
			from
				i := 1
				cnt := count
			until
				i > cnt or else not Result
			loop
				tcode := eif_gen_typecode ($Current, i)
				Result := (tcode = integer_code) or else (tcode = real_code)
				i := i + 1
			end
		ensure
			yes_if_empty: (count = 0) implies Result
		end

feature -- Access

	boolean_item (index: INTEGER): BOOLEAN
			-- Boolean item at `index'.
		require
			valid_index: valid_index (index)
			is_boolean: is_boolean_item (index)
		local
			ref: BOOLEAN_REF
		do
			ref ?= item (index)
			if ref /= Void then
				Result := ref.item
			end
		end

	character_item (index: INTEGER): CHARACTER
			-- Character item at `index'.
		require
			valid_index: valid_index (index)
			is_character: is_character_item (index)
		local
			ref: CHARACTER_REF
		do
			ref ?= item (index)
			if ref /= Void then
				Result := ref.item
			end
		end

	double_item (index: INTEGER): DOUBLE
			-- Double item at `index'.
		require
			valid_index: valid_index (index)
			is_numeric: is_numeric_item (index)
		local
			iref: INTEGER_REF
			rref: REAL_REF
			dref: DOUBLE_REF
		do
			dref ?= item (index)
			if dref /= Void then
				Result := dref.item
			else
				rref ?= item (index)
				if rref /= Void then
					Result := rref.item
				else
					iref ?= item (index)
					if iref /= Void then
						Result := iref.item
					end
				end
			end
		end

	integer_8_item (index: INTEGER): INTEGER_8
			-- Integer item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_8_item (index)
		local
			ref: INTEGER_8_REF
		do
			ref ?= item (index)
			if ref /= Void then
				Result := ref.item
			end
		end

	integer_16_item (index: INTEGER): INTEGER_16
			-- Integer item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_16_item (index)
		local
			ref: INTEGER_16_REF
		do
			ref ?= item (index)
			if ref /= Void then
				Result := ref.item
			end
		end

	integer_item, integer_32_item (index: INTEGER): INTEGER
			-- Integer item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_item (index)
		local
			ref: INTEGER_REF
		do
			ref ?= item (index)
			if ref /= Void then
				Result := ref.item
			end
		end

	integer_64_item (index: INTEGER): INTEGER_64
			-- Integer item at `index'.
		require
			valid_index: valid_index (index)
			is_integer: is_integer_64_item (index)
		local
			ref: INTEGER_64_REF
		do
			ref ?= item (index)
			if ref /= Void then
				Result := ref.item
			end
		end

	pointer_item (index: INTEGER): POINTER
			-- Pointer item at `index'.
		require
			valid_index: valid_index (index)
			is_pointer: is_pointer_item (index)
		local
			ref: POINTER_REF
		do
			ref ?= item (index)
			if ref /= Void then
				Result := ref.item
			end
		end

	real_item (index: INTEGER): REAL
			-- real item at `index'.
		require
			valid_index: valid_index (index)
			is_real_or_integer: is_real_item (index) or else is_integer_item (index)
		local
			iref: INTEGER_REF
			rref: REAL_REF
			dref: DOUBLE_REF
		do
			rref ?= item (index)
			if rref /= Void then
				Result := rref.item
			else
				iref ?= item (index)
				if iref /= Void then
					Result := iref.item
				else
					-- Special case (manifest TUPLEs)
					dref ?= item (index)
					if dref /= Void then
						Result := dref.truncated_to_real
					end
				end
			end
		end

feature -- Conversion

	arrayed: ARRAY [detachable separate ANY]
			-- Items of Current as array
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

	boolean_arrayed: ARRAY [BOOLEAN]
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

	character_arrayed: ARRAY [CHARACTER]
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

	double_arrayed: ARRAY [DOUBLE]
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

	integer_arrayed: ARRAY [INTEGER]
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

	pointer_arrayed: ARRAY [POINTER]
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

	real_arrayed: ARRAY [REAL]
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

	string_arrayed: ARRAY [STRING]
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

feature {ROUTINE}

	arg_item_code (index: INTEGER): CHARACTER
			-- Type code of item at `index'. Used for
			-- argument processing in ROUTINE
		require
			valid_index: valid_index (index)
		do
			Result := eif_gen_typecode ($Current, index)
		end

feature {NONE} -- Implementation

	boolean_code: CHARACTER = 'b'
	character_code: CHARACTER = 'c'
	double_code: CHARACTER = 'd'
	real_code: CHARACTER = 'f'
	integer_code: CHARACTER = 'i'
	pointer_code: CHARACTER = 'p'
	reference_code: CHARACTER = 'r'
	integer_8_code: CHARACTER = 'j'
	integer_16_code: CHARACTER  = 'k'
	integer_64_code: CHARACTER = 'l'
	any_code: CHARACTER = '?'
			-- Code used to identify type in TUPLE.

	is_tuple_uniform (code: CHARACTER): BOOLEAN
			-- Are all items of type `code'? 
		do
			if count > 0 then
				Result := eif_gen_is_uniform ($Current, code)
			else
				Result := True
			end
		end

	eif_gen_is_uniform (obj: POINTER; code: CHARACTER): BOOLEAN
			-- Are all items in `obj' of type `code'?
		external
			"C | %"eif_gen_conf.h%""
		end

	eif_gen_typecode (obj: POINTER; pos: INTEGER): CHARACTER
			-- Code for generic parameter `pos' in `obj'.
		external
			"C | %"eif_gen_conf.h%""
		end

	eif_gen_count (obj: POINTER): INTEGER
			-- Number of generic parameters of `obj'.
		external
			"C | %"eif_gen_conf.h%""
		end

note

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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

