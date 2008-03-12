indexing
	description:
		"Set execution format."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_EXEC_FORMAT_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			new_menu_item,
			new_menu_item_unmanaged
		end

	EB_SHARED_INTERFACE_TOOLS
		export
			{NONE} all
		end

	EXEC_MODES

	EB_CONSTANTS

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_manager: like eb_debugger_manager) is
			-- Initialize `Current' and associate it with `a_manager'.
		do
			eb_debugger_manager := a_manager
		end

feature -- Execution

	launch_with_parameters (a_execution_mode: INTEGER; params: DEBUGGER_EXECUTION_PARAMETERS) is
			-- Execute with `params' and using mode `a_execution_mode'
		do
			if is_sensitive then
				internal_launch (a_execution_mode, eb_debugger_manager.resolved_execution_parameters (params))
			end
		end

	execute is
			-- Set the execution format to `stone'.
		do
			if is_sensitive then
				internal_execute (execution_mode)
			end
		end

feature -- Properties

	eb_debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

	tooltip: STRING_GENERAL is
			-- Tooltip for `Current'.
		do
			Result := internal_tooltip
		end

feature -- Access

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new docking toolbar item.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
			Result.select_actions.put_front (agent execute_from (eb_debugger_manager.debugging_window.window))
			Result.pointer_button_press_actions.put_front (agent button_right_click_action)
		end

	new_menu_item: EB_COMMAND_MENU_ITEM is
			-- Create a new menu item
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			Result.select_actions.put_front (agent execute_from (Result))
		end

	new_menu_item_unmanaged: EV_MENU_ITEM is
			-- Create a new menu item unmanaged.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
				-- Fixme: If this item is used in contextual menu. Window will not be found.
			Result.select_actions.put_front (agent execute_from (Result))
		end

feature {NONE} -- Attributes

	description: STRING_GENERAL is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	execution_mode: INTEGER is
			-- Kind of execution performed by `Current'.
		deferred
		end

feature {NONE} -- Implementation

	internal_execute (a_execution_mode: INTEGER) is
			-- Execute.
		do
			before_internal_execute
			eb_debugger_manager.debug_run_cmd.execute_with_mode (a_execution_mode)
			after_internal_execute
		end

	internal_launch (a_execution_mode: INTEGER; params: DEBUGGER_EXECUTION_PARAMETERS) is
			-- Launch.
		do
			before_internal_execute
			eb_debugger_manager.debug_run_cmd.launch_with_mode (a_execution_mode, params)
			after_internal_execute
		end

	before_internal_execute is
			-- before calling internal_execute
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			if not executed_from_widget and not eb_debugger_manager.raised then
					-- The debugging window has not been updated yet.
					-- If a shortcut was used, the corresponding window
					-- must have the focus.
				conv_dev ?= window_manager.last_focused_window
				if conv_dev /= Void then
					eb_debugger_manager.set_debugging_window (conv_dev)
				else
					debug  end
					eb_debugger_manager.set_debugging_window (Window_manager.a_development_window)
				end
			end
		end

	after_internal_execute is
			-- before calling internal_execute
		do
			if not eb_debugger_manager.application_is_executing then
					-- The application was not launched for some reason
					-- (a compilation was running, the user didn't want to launch it after all,...)
				if eb_debugger_manager.raised and then not eb_debugger_manager.debug_mode_forced then
					eb_debugger_manager.unraise
				end
				eb_debugger_manager.set_debugging_window (Void)
			end
			debug
				executed_from_widget := False
			end
		end

	execute_from (widget: EV_CONTAINABLE) is
			-- Set widget's top-level window as the debugging window.
		local
			trigger: EV_CONTAINABLE
			cont: EV_ANY
			window: EV_WINDOW
			dev: EB_DEVELOPMENT_WINDOW
		do
			executed_from_widget := False
			if not eb_debugger_manager.raised then
					-- We try to find from which window we were launched.
				from
					trigger := widget
					cont := trigger.parent
				until
					cont = Void
				loop
					trigger ?= cont
					if trigger /= Void then
						cont := trigger.parent
					else
						cont := Void
					end
				end
				window ?= trigger
				if window /= Void then
					eb_debugger_manager.set_debugging_window (
						window_manager.development_window_from_window (window)
					)
					executed_from_widget := True
				else
					debug ("DEBUGGER_INTERFACE")
						io.put_string ("Could not find the top window (dixit EB_EXEC_FORMAT_CMD)%N")
					end
					dev ?= Window_manager.last_focused_window
					if dev /= Void then
						eb_debugger_manager.set_debugging_window (dev)
						executed_from_widget := True
					else
						debug ("DEBUGGER_INTERFACE")
							io.put_string ("Could not find the last focused window (dixit EB_EXEC_FORMAT_CMD)%N")
						end
						eb_debugger_manager.set_debugging_window (Window_manager.a_development_window)
						if Window_manager.a_development_window /= Void then
							executed_from_widget := True
						end
					end
				end
			end
		end

	executed_from_widget: BOOLEAN
			-- Was the command launched through a menu or a toolbar button
			-- (by opposition to an accelerator)?

	internal_tooltip: STRING_GENERAL is
			-- Basic tooltip (without the key shortcut).
		deferred
		end

	button_right_click_action (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Show the arguments dialog box when the user right clicks the button.
		do
			if a_button = {EV_POINTER_CONSTANTS}.right and is_sensitive then
				open_execution_parameters_dialog
			end
		end

	open_execution_parameters_dialog is
			-- Show the arguments dialog
		local
			args_dialog: EB_ARGUMENT_DIALOG
			window: EB_DEVELOPMENT_WINDOW
			dev: EV_WINDOW
		do
			window ?= window_manager.last_focused_window
			if window /= Void then
				dev := window.window
				if not argument_dialog_is_valid then
					create args_dialog.make (window, agent launch_with_parameters (Run, ?))
					set_argument_dialog (args_dialog)
				else
					argument_dialog.update
				end
				argument_dialog.raise
			end
		end

	open_exception_handler_dialog is
			-- Show the arguments dialog
		do
			if eb_debugger_manager.exception_handler_cmd /= Void then
				eb_debugger_manager.exception_handler_cmd.execute
			end
		end

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

end -- class EB_EXEC_FORMAT_CMD
