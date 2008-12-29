note
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

	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		undefine
			copy, default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			copy, default_create
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize
		local
			l_vb: EV_VERTICAL_BOX
			l_hb: EV_HORIZONTAL_BOX
		do
			Precursor

			set_size (500, 500)

			create l_vb
			extend (l_vb)
			l_vb.set_padding (default_padding_size)
			l_vb.set_border_width (default_border_size)

			create text_field
			text_field.disable_word_wrapping
			text_field.disable_edit
			l_vb.extend (text_field)

			create cancel_button.make_with_text_and_action (interface_names.b_cancel, agent
				do
					if process /= Void then
						process.terminate_tree
					end
				end)
			create l_hb
			l_vb.extend (l_hb)
			l_vb.disable_item_expand (l_hb)
			l_hb.extend (create {EV_CELL})
			l_hb.extend (cancel_button)
			l_hb.disable_item_expand (cancel_button)
			l_hb.extend (create {EV_CELL})

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

	cancel_button: EV_BUTTON
			-- Button to cancel the action.

feature -- Update

	set_process (a_process: like process)
			-- Set `process' to `a_process'.
		require
			a_process_not_void: a_process /= Void
		do
			process := a_process
		ensure
			process_set: process = a_process
		end

	append_text (a_text: STRING)
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

	append_in_gui_thread (a_text: STRING)
			-- Append `a_text to the displayed text in the gui thread.
		do
			mutex.lock
			action_queue.extend (agent append_text (a_text))
			mutex.unlock
		end

	hide_in_gui_thread
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

	process: PROCESS
			-- Process to terminate if the action is canceled.

invariant
	initialized: text_field /= Void and mutex /= Void and action_queue /= Void

end
