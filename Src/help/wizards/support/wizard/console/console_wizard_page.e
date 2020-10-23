note
	date: "$Date$"
	revision: "$Revision$"

class
	CONSOLE_WIZARD_PAGE

inherit
	WIZARD_PAGE

create
	make

feature {WIZARD, WIZARD_PAGE} -- Implementation

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

	new_file_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): CONSOLE_WIZARD_DIRECTORY_QUESTION
		do
			create Result.make (a_field_id, a_prompt, a_description)
		end

	new_link_text_item (a_text: READABLE_STRING_GENERAL; a_uri: READABLE_STRING_8 ): WIZARD_PAGE_LINK_TEXT_ITEM
		do
			create Result.make (a_text, a_uri)
		end

end
