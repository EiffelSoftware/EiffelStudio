class
	PE_MD_TABLE_METHODSEMANTICS_ENTRY

inherit
	PE_MD_TABLE_COMPARABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (6, "MethodSemantics")
			structure := struct
			struct.add_natural_16 ("Semantics")
			struct.add_method_def_index ("Method")
			struct.add_has_semantic ("Association")
		end

feature -- Access

	association_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Association")
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := index_is_less_than (association_index, other.association_index)
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tmethodsemantics
		end

end
