note
	description: "Summary description for {WSF_FORM_FILE_INPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_FILE_INPUT

inherit
	WSF_FORM_INPUT
		redefine
			specific_input_attributes_string
		end

create
	make

feature -- Access

	input_type: STRING = "file"

	accepted_types: detachable READABLE_STRING_8
			-- Types of files that the server accepts 

feature -- Change

	set_accepted_types (v: like accepted_types)
		do
			accepted_types := v
		end

feature {NONE} -- Implementation

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			-- To redefine if needed
		do
			if attached accepted_types as l_accepted_types then
				Result := " accept=%"" + l_accepted_types + "%""
			end
		end

invariant

end
