note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_IMPLEMENTATION

inherit

	PE_INDEX_BASE
		rename
			make as make_base
		redefine
			get_index_shift,
			has_index_overflow
		end

create
	make_with_tag_and_index,
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Enum: tags

	TagBits: INTEGER = 2
			-- Implementation
			-- 2 bits to encode.

	File: INTEGER = 0
	AssemblyRef: INTEGER = 1

		--Not used at the moment
	ExportedType: INTEGER = 2

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_64]): BOOLEAN
		do
			Result := large(a_sizes[{PE_TABLES}.tFile.to_integer_32 + 1].to_natural_32)
				or else large(a_sizes[{PE_TABLES}.tAssemblyRef.to_integer_32 + 1].to_natural_32)
		end

end
