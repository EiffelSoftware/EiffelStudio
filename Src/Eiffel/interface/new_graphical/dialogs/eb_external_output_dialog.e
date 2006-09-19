indexing
	description: "Dialog to display output of an external process."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_OUTPUT_DIALOG

inherit
	EB_DIALOG
		redefine
			initialize
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize
		do
			Precursor

			set_size (500, 500)

			create text_field
			extend (text_field)
			text_field.disable_edit
			text_field.disable_word_wrapping
		end

feature {NONE} -- GUI elements

	text_field: EV_TEXT
			-- Text field to display the output.

feature -- Update

	clear_text is
			-- Clear displayed text.
		do
			text_field.set_text ("")
		end

	append_text (a_text: STRING) is
			-- Append `a_text' to the displayed text.
		local
			l_txt: like a_text
		do
			l_txt := a_text.twin
			l_txt.prune_all ('%R')
			text_field.append_text (l_txt)
			text_field.scroll_to_end
		end

invariant
	initialized: text_field /= Void

end
