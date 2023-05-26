note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_RESOLUTION_SCOPE

inherit

	PE_INDEX_BASE
		redefine
			get_index_shift,
			has_index_overflow
		end

create
	make,
	make_with_tag_and_index


feature -- Enum: tags

	TagBits: INTEGER = 2
	Module: INTEGER = 0
	ModuleRef: INTEGER = 1
	AssemblyRef: INTEGER = 2
	TypeRef: INTEGER = 3

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_64]): BOOLEAN
		do
			Result := large(a_sizes[{PE_TABLES}.tModule.to_integer_32 + 1].to_natural_32)
				or else large(a_sizes[{PE_TABLES}.tModuleRef.to_integer_32 + 1].to_natural_32)
				or else large(a_sizes[{PE_TABLES}.tAssemblyRef.to_integer_32 + 1].to_natural_32)
				or else large(a_sizes[{PE_TABLES}.tTypeRef.to_integer_32 + 1].to_natural_32)
		end

end
