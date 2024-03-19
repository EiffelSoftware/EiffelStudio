note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_CUSTOM_ATTRIBUTE_TYPE

inherit
	PE_CODED_INDEX_BASE
		redefine
			get_index_shift,
			has_index_overflow,
			tag_for_table
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

feature -- Access

	tag_for_table (tb_id: NATURAL_32): INTEGER_32
			-- <Precursor/>
		do
			inspect tb_id
			when {PE_TABLES}.tmethoddef then Result := methoddef
			when {PE_TABLES}.tmemberref then Result := memberref
			else
				Result := Precursor (tb_id)
			end
		end

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: SPECIAL [NATURAL_32]): BOOLEAN
		do
			Result := large (a_sizes, {PE_TABLES}.tMethodDef)
				or else large (a_sizes, {PE_TABLES}.tMemberRef)
		end

end
