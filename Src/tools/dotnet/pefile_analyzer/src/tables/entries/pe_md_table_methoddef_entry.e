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
			struct.add_method_impl_attributes ("ImplFlags")
			struct.add_method_attributes ("Flags")
			struct.add_string_index ("Name")
			struct.add_method_signature_blob_index ("Signature")
			struct.add_param_list_index ("ParamList")
		end

feature -- Access

	method_attributes: detachable PE_METHOD_ATTRIBUTES_ITEM
		do
			if attached {PE_METHOD_ATTRIBUTES_ITEM} structure.item ("Flags") as ta then
				Result := ta
			else
				check False end
			end
		end

	method_impl_attributes: detachable PE_METHOD_IMPL_ATTRIBUTES_ITEM
		do
			if attached {PE_METHOD_IMPL_ATTRIBUTES_ITEM} structure.item ("ImplFlags") as ta then
				Result := ta
			else
				check False end
			end
		end

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

	param_list: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("ParamList")
		end

	signature_index: detachable PE_BLOB_INDEX_ITEM
		do
			if attached {like signature_index} structure.item ("Signature") as i then
				Result := i
			else
				check False end
			end
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tmethoddef
		end

end
