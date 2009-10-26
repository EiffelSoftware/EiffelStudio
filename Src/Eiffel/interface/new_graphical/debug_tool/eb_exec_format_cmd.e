note
	description:
		"Set execution format."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_EXEC_FORMAT_CMD

inherit
	ES_DBG_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			new_menu_item,
			new_menu_item_unmanaged
		end

	EXEC_MODES

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
		end

feature -- Execution

	launch_with_parameters (a_execution_mode: INTEGER; params: DEBUGGER_EXECUTION_PROFILE)
			-- Execute with `params' and using mode `a_execution_mode'
		do
			if is_sensitive then
				if attached debugger_manager as dbg then
					internal_launch (a_execution_mode, debugger_manager.resolved_execution_parameters (params))
				end
			end
		end

	execute
			-- Set the execution format to `stone'.
		do
			if is_sensitive then
				internal_execute (execution_mode)
			end
		end

feature -- Properties

	tooltip: STRING_GENERAL
			-- Tooltip for `Current'.
		do
			Result := internal_tooltip
		end

feature -- Access

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new docking toolbar item.
		do
			Result := Precursor {ES_DBG_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
			Result.select_actions.put_front (agent execute_from_debugging_window)
			Result.pointer_button_press_actions.put_front (agent button_right_click_action)
		end

	new_menu_item: EB_COMMAND_MENU_ITEM
			-- Create a new menu item
		do
			Result := Precursor {ES_DBG_TOOLBARABLE_AND_MENUABLE_COMMAND}
			Result.select_actions.put_front (agent execute_from (Result))
		end

	new_menu_item_unmanaged: EV_MENU_ITEM
			-- Create a new menu item unmanaged.
		do
			Result := Precursor {ES_DBG_TOOLBARABLE_AND_MENUABLE_COMMAND}
				-- Fixme: If this item is used in contextual menu. Window will not be found.
			Result.select_actions.put_front (agent execute_from (Result))
		end

feature {NONE} -- Attributes

	description: STRING_GENERAL
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	execution_mode: INTEGER
			-- Kind of execution performed by `Current'.
		deferred
		end

feature {NONE} -- Implementation

	internal_execute (a_execution_mode: INTEGER)
			-- Execute.
		do
			before_internal_execute
			if attached eb_debugger_manager as dbg then
				dbg.debug_run_cmd.execute_with_mode (a_execution_mode)
			end
			after_internal_execute
		end

	internal_launch (a_execution_mode: INTEGER; params: DEBUGGER_EXECUTION_RESOLVED_PROFILE)
			-- Launch.
		do
			before_internal_execute
			if attached eb_debugger_manager as dbg then
				dbg.debug_run_cmd.launch_with_mode (a_execution_mode, params)
			end
			after_internal_execute
		end

	before_internal_execute
			-- before calling internal_execute
		do
			if attached eb_debugger_manager as dbg then
				if not executed_from_widget and not dbg.raised then
						-- The debugging window has not been updated yet.
						-- If a shortcut was used, the corresponding window
						-- must have the focus.
					if attached {EB_DEVELOPMENT_WINDOW} window_manager.last_focused_window as conv_dev then
						dbg.set_debugging_window (conv_dev)
					else
						dbg.set_debugging_window (Window_manager.a_development_window)
					end
				end
			end
		end

	after_internal_execute
			-- before calling internal_execute
		do
			if attached eb_debugger_manager as dbg then
				if not dbg.application_is_executing then
						-- The application was not launched for some reason
						-- (a compilation was running, the user didn't want to launch it after all,...)
					if dbg.raised and then not dbg.debug_mode_forced then
						dbg.unraise
					end
					dbg.set_debugging_window (Void)
				end
			end
			debug
				executed_from_widget := False
			end
		end

 	execute_from_debugging_window
 			-- Execute from the current debugging window
 		do
 			if attached eb_debugger_manager as dbg then
 				execute_from (dbg.debugging_window.window)
 			end
 		end

	execute_from (widget: EV_CONTAINABLE)
			-- Set widget's top-level window as the debugging window.
		local
			trigger: EV_CONTAINABLE
			cont: EV_ANY
		do
			executed_from_widget := False
			if attached eb_debugger_manager as dbg and then not dbg.raised then
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
				if attached {EV_WINDOW} trigger as window then
					dbg.set_debugging_window (window_manager.development_window_from_window (window))
					executed_from_widget := True
				else
					debug ("DEBUGGER_INTERFACE")
						io.put_string ("Could not find the top window (dixit EB_EXEC_FORMAT_CMD)%N")
					end
					if attached {EB_DEVELOPMENT_WINDOW} Window_manager.last_focused_window as dev then
						dbg.set_debugging_window (dev)
						executed_from_widget := True
					else
						debug ("DEBUGGER_INTERFACE")
							io.put_string ("Could not find the last focused window (dixit EB_EXEC_FORMAT_CMD)%N")
						end
						dbg.set_debugging_window (Window_manager.a_development_window)
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

	internal_tooltip: STRING_GENERAL
			-- Basic tooltip (without the key shortcut).
		deferred
		end

	button_right_click_action (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Show the arguments dialog box when the user right clicks the button.
		do
			if a_button = {EV_POINTER_CONSTANTS}.right and is_sensitive then
				if attached eb_debugger_manager as dbg and then attached dbg.options_cmd as o then
					o.open_execution_parameters_dialog (agent launch_with_parameters (Run, ?))
				end
			end
		end

	open_exception_handler_dialog
			-- Show the arguments dialog
		do
			if eb_debugger_manager.exception_handler_cmd /= Void then
				eb_debugger_manager.exception_handler_cmd.execute
			end
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class EB_EXEC_FORMAT_CMD
