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

	REFACTORING_HELPER
		export
			{NONE} all
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize
		do
			Precursor

			set_size (500, 500)

			create text_field
			text_field.disable_word_wrapping
			text_field.disable_edit
			extend (text_field)

			create mutex.make
			create action_queue

			create timer.make_with_interval (100)
			timer.actions.extend (agent
				do
					mutex.lock
					if not action_queue.is_empty then
						action_queue.call (Void)
						action_queue.wipe_out
					end
					mutex.unlock
				end
			)
		end

feature {NONE} -- GUI elements

	text_field: EV_TEXT
			-- Text field to display the output.

feature -- Update

	append_text (a_text: STRING) is
			-- Append `a_text' to the displayed text.
		local
			l_txt: like a_text
			l_line: INTEGER
		do
			if is_displayed then
				l_txt := a_text.twin
				l_txt.prune_all ('%R')
				text_field.append_text (l_txt)

				fixme ("Remove this code and use scroll_to_end once scroll_to_end is fixed on windows")
				l_line := text_field.line_count-3
				if l_line > 0 then
					text_field.scroll_to_line (l_line)
				end
--				text_field.scroll_to_end
			end
		end

	append_in_gui_thread (a_text: STRING) is
			-- Append `a_text to the displayed text in the gui thread.
		do
			mutex.lock
			action_queue.extend (agent append_text (a_text))
			mutex.unlock
		end

	hide_in_gui_thread is
			-- Hide dialog in the gui thread.
		do
			mutex.lock
			action_queue.extend (agent hide)
			mutex.unlock
		end

feature {NONE} -- Implementation

	action_queue: ACTION_SEQUENCE [TUPLE []]
			-- Actions to execute in the gui thread.

	timer: EV_TIMEOUT
			-- Timer for updating text from an other thread.

	mutex: MUTEX
			-- Mutex for updating text from an other thread.

invariant
	initialized: text_field /= Void and mutex /= Void and action_queue /= Void

end
