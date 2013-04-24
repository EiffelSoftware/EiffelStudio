note
	description: "Summary description for {EDK_PROPERTY_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_PROPERTY_DATA

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
--			create {EDK_PROPERTY_BOOLEAN} name
			meta_data := "" --name
			value := meta_data
		end

feature

--	name: EDK_PROPERTY

	meta_data: ANY

	value: ANY

--	set_name (a_name: like name)
--		do
--			name := a_name
--		end

	set_meta_data (a_meta_data: like meta_data)
		do
			meta_data := a_meta_data
		end

	set_value (a_value: like value)
		do
			value := a_value
		end
end
