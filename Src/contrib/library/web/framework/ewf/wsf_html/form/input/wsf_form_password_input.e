note
	description: "Summary description for {WSF_FORM_PASSWORD_INPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_PASSWORD_INPUT

inherit
	WSF_FORM_INPUT
		redefine
			input_type
		end

create
	make,
	make_with_text

feature -- Access

	input_type: STRING
		once
			Result := "password"
		end

end
