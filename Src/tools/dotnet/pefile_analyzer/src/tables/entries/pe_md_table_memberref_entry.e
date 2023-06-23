class
	PE_MD_TABLE_MEMBERREF_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "MemberRef")
			structure := struct
			struct.add_memberref_parent_index ("Class")
				--Class (an index into the MethodDef, ModuleRef,TypeDef, TypeRef, or TypeSpec
				--tables; more precisely, a MemberRefParent (§II.24.2.6) coded index

			struct.add_string_index ("Name")
			struct.add_field_or_method_signature_blob_index ("Signature")
		end

feature -- Access

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tmemberref
		end


end
