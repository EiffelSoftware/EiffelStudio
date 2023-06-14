note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MEMBER_FORWARDED

inherit
	PE_INDEX_BASE
		redefine
			get_index_shift,
			has_index_overflow
		end

create
	make_with_tag_and_index

feature -- Enum: tags

	TagBits: INTEGER = 1
		-- MemberForwarded
		-- 1 bit to encode.
		-- https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=301

	FieldDef: INTEGER = 0
	MethodDef: INTEGER = 1

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
		do
			Result := large(a_sizes[{PE_TABLES}.tField.to_integer_32 + 1]) or else
					  large(a_sizes[{PE_TABLES}.tMethodDef.to_integer_32 + 1])
		end

end
