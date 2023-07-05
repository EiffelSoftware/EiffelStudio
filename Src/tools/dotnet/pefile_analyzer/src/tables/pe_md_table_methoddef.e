class
	PE_MD_TABLE_METHODDEF

inherit
	PE_MD_TABLE [PE_MD_TABLE_METHODDEF_ENTRY]
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
			prev_param_idx: PE_INDEX_ITEM
		do
			across
				entries as ic
			loop
				if attached ic.item as e then
					if attached e.param_list as pl then
						if
							prev_param_idx /= Void and then
							prev_param_idx.original_index > pl.original_index
						then
							report_error (create {PE_USER_ERROR}.make ("<0x"+ e.token.to_hex_string +">.ParamList not ordered (0x"+ prev_param_idx.original_index.to_hex_string +" > 0x"+ pl.original_index.to_hex_string +")" ))
						end
						prev_param_idx := pl
					end
				end
			end
		end

end
