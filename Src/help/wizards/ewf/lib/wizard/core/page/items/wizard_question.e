note
	description: "Summary description for {WIZARD_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_QUESTION

inherit
	WIZARD_INPUT_FIELD
		rename
			make as make_field
		end

feature {NONE} -- Initialization	

	make (a_id: like id; a_title: READABLE_STRING_GENERAL; a_optional_description: detachable READABLE_STRING_GENERAL)
			-- Create field identified by `a_id', with title `a_title'
			-- and optional description `a_optional_description'.
		do
			create title.make_from_string_general (a_title)
			if a_optional_description /= Void then
				create description.make_from_string_general (a_optional_description)
			else
				description := Void
			end
			make_field (a_id)
		end

feature -- Access	

	title: IMMUTABLE_STRING_32
			-- Title associated with input field.

	description: detachable IMMUTABLE_STRING_32
			-- Optional description.		

end
