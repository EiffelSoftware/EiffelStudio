note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TYPE_OR_METHOD_DEF

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

	TagBits: INTEGER = 1
			-- TypeOrMethodDef
			-- 1 bit to encode.
			-- https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=302

	TypeDef: INTEGER = 0
	MethodDef: INTEGER = 1

feature -- Operations

	get_index_shift: INTEGER
			-- <Precursor>
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
			--<Precursor>
		do
			 Result := large(a_sizes[{PE_TABLES}.tTypeDef.to_integer_32 + 1]) or else
			 		   large(a_sizes[{PE_TABLES}.tMethodDef.to_integer_32 + 1])
		end

end
