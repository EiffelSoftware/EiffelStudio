note
	description: "Summary description for {PE_CILDATA_RVA}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_CILDATA_RVA


feature -- Access

	value: NATURAL_32 assign set_value

feature -- Element Change

	set_value (a_val: like value)
			-- Set cildata_rva with `a_val`.
		do
			value := a_val
		end

end
