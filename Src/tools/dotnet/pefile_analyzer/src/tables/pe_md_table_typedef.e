class
	PE_MD_TABLE_TYPEDEF

inherit
	PE_MD_TABLE [PE_MD_TABLE_TYPEDEF_ENTRY]
		redefine
			check_validity
		end

create
	make

feature -- Access

	read_entry (pe: PE_FILE): like entry
		do
			create Result.make (pe)
		end

feature -- Check validity

	check_validity (pe: PE_FILE)
		local
			prev_field_idx: PE_INDEX_ITEM
			prev_method_idx: PE_INDEX_ITEM
		do
			across
				entries as ic
			loop
				if attached ic.item as e then
					if attached e.field_list as fl then
						if
							prev_field_idx /= Void and then
							prev_field_idx.original_index > fl.original_index
						then
							report_error (create {PE_USER_ERROR}.make ("<0x"+ e.token.to_hex_string +">.FieldList  not ordered (0x"+ prev_field_idx.original_index.to_hex_string +" > 0x"+ fl.original_index.to_hex_string +")" ))
						end
						prev_field_idx := fl
					end
					if attached e.method_list as ml then
						if
							prev_method_idx /= Void and then
							prev_method_idx.original_index > ml.original_index
						then
							report_error (create {PE_USER_ERROR}.make ("<0x"+ e.token.to_hex_string +">.MethodList not ordered (0x"+ prev_method_idx.original_index.to_hex_string +" > 0x"+ ml.original_index.to_hex_string +")" ))
						end
						prev_method_idx := ml
					end
				end
			end
		end

end
