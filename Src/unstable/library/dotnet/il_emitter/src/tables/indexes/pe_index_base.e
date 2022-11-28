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

	render (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		require
			valid_size: a_sizes.capacity = {PE_TABLE_CONSTANTS}.max_tables + {PE_TABLE_CONSTANTS}.extra_indexes
		do
			to_implement ("Add implementation");
		end

	get	(a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		require
			valid_size: a_sizes.capacity = {PE_TABLE_CONSTANTS}.max_tables + {PE_TABLE_CONSTANTS}.extra_indexes
		do
			to_implement ("Add implementation")
		end

	get_index_shift: INTEGER
		do
			Result := 0
		end

	has_index_overflow(a_sizes: ARRAY[NATURAL_64]): BOOLEAN
		require
			valid_size: a_sizes.capacity = {PE_TABLE_CONSTANTS}.max_tables + {PE_TABLE_CONSTANTS}.extra_indexes
		do
		end

	large (a_x: NATURAL_32): BOOLEAN
		do
			Result := (a_x |<< get_index_shift) > 0xffff
		end
end
