note
	description: "Dialog to display output of iron external process."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_OUTPUT_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize,
			create_interface_objects
		end

	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		undefine
			copy, default_create
		end

	CONF_GUI_INTERFACE_CONSTANTS
		export
			{NONE} all
		undefine
			copy, default_create
		end

feature {NONE} -- Initialization

	create_interface_objects
		do
			Precursor
			create text_field
			create mutex.make
			create action_queue
			create timer
			create cancel_button
		end

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

			text_field.disable_word_wrapping
			text_field.disable_edit
			l_vb.extend (text_field)

			cancel_button.set_text (names.b_cancel)
			cancel_button.select_actions.extend (agent
				do
					if attached process as p then
						p.terminate_tree
					end
					close_in_gui_thread
				end)
			create l_hb
			l_vb.extend (l_hb)
			l_vb.disable_item_expand (l_hb)
			l_hb.extend (create {EV_CELL})
			l_hb.extend (cancel_button)
			l_hb.disable_item_expand (cancel_button)
			l_hb.extend (create {EV_CELL})

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
			timer.set_interval (100)
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
			if not is_destroyed then
				action_queue.extend (agent hide)
			end
			mutex.unlock
		end

	close_in_gui_thread
			-- Close dialog in the gui thread.
		do
			mutex.lock
			if not is_destroyed then
				action_queue.extend (agent destroy)
			end
			mutex.unlock
		end

feature {NONE} -- Implementation

	action_queue: ACTION_SEQUENCE [TUPLE]
			-- Actions to execute in the gui thread.

	timer: EV_TIMEOUT
			-- Timer for updating text from an other thread.

	mutex: MUTEX
			-- Mutex for updating text from an other thread.

	process: detachable PROCESS
			-- Process to terminate if the action is canceled.

invariant
	initialized: text_field /= Void and mutex /= Void and action_queue /= Void

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
