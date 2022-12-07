note
	description: "[
			This class is the base class for index rendering
			it defines a tag type (which indicates which table the index belongs with) and an index value
			Based on the specific type of index being rendered, the index is shifted left by a constant and
			the tag is added in the lower bits.
			Note that these indexes are used in tables and also in the blobs, however, in the actual intermediate
			code a token is used.  the index in the is 24 bits unshifted, bits 24-31 holding the table number
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_INDEX_BASE

inherit

	PE_META_BASE

create
	make,
	make_with_index,
	make_with_tag_and_index

feature {NONE} -- Initialization

	make
		do
		ensure
			tag_zero: tag = 0
			index_zet: index = 0
		end

	make_with_index (a_index: NATURAL_64)
		do
			index := a_index
		ensure
			index_set: index = a_index
			tag_zero: tag = 0
		end

	make_with_tag_and_index (a_tag: INTEGER; a_index: NATURAL_64)
		do
			make_with_index (a_index)
			tag := a_tag
		ensure
			tag_set: tag = a_tag
			index_set: index = a_index
		end

feature -- Access

	tag: INTEGER

	index: NATURAL_64

feature -- Operations

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]; a_pos: INTEGER): NATURAL_64
		require
			valid_size: a_sizes.capacity = {PE_TABLE_CONSTANTS}.max_tables + {PE_TABLE_CONSTANTS}.extra_indexes
		local
			l_rv: NATURAL_64
			l_val: NATURAL_32
		do
				--  Calculate the value to be written to the destintation `a_dest`.
			l_val := ((index |<< get_index_shift) + tag.to_natural_64).to_natural_32


			if has_index_overflow (a_sizes) then
					-- write the value as NATURAL_32 to the destination `a_dest`
					-- and set the return value to 4.
				{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest, l_val, a_pos)
				l_rv := 4
			else
					-- write the value as NATURAL_16 to the destination `a_dest`
					-- and set the return value to 2.
				{BYTE_ARRAY_HELPER}.put_array_natural_16_with_natural_32 (a_dest, l_val, a_pos)
				l_rv := 2
			end
				-- Return the number of bytes written to the destination `a_dest`
			Result := l_rv
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]; a_pos: INTEGER): NATURAL_64
		require
			valid_size: a_sizes.capacity = {PE_TABLE_CONSTANTS}.max_tables + {PE_TABLE_CONSTANTS}.extra_indexes
		local
			l_val: NATURAL_64
			l_rv: NATURAL_64
		do
				-- Determine the size of the value to read from the source `a_src`
			if has_index_overflow (a_sizes) then
					-- Use a 32-bit Natural to store the value
					-- and set the return value to 4.
				l_val := {BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src.to_special, a_pos)
				l_rv := 4
			else
					-- Use a 16-bit Natural to store the value
					-- and set the return value to 2.
				l_val := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src.to_special, a_pos)
				l_rv := 2
			end
				-- Compute the index and tag values
			index := l_val |>> get_index_shift
			tag := (l_val & (({INTEGER} 1 |<< get_index_shift - 1)).to_natural_64).to_integer_32
				-- Return the number of bytes read from the source `a_src`
			Result := l_rv
		end

	get_index_shift: INTEGER
		do
				-- to be redefined
				--| Declared in C++ as virtual int GetIndexShift() const = 0;
				--| it's a pure virtual function. So the function doesn't change
				--| the data of the class.
				--| In Eiffel we could declared it as deferred.
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_64]): BOOLEAN
		require
			valid_size: a_sizes.capacity = {PE_TABLE_CONSTANTS}.max_tables + {PE_TABLE_CONSTANTS}.extra_indexes
		do
				-- to re redefined.
				--| Declared in C++ as virtual bool HasIndexOverflow(size_t sizes[MaxTables + ExtraIndexes]) const = 0;
				--| it's a pure virtual function. (same as `get_index_shift`)
		end

	large (a_x: NATURAL_32): BOOLEAN
		do
			Result := (a_x |<< get_index_shift) > 0xffff
		end

end
