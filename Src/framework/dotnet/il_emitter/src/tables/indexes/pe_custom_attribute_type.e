note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_CUSTOM_ATTRIBUTE_TYPE

inherit
	PE_INDEX_BASE
		redefine
			get_index_shift,
			has_index_overflow
		end

create
	make_with_tag_and_index

feature -- Enum: tags

		-- custom attribute type
	TagBits: INTEGER = 3
			-- CustomAttributeType
			-- 3 bits to encode.
			-- 0, 1, and 4 are not used.
			-- https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=301

	MethodDef: INTEGER = 2
	MemberRef: INTEGER = 3

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
		do
			Result := large (a_sizes [{PE_TABLES}.tMethodDef.to_integer_32 + 1]) or else
				large (a_sizes [{PE_TABLES}.tMemberRef.to_integer_32 + 1])
		end

end
