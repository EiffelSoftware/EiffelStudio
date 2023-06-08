note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TYPEDEF_OR_REF

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
			-- 2 bits to encode tag.
			-- https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=299&zoom=100,116,96
	TypeDef: INTEGER = 0
	TypeRef: INTEGER = 1
	TypeSpec: INTEGER = 2

feature -- Operations

	get_index_shift: INTEGER
			-- <Precursor>
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
			-- <Precursor>
		do
			Result := large (a_sizes [{PE_TABLES}.tTypeDef.to_integer_32 + 1]) or else
				large (a_sizes [{PE_TABLES}.tTypeRef.to_integer_32 + 1]) or else
				large (a_sizes [{PE_TABLES}.tTypeSpec.to_integer_32 + 1])
		end

end
