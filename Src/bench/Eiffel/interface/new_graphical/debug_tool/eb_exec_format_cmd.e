indexing
	description:	
		"Set execution format."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_EXEC_FORMAT_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			new_menu_item
		end

	EB_SHARED_INTERFACE_TOOLS
		export 
			{NONE} all 
		end
	
	EXEC_MODES

	EB_CONSTANTS

	SHARED_APPLICATION_EXECUTION

	EB_SHARED_WINDOW_MANAGER

feature {NONE} -- Initialization

	make (a_manager: like debugger_manager) is
			-- Initialize `Current' and associate it with `a_manager'.
		do
			debugger_manager := a_manager
		end

feature -- Formatting

	execute_from_argument_dialog (a_execution_mode: INTEGER) is
			-- Execute from argument dialog and therefore ALWAYS stop at breakpoints.
		do
			internal_execute (a_execution_mode)
		end

	execute is
			-- Set the execution format to `stone'.
		do
			internal_execute (execution_mode)
		end

feature -- Properties

	debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

	tooltip: STRING is
			-- Tooltip for `Current'.
		do
			Result := internal_tooltip
		end

feature -- Access

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text, use_gray_icons)
			Result.select_actions.put_front (agent execute_from (Result))
			Result.pointer_button_press_actions.put_front (agent button_right_click_action)
		end

	new_menu_item: EB_COMMAND_MENU_ITEM is
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			Result.select_actions.put_front (agent execute_from (Result))
		end

feature {NONE} -- Attributes

	description: STRING is
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
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			if not executed_from_widget and not debugger_manager.raised then
					-- The debugging window has not been updated yet.
					-- If a shortcut was used, the corresponding window
					-- must have the focus.
				conv_dev ?= window_manager.last_focused_window
				if conv_dev /= Void then
					debugger_manager.set_debugging_window (conv_dev)
				else
					debug  end
					debugger_manager.set_debugging_window (Window_manager.a_development_window)
				end
			end
			debugger_manager.debug_run_cmd.execute_with_mode (a_execution_mode)
			if not Application.is_running then
					-- The application was not launched for some reason
					-- (a compilation was running, the user didn't want to launch it after all,...)
				debugger_manager.set_debugging_window (Void)
			end
			executed_from_widget := False
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
			if not debugger_manager.raised then
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
					debugger_manager.set_debugging_window (
						window_manager.development_window_from_window (window)
					)
					executed_from_widget := True
				else
					debug ("DEBUGGER_INTERFACE")
						io.putstring ("Could not find the top window (dixit EB_EXEC_FORMAT_CMD)%N")
					end
					dev ?= Window_manager.last_focused_window
					if dev /= Void then
						debugger_manager.set_debugging_window (dev)
						executed_from_widget := True
					else
						debug ("DEBUGGER_INTERFACE")
							io.putstring ("Could not find the last focused window (dixit EB_EXEC_FORMAT_CMD)%N")
						end
						debugger_manager.set_debugging_window (Window_manager.a_development_window)
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

	internal_tooltip: STRING is
			-- Basic tooltip (without the key shortcut).
		deferred
		end
		
	button_right_click_action (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Show the arguments dialog box when the user right clicks the button.
		local
			args_dialog: EB_ARGUMENT_DIALOG
			window: EB_DEVELOPMENT_WINDOW
			dev: EV_WINDOW
		do
			if a_button = 3 and is_sensitive then		
				window ?= window_manager.last_focused_window
				if window /= Void then
					dev := window.window
					if not argument_dialog_is_valid then
						create args_dialog.make (window, agent execute_from_argument_dialog (User_stop_points))
						set_argument_dialog (args_dialog)
					else
						argument_dialog.update
					end
					if not argument_dialog.is_displayed then
						argument_dialog.show
					else
						argument_dialog.raise
					end
				end
			end
		end

end -- class EB_EXEC_FORMAT_CMD
