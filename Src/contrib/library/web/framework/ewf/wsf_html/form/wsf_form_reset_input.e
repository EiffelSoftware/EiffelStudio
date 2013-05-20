note
	description: "Summary description for {WSF_FORM_RESET_INPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_RESET_INPUT

inherit
	WSF_FORM_INPUT

create
	make

feature -- Access

	input_type: STRING = "reset"

end
