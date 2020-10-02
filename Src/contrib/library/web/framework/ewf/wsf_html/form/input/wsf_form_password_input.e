note
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_PASSWORD_INPUT

inherit
	WSF_FORM_INPUT

create
	make,
	make_with_text

feature -- Access

	input_type: STRING
		once
			Result := "password"
		end

end
