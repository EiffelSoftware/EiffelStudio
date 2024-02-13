note
	description: "Summary description for {PE_TYPE_DEF_ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TYPE_DEF_ENTRY

create
	make

feature {NONE} -- Initialization

	make
		local
			st: like structure
		do
			create st.make (7)
			structure := st
			st.add_fixed_size_item ("flags", 4)
			st.add_string ("name")
			st.add_string ("namespace")
			st.add_index ("extends")
			st.add_list ("FieldList")
			st.add_list ("MethodList")
		end

feature -- Access

	structure: PE_STRUCTURE

end
