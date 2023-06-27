class
	PE_MD_TABLE_MEMBERREF_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

	PE_MD_TABLE_ENTRY_WITH_IDENTIFIER

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

	class_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Class")
		end

	signature_index: detachable PE_BLOB_INDEX_ITEM
		do
			if attached {like signature_index} structure.item ("Signature") as sig then
				Result := sig
			end
		end

	resolved_identifier (pe: PE_FILE): detachable STRING_32
			-- Human identifier
		do
			create Result.make_empty
			if
				attached class_index as c_idx and then
				attached pe.entry_from_index (c_idx) as e
			then
				do_nothing
			end
			if
				attached name_index as tn_idx  and then
				attached pe.string_heap_item (tn_idx) as s
			then
				Result.append_string_general (s)
			end
			if Result.is_whitespace then
				Result := Void
			end
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tmemberref
		end


end
