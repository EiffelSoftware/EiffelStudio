class
	PE_MD_TABLE_METHODIMPL_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "MethodImpl")
			structure := struct
			struct.add_type_def_index ("Class")
			struct.add_method_def_or_member_ref_index ("MethodBody")
			struct.add_method_def_or_member_ref_index ("MethodDeclaration")
		end

feature -- Access

	class_index: detachable PE_TYPE_DEF_INDEX_ITEM
		local
			i: PE_ITEM
		do
			i := structure.index_item ("Parent")
			if attached {PE_TYPE_DEF_INDEX_ITEM} i as t then
				Result := t
			else
				check is_typedef_or_void: i = Void end
			end
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tmethodimpl
		end

end
