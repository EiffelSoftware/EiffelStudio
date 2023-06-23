class
	PE_MD_TABLE_EXPORTEDTYPE_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (5, "ExportedType")
			structure := struct
			struct.add_type_attributes ("Flags")
			struct.add_type_def_index ("TypeDefId")
			struct.add_string_index ("Name")
			struct.add_string_index ("Namespace")
			struct.add_index ("Implementation")
		end

feature -- Access		

	typedefid_index: detachable PE_TYPE_DEF_INDEX_ITEM
		local
			i: PE_ITEM
		do
			i := structure.index_item ("TypeDefId")
			if attached {PE_TYPE_DEF_INDEX_ITEM} i as t then
				Result := t
			else
				check is_typedef_or_void: i = Void end
			end
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.texportedtype
		end

end
