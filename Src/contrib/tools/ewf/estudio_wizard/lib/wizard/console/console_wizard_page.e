note
	description: "Summary description for {CONSOLE_WIZARD_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSOLE_WIZARD_PAGE

inherit
	WIZARD_PAGE

create
	make

feature {WIZARD, WIZARD_ENGINE, WIZARD_PAGE} -- Implementation

	reuse
		do
--			across
--				items as ic
--			loop
--				unparent (ic.item)
--			end
		end

feature -- Helpers

	new_string_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): CONSOLE_WIZARD_STRING_QUESTION
		do
			create Result.make (a_field_id, a_prompt, a_description)
		end

	new_directory_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): CONSOLE_WIZARD_DIRECTORY_QUESTION
		do
			create Result.make (a_field_id, a_prompt, a_description)
		end

	new_boolean_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): CONSOLE_WIZARD_BOOLEAN_QUESTION
		do
			create Result.make (a_field_id, a_prompt, a_description)
		end

	new_integer_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): CONSOLE_WIZARD_INTEGER_QUESTION
		do
			create Result.make (a_field_id, a_prompt, a_description)
		end

end
