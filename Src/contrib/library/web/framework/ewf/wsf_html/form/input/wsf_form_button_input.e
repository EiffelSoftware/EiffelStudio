note
	description: "Summary description for {WSF_FORM_BUTTON_INPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_BUTTON_INPUT

inherit
	WSF_FORM_INPUT

create
	make

feature -- Access

	input_type: STRING = "button"

end
