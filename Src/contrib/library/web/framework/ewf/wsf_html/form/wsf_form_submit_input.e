note
	description: "Summary description for {WSF_FORM_INPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_SUBMIT_INPUT

inherit
	WSF_FORM_INPUT

create
	make,
	make_with_text

feature -- Access

	input_type: STRING = "submit"

end
