note
	description: "Summary description for {WSF_FORM_CHECKBOX_INPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_CHECKBOX_INPUT

inherit
	WSF_FORM_SELECTABLE_INPUT

create
	make,
	make_with_value

feature -- Access

	input_type: STRING = "checkbox"

invariant

end
