note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TYPEDEF_OR_REF

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

	TagBits: INTEGER = 2
			-- 2 bits to encode tag.
			-- https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=299&zoom=100,116,96
	TypeDef: INTEGER = 0
	TypeRef: INTEGER = 1
	TypeSpec: INTEGER = 2

feature -- Access

	tag_for_table (tb_id: NATURAL_32): INTEGER_32
			-- <Precursor/>
		do
			inspect tb_id
			when {PE_TABLES}.ttypedef then Result := typedef
			when {PE_TABLES}.ttyperef then Result := typeref
			when {PE_TABLES}.ttypespec then Result := typespec
			else
				Result := Precursor (tb_id)
			end
		end

feature -- Operations

	get_index_shift: INTEGER
			-- <Precursor>
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: SPECIAL [NATURAL_32]): BOOLEAN
			-- <Precursor>
		do
			Result := large (a_sizes, {PE_TABLES}.tTypeDef)
				or else large (a_sizes, {PE_TABLES}.tTypeRef)
				or else large (a_sizes, {PE_TABLES}.tTypeSpec)
		end

end
