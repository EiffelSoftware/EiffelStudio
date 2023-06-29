class
	PE_MD_TABLE_CONSTANT_ENTRY

inherit
	PE_MD_TABLE_COMPARABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "Constant")
			structure := struct
			struct.add_natural_16 ("Type")
			struct.add_has_constant ("Parent")
			struct.add_blob_index ("Value")
		end

feature -- Access

	parent_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Parent")
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := index_is_less_than (parent_index, other.parent_index)
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tconstant
		end

end
