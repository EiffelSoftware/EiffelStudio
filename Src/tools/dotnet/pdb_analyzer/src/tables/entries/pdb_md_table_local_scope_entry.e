class
	PDB_MD_TABLE_LOCAL_SCOPE_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "LocalScope")
			structure := struct
			struct.add_method_def_index ("Method") -- MethodDeF
			struct.add_import_scope_index ("ImportScope") -- ImportScope
			struct.add_local_variable_index ("VariableList") -- LocalVariable
			struct.add_local_constant_index ("ConstantList") -- LocalConstant
			struct.add_natural_32 ("StartOffset")
			struct.add_natural_32 ("Length")
		end

feature -- Access

	method: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Method")
		end

	import_scope: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("ImportScope")
		end

	variables: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("VariableList")
		end

	start_offset: NATURAL_32
		do
			if attached structure.natural_32_item ("StartOffset") as v then
				Result := v.value
			end
		end

	length: NATURAL_32
		do
			if attached structure.natural_32_item ("Length") as v then
				Result := v.value
			end
		end

	Table_id: NATURAL_8
		once
			Result := {PDB_TABLES}.tlocalscope
		end

end

