note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_DECL_SECURITY

inherit
	PE_CODED_INDEX_BASE
		redefine
			get_index_shift,
			has_index_overflow
		end

create
	make_with_tag_and_index

feature -- Enum: tags

	TagBits: INTEGER = 2
			-- HasDeclSecurity
			-- https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=300

	TypeDef: INTEGER = 0
	MethodDef: INTEGER = 1
	Assembly: INTEGER = 2

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: SPECIAL [NATURAL_32]): BOOLEAN
		do
			Result := large (a_sizes, {PE_TABLES}.tMethodDef)
				or else large (a_sizes, {PE_TABLES}.tTypeDef)
				or else large (a_sizes, {PE_TABLES}.tAssemblyDef)
		end

end
