note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_DECL_SECURITY

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

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
		do
			fixme ("Todo double check this code.")
			Result := large (a_sizes [{PE_TABLES}.tMethodDef.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tTypeDef.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tMethodDef.to_integer_32 + 1].to_natural_32) or else  -- it seems here there is an issue.
				large (a_sizes [{PE_TABLES}.tAssemblyDef.to_integer_32 + 1].to_natural_32)
		end

end
