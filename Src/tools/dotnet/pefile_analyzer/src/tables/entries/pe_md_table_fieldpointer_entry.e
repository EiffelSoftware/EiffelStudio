class
	PE_MD_TABLE_FIELDPOINTER_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (1, "FieldPointer")
			structure := struct
			struct.add_field_index ("Field")
		end

feature -- Access

	field_index: detachable PE_FIELD_INDEX_ITEM
		do
			if attached structure.index_item ("Field") as i then
				if attached {like field_index} i as fidx then
					Result := fidx
				else
					check False end
				end
			end
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tfieldpointer
		end

end
