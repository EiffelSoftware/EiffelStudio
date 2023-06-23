class
	PE_MD_TABLE_INTERFACEIMPL

inherit
	PE_MD_TABLE [PE_MD_TABLE_INTERFACEIMPL_ENTRY]

create
	make

feature -- Access

	read_entry (pe: PE_FILE): like entry
		do
			create Result.make (pe)
		end

feature -- Access		

	interfaces (a_class_token: NATURAL_32): ARRAYED_LIST [PE_INDEX_ITEM]
		local
			l_cl_idx: NATURAL_32
			l_tb_idx: NATURAL_8
		do
			l_tb_idx := (a_class_token |>> 24).to_natural_8
			check is_typedef_token: l_tb_idx = {PE_TABLES}.ttypedef end
			l_cl_idx := a_class_token & 0x00FF_FFFF
			create Result.make (0)
			across
				entries as ic
			loop
				if attached ic.item as e then
					if
						attached e.class_index as cl and then
						cl.index = l_cl_idx and then
						attached e.interface_index as interf and then
						not interf.is_null_index
					then
						Result.force (interf)
					end
				end
			end
		end

end
