note
	description: "Summary description for {CONSOLE_WIZARD_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONSOLE_WIZARD_QUESTION

inherit
	WIZARD_QUESTION
		redefine
			make
		end

	CONSOLE_WIZARD_INPUT_FIELD
		rename
			make as make_field
		undefine
			make_field
		end

feature {NONE} -- Initialization

	make (a_id: like id; a_title: READABLE_STRING_GENERAL; a_optional_description: detachable READABLE_STRING_GENERAL)
			-- Create field identified by `a_id', with title `a_title'
			-- and optional description `a_optional_description'.
		do
			Precursor (a_id, a_title, a_optional_description)
		end

end
