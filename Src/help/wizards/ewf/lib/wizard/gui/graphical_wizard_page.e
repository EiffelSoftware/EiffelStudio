note
	description: "Summary description for {GRAPHICAL_WIZARD_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_WIZARD_PAGE

inherit
	WIZARD_PAGE
--		redefine
--			add_section_text,
--			add_text,
--			add_fixed_size_text
--		end

	GRAPHICAL_WIZARD_STYLER

create
	make

feature {WIZARD, WIZARD_ENGINE, WIZARD_PAGE} -- Implementation

	reuse
		do
			across
				items as ic
			loop
				unparent (ic.item)
			end
		end

feature -- UI building

--	add_widget (w: EV_WIDGET; a_opt_id: detachable READABLE_STRING_8)
--		local
--			pw: GRAPHICAL_WIZARD_PAGE_WIDGET
--		do
--			create pw.make_with_widget (w)
--			pw.set_item_id (a_opt_id)
--			items.extend (pw)
--		end

--	add_section_text (a_text: READABLE_STRING_GENERAL; a_opt_id: detachable READABLE_STRING_8)
--		local
--			txt: EV_LABEL
--		do
--			create txt.make_with_text (a_text)
--			apply_section_style (txt)
--			add_widget (txt, a_opt_id)
--		end

--	add_text (a_text: READABLE_STRING_GENERAL; a_opt_id: detachable READABLE_STRING_8)
--		local
--			txt: EV_LABEL
--		do
--			create txt.make_with_text (a_text)
--			apply_text_style (txt)
--			add_widget (txt, a_opt_id)
--		end

--	add_fixed_size_text (a_text: READABLE_STRING_GENERAL; a_opt_id: detachable READABLE_STRING_8)
--		local
--			txt: EV_LABEL
--		do
--			create txt.make_with_text (a_text)
--			apply_fixed_size_text_style (txt)
--			add_widget (txt, a_opt_id)
--		end

feature -- Helpers

	new_string_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): GRAPHICAL_WIZARD_STRING_QUESTION
		do
			create Result.make (a_field_id, a_prompt, a_description)
		end

	new_directory_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): GRAPHICAL_WIZARD_DIRECTORY_QUESTION
		do
			create Result.make (a_field_id, a_prompt, a_description)
		end

	new_boolean_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): GRAPHICAL_WIZARD_BOOLEAN_QUESTION
		do
			create Result.make (a_field_id, a_prompt, a_description)
		end

	new_integer_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): GRAPHICAL_WIZARD_INTEGER_QUESTION
		do
			create Result.make (a_field_id, a_prompt, a_description)
		end

feature {NONE} -- Implementation

	unparent (i: WIZARD_PAGE_ITEM)
		do
			if attached {GRAPHICAL_WIZARD_PAGE_ITEM} i as gpi then
				if attached gpi.widget.parent as l_parent then
					l_parent.prune (gpi.widget)
				end
			end
		end

end
