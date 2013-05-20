note
	description: "Summary description for {WSF_FORM_TEXT_INPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_TEXT_INPUT

inherit
	WSF_FORM_INPUT

create
	make,
	make_with_text

feature -- Access

	input_type: STRING = "text"

end
