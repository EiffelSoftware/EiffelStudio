class
	PE_MD_TABLE_PROPERTYMAP

inherit
	PE_MD_TABLE [PE_MD_TABLE_PROPERTYMAP_ENTRY]

create
	make

feature -- Access

	read_entry (pe: PE_FILE): like entry
		do
			create Result.make (pe)
		end

feature -- Access

	propertymap_list_for_type_def (a_class_token: NATURAL_32): ARRAYED_LIST [PE_MD_TABLE_PROPERTYMAP_ENTRY]
		local
			l_cl_idx: NATURAL_32
			l_tb_idx: NATURAL_32
		do
			l_tb_idx := a_class_token |>> 24
			check is_typedef_token: l_tb_idx = {PE_TABLES}.ttypedef end
			l_cl_idx := a_class_token & 0x00FF_FFFF
			create Result.make (0)
			across
				entries as ic
			loop
				if attached ic.item as e then
					if
						attached e.parent_index as cl and then
						cl.index = l_cl_idx
					then
						Result.force (e)
					end
				end
			end
		end

end
