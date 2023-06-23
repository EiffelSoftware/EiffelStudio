class
	PE_MD_TABLE_METHODPOINTER_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (1, "MethodPointer")
			structure := struct
			struct.add_method_def_index ("Method")
		end

feature -- Access

	method_index: detachable PE_METHOD_DEF_INDEX_ITEM
		do
			if attached structure.index_item ("Method") as i then
				if attached {like method_index} i as fidx then
					Result := fidx
				else
					check False end
				end
			end
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tmethodpointer
		end

end
