class
	PE_MD_TABLE_METHODDEF_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (6, "MethodDef")
			structure := struct
			struct.add_rva ("MethodRVA")
			struct.add_flags_16 ("Flags")
			struct.add_flags_16 ("ImplFlags")
			struct.add_string_index ("Name")
			struct.add_blob_index ("Signature")
			struct.add_param_list_index ("ParamList")
		end

feature -- Access

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

	namespace_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Namespace")
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tmethoddef
		end

end
