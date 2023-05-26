note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIELD_MARSHAL

inherit

	PE_INDEX_BASE
		rename
			make as make_base
		redefine
			get_index_shift,
			has_index_overflow
		end

create
	make,
	make_with_tag_and_index

feature {NONE} -- Initialization

	make
		do
		end

feature -- Enum: tags

	TagBits: INTEGER = 1
	Field: INTEGER = 0
	Param: INTEGER = 1

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_64]): BOOLEAN
		do
			Result := large(a_sizes[{PE_TABLES}.tFile + 1].to_natural_32)
				or else large(a_sizes[{PE_TABLES}.tParam + 1].to_natural_32)
		end

end
