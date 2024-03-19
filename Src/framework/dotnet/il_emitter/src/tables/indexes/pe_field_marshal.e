note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIELD_MARSHAL

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

	TagBits: INTEGER = 1
			-- HasFieldMarshall 1 bit to encode.
			-- https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=299&zoom=100,116,96
	Field: INTEGER = 0
	Param: INTEGER = 1

feature -- Access

	tag_for_table (tb_id: NATURAL_32): INTEGER_32
			-- <Precursor/>
		do
			inspect tb_id
			when {PE_TABLES}.tfield then Result := field
			when {PE_TABLES}.tparam then Result := param
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
			Result := large (a_sizes, {PE_TABLES}.tFile)
				or else large (a_sizes, {PE_TABLES}.tParam)
		end

end
