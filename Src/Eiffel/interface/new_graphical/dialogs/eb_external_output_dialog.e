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
		do
			text_field.append_text (a_text)
			text_field.scroll_to_line (text_field.line_count)
		end

invariant
	initialized: text_field /= Void

end
