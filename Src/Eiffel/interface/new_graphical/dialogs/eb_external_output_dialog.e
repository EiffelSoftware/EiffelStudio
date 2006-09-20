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
			text_field.disable_word_wrapping
			text_field.disable_edit

			create mutex.make
			create text_to_append.make_empty

			create timer.make_with_interval (100)
			timer.actions.extend (agent
				do
					mutex.lock
					if not text_to_append.is_empty then
						append_text (text_to_append)
						text_to_append.wipe_out
					end
					mutex.unlock
				end)
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
			if is_displayed then
				l_txt := a_text.twin
				l_txt.prune_all ('%R')
				text_field.append_text (l_txt)
				text_field.scroll_to_end
			end
		end

	append_in_gui_thread (a_text: STRING) is
			-- Append `a_text to the displayed text in the gui thread.
		do
			mutex.lock
			text_to_append.append (a_text)
			mutex.unlock
		end

feature {NONE} -- Implementation

	text_to_append: STRING
			-- Text for updating text from an other thread.

	timer: EV_TIMEOUT
			-- Timer for updating text from an other thread.

	mutex: MUTEX
			-- Mutex for updating text from an other thread.

invariant
	initialized: text_field /= Void and mutex /= Void and text_to_append /= Void

end
