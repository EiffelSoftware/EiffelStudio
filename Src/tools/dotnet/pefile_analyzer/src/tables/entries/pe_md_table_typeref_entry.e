class
	PE_MD_TABLE_TYPEREF_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "TypeRef")
			structure := struct
			struct.add_resolution_scope ("ResolutionScope")
			struct.add_string_index ("TypeName")
			struct.add_string_index ("TypeNamespace")
		end

feature -- Access

	typename_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("TypeName")
		end

	typenamespace_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("TypeNamespace")
		end


end
