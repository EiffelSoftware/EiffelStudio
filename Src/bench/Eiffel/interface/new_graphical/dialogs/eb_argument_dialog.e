indexing
	description:
		"Popup dialog to enter new arguments, modify existing ones and launch system with%
		%chosen argument."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ARGUMENT_DIALOG

inherit

	EV_TITLED_WINDOW

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_DEBUGGER_OBSERVER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		redefine
			on_application_killed,
			on_application_launched,
			on_application_stopped
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: EB_DEVELOPMENT_WINDOW; cmd: PROCEDURE [ANY, TUPLE]) is
			-- Initialize Current with `par' as parent and
			-- `cmd' as command window.
		require
			a_window_not_void: a_window /= Void
			cmd_not_void: cmd /= Void
		do
			make_with_title ("Execution Control")
			set_icon_pixmap (pixmaps.icon_dialog_window)
			Eb_debugger_manager.observers.extend (Current)
			run := cmd

				-- Build Dialog GUI
			create arguments_control.make (Current)
			extend (execution_frame)
			key_press_actions.extend (agent escape_check (?))
			focus_in_actions.extend (agent on_window_focused)
			close_request_actions.extend (agent on_cancel)
		end

	execution_frame: EV_HORIZONTAL_BOX is
			-- Frame containing all execution option
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			b: EV_BUTTON
			cell: EV_CELL
		do
			create Result
			create hbox
			hbox.extend (arguments_control)
			hbox.set_border_width (Layout_constants.Small_border_size)
			hbox.set_padding (Layout_constants.Small_padding_size)

			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)

			create b.make_with_text (interface_names.b_ok)
			vbox.extend (b)
			b.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)
			vbox.disable_item_expand (b)
			b.select_actions.extend (agent on_ok)

			create b.make_with_text (interface_names.b_cancel)
			vbox.extend (b)
			b.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)
			vbox.disable_item_expand (b)
			b.select_actions.extend (agent on_cancel)

			if run /= Void then
				create run_button.make_with_text ("Run")
				vbox.extend (run_button)
				run_button.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)
				vbox.disable_item_expand (run_button)
				run_button.select_actions.extend (agent execute)

				create run_and_close_button.make_with_text ("Run & Close")
				vbox.extend (run_and_close_button)
				run_button.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)
				vbox.disable_item_expand (run_and_close_button)
				run_and_close_button.select_actions.extend (agent execute_and_close)
				run_and_close_button.key_press_actions.extend (agent on_run_button_key_press)
			end

			create cell
			cell.set_minimum_width (Layout_constants.Small_padding_size)
			vbox.extend (cell)

			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)

			Result.extend (hbox)
		end

feature -- GUI

	run_button,
	run_and_close_button: EV_BUTTON
			-- Button to run system.

feature -- Status Setting

	update is
			-- Update.
		do
			arguments_control.update
		end

feature {NONE} -- Actions

	on_cancel is
	 		-- Action to take when user presses 'Cancel' button.
		do
			hide
		end

	on_ok is
	 		-- Action to take when user presses 'OK' button.
		do
			arguments_control.store_arguments
			hide
		end

feature {NONE} -- Properties

	arguments_control: EB_ARGUMENT_CONTROL
			-- Widget holding all arguments information.

	run: PROCEDURE [ANY, TUPLE]

feature {NONE} -- Implementation

	on_window_focused is
			-- Acion to be taken when window gains focused.
		do
			arguments_control.set_focus
		end

	on_run_button_key_press (key: EV_KEY) is
			-- Key was pressed whilst button had focus.
		do
			if key.code = {EV_KEY_CONSTANTS}.key_enter then
				execute
			end
		end

	escape_check (key: EV_KEY) is
			-- Check for keyboard escape character.
		require
			key_not_void: key /= Void
     	do
        	if key.code = {EV_KEY_CONSTANTS}.key_escape then
            	on_cancel
            end
      	end

	execute is
		do
			arguments_control.store_arguments
			run.call (Void)
		end

	execute_and_close is
		do
			arguments_control.store_arguments
			run.call (Void)
			hide
		end

feature {NONE} -- Observing event handling.

	on_application_killed is
			-- Action to take when the application is killed.
		do
			if not run_button.is_sensitive then
				run_button.enable_sensitive
			end
			if not run_and_close_button.is_sensitive then
				run_and_close_button.enable_sensitive
			end
		end

	on_application_launched is
			-- Action to take when the application is launched.
		do
			if run_button.is_sensitive then
				run_button.disable_sensitive
			end
			if run_and_close_button.is_sensitive then
				run_and_close_button.disable_sensitive
			end
		end

	on_application_stopped is
			-- Action to take when the application is stopped.
		do
			if not run_button.is_sensitive then
				run_button.enable_sensitive
			end
			if not run_and_close_button.is_sensitive then
				run_and_close_button.enable_sensitive
			end
		end

invariant
	argument_control_not_void: arguments_control /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_ARGUMENT_DIALOG
