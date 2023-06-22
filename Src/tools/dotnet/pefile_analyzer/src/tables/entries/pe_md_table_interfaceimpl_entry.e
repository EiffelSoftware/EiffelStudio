class
	PE_MD_TABLE_INTERFACEIMPL_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (2, "InterfaceImpl")
			structure := struct
			struct.add_type_def_index ("Class")
			struct.add_type_def_or_ref_or_spec ("Interface")
		end

feature -- Access

	class_index: detachable PE_TYPE_DEF_INDEX_ITEM
		do
			if attached {like class_index} structure.item ("Class") as i then
				Result := i
			end
		end

	interface_index: detachable PE_INDEX_ITEM
		do
			if attached {like interface_index} structure.item ("Interface") as i then
				Result := i
			end
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tinterfaceimpl
		end

end
