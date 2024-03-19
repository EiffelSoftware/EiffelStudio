note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_IMPLEMENTATION

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
			-- Implementation
			-- 2 bits to encode.

	File: INTEGER = 0
	AssemblyRef: INTEGER = 1
	ExportedType: INTEGER = 2

feature -- Access

	tag_for_table (tb_id: NATURAL_32): INTEGER_32
			-- <Precursor/>
		do
			inspect tb_id
			when {PE_TABLES}.tfile then Result := File
			when {PE_TABLES}.tassemblyref then Result := AssemblyRef
			when {PE_TABLES}.texportedtype then Result := ExportedType
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
				or else large (a_sizes, {PE_TABLES}.tAssemblyRef)
				or else large (a_sizes, {PE_TABLES}.texportedtype)
		end

end
