note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_RESOLUTION_SCOPE

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
			-- ResolutionScope
			-- 2 bits to encode.

	Module: INTEGER = 0
	ModuleRef: INTEGER = 1
	AssemblyRef: INTEGER = 2
	TypeRef: INTEGER = 3

feature -- Access

	tag_for_table (tb_id: NATURAL_32): INTEGER_32
			-- <Precursor/>
		do
			inspect tb_id
			when {PE_TABLES}.tmodule then Result := module
			when {PE_TABLES}.tmoduleref then Result := moduleref
			when {PE_TABLES}.tassemblyref then Result := assemblyref
			when {PE_TABLES}.ttyperef then Result := typeref
			else
				Result := Precursor (tb_id)
			end
		end

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_32]): BOOLEAN
		do
			Result := large(a_sizes[{PE_TABLES}.tModule.to_integer_32 + 1])
				or else large(a_sizes[{PE_TABLES}.tModuleRef.to_integer_32 + 1])
				or else large(a_sizes[{PE_TABLES}.tAssemblyRef.to_integer_32 + 1])
				or else large(a_sizes[{PE_TABLES}.tTypeRef.to_integer_32 + 1])
		end

end
