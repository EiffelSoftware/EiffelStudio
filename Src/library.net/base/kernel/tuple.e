indexing
	description: "Implementation of TUPLE";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

frozen class
	TUPLE

create

feature {NONE} -- Creation

	make (objects: ARRAY [ANY]; elt_types: ARRAY [CHARACTER]) is
			-- Create a TUPLE of `n' elements whose types
			-- are defined by `elt_types'.
		do
			area := objects
			types := elt_types
		end

feature -- Status

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid index to access object at position `i-th'?
		do
			Result := i >= area.lower and i <= area.upper
		end

feature -- Type queries

	is_boolean_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a BOOLEAN?
		require
			valid_index: valid_index (index)
		do
		end

	is_character_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a CHARACTER?
		require
			valid_index: valid_index (index)
		do
		end

	is_double_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a DOUBLE?
		require
			valid_index: valid_index (index)
		do
		end

	is_integer_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' an INTEGER?
		require
			valid_index: valid_index (index)
		do
		end

	is_real_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a REAL?
		require
			valid_index: valid_index (index)
		do
		end

	is_reference_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a REFERENCE?
		require
			valid_index: valid_index (index)
		do
		end

	is_numeric_item (index: INTEGER): BOOLEAN is
			-- Is item at `index' a number?
		require
			valid_index: valid_index (index)
		local
			tcode: CHARACTER
		do
		end

	is_uniform: BOOLEAN is
			-- Are all items of the same basic type or all of reference type?
		do
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_boolean: BOOLEAN is
			-- Are all items of type BOOLEAN?
		do
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_character: BOOLEAN is
			-- Are all items of type CHARACTER?
		do
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_double: BOOLEAN is
			-- Are all items of type DOUBLE?
		do
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_integer: BOOLEAN is
			-- Are all items of type INTEGER?
		do
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_real: BOOLEAN is
			-- Are all items of type REAL?
		do
		ensure
			yes_if_empty: (count = 0) implies Result
		end

	is_uniform_reference: BOOLEAN is
			-- Are all items of reference type?
		do
		ensure
			yes_if_empty: (count = 0) implies Result
		end

feature -- Access

	boolean_item (index: INTEGER): BOOLEAN is
			-- Boolean item at `index'.
		require
			valid_index: valid_index (index);
			is_boolean: is_boolean_item (index)
		do
		end

	character_item (index: INTEGER): CHARACTER is
			-- Character item at `index'.
		require
			valid_index: valid_index (index);
			is_character: is_character_item (index)
		do
		end

	double_item (index: INTEGER): DOUBLE is
			-- Double item at `index'.
		require
			valid_index: valid_index (index);
			is_numeric: is_numeric_item (index)
		do
		end

	integer_item (index: INTEGER): INTEGER is
			-- Integer item at `index'.
		require
			valid_index: valid_index (index);
			is_integer: is_integer_item (index)
		do
		end

	real_item (index: INTEGER): REAL is
			-- real item at `index'.
		require
			valid_index: valid_index (index);
			is_real_or_integer: is_real_item (index) or else is_integer_item (index)
		do
		end

feature {ROUTINE}

	arg_item_code (index: INTEGER): CHARACTER is
			-- Type code of item at `index'. Used for
			-- argument processing in ROUTINE
		require
			valid_index: valid_index (index)
		do
			Result := types.item (index)
		end

	boolean_code: CHARACTER is 'b'
	character_code: CHARACTER is 'c'
	double_code: CHARACTER is 'd'
	real_code: CHARACTER is 'f'
	integer_code: CHARACTER is 'i'
	pointer_code: CHARACTER is 'p'
	reference_code: CHARACTER is 'r'
	integer_8_code: CHARACTER is 'j'
	integer_16_code: CHARACTER is 'k'
	integer_64_code: CHARACTER is 'l'
	wide_char_code: CHARACTER is 'u'
			-- Runtime constants to represent types in TUPLE.

feature {NONE} -- Implementation

	area: ARRAY [ANY]
			-- Storage of elements of Current.
			--| Every basic types are converted to their boxed value.

	types: ARRAY [CHARACTER]
			-- Store types of elements of Current.

	count: INTEGER is
			-- Number of elements in `area'.
		do
			Result := area.count
		end

invariant
	area_not_void: area /= Void

end -- class TUPLE


