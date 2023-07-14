note
	description: "[
			This class is the base class for index rendering
			it defines a tag type (which indicates which table the index belongs with) and an index value
			Based on the specific type of index being rendered, the index is shifted left by a constant and
			the tag is added in the lower bits.
			Note that these indexes are used in tables and also in the blobs, however, in the actual intermediate
			code a token is used.  The index in the is 24 bits unshifted, bits 24-31 holding the table number
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_INDEX_BASE

inherit
	PE_META_BASE
		redefine
			is_equal
		end

	DEBUG_OUTPUT
		redefine
			is_equal
		end

	MD_VISITABLE
		redefine
			is_equal
		end


create
	make_with_index

feature {NONE} -- Initialization

	make_with_index (a_index: NATURAL_32)
		do
			index := a_index
		ensure
			index_set: index = a_index
		end

feature -- Operations

	update_index (idx: like index)
		require
			valid_index: idx >= 0
		do
			debug ("il_emitter_table")
				print (Generator + ".update_index: 0x" + index.to_hex_string + " => 0x"+ idx.to_hex_string + "%N")
			end
			index := idx
		end


feature -- Status report

	is_coded_index: BOOLEAN
		do
			Result := False
		end

feature -- Access


	index: NATURAL_32
			-- The index used in tables and blobs.

	token: NATURAL_32
			-- Associated token for information.
		do
			Result := index
		end

	binary_value: NATURAL_32
			-- Value expected to be written in the binary.
		do
			Result := index
		end

feature -- Status report

	debug_output: STRING
		do
			Result := "0x" + token.to_hex_string
		end

	is_ready_for_render: BOOLEAN
		do
			Result := True
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' equal to the current object?
		do
			Result := index = other.index
		end

	same_as_index (other: PE_INDEX_BASE): BOOLEAN
		do
			Result := binary_value = other.binary_value
		end

	less_than_index (other: PE_INDEX_BASE): BOOLEAN
		do
			Result := binary_value < other.binary_value
		end

feature -- Operations

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]; a_pos: NATURAL_32): NATURAL_32
			-- Number of bytes written to the destination `a_dest`
		require
			valid_size: a_sizes.capacity = {PE_TABLE_CONSTANTS}.max_tables + {PE_TABLE_CONSTANTS}.extra_indexes
			is_ready_for_render: is_ready_for_render
		local
			v: NATURAL_32
		do
				--  Calculate the value to be written to the destination `a_dest`.
			v := index
			if has_index_overflow (a_sizes) then
					-- write the value as NATURAL_32 to the destination `a_dest`
				{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest, v, a_pos.to_integer_32)

				Result := 4
			else
					-- write the value as NATURAL_16 to the destination `a_dest`
				{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest, v.to_natural_16, a_pos.to_integer_32)
				Result := 2
			end
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]; a_pos: NATURAL_32): NATURAL_32
			-- Number of bytes read from the source `a_src`	at position `a_pos`
		require
			valid_size: a_sizes.capacity = {PE_TABLE_CONSTANTS}.max_tables + {PE_TABLE_CONSTANTS}.extra_indexes
		local
			v: NATURAL_32
		do
				-- Determine the size of the value to read from the source `a_src`
			if has_index_overflow (a_sizes) then
					-- Use a 32-bit Natural to store the value
					-- and set the return value to 4.
				v := {BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src, a_pos.to_integer_32)
				Result := 4
			else
					-- Use a 16-bit Natural to store the value
					-- and set the return value to 2.
				v := {BYTE_ARRAY_HELPER}.byte_array_to_natural_16 (a_src, a_pos.to_integer_32).to_natural_32
				Result := 2
			end
				-- Compute the index and tag values
			index := v
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
		require
			valid_size: a_sizes.capacity = {PE_TABLE_CONSTANTS}.max_tables + {PE_TABLE_CONSTANTS}.extra_indexes
		do
				-- to re redefined.
				--| Declared in C++ as virtual bool HasIndexOverflow(size_t sizes[MaxTables + ExtraIndexes]) const = 0;
				--| it's a pure virtual function. (same as `get_index_shift`)
		end

	large (a_x: NATURAL_32): BOOLEAN
		do
			Result := a_x > 0xffff
		end

feature -- Visitor

	accepts (vis: MD_VISITOR)
		do
			vis.visit_index (Current)
		end

end
