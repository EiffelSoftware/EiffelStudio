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

	execute is
			-- Set the execution format to `stone'.
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
			debugger_manager.debug_run_cmd.execute_with_mode (execution_mode)
			if not Application.is_running then
					-- The application was not launched for some reason
					-- (a compilation was running, the user didn't want to launch it after all,...)
				debugger_manager.set_debugging_window (Void)
			end
			executed_from_widget := False
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
			Result := {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} Precursor (display_text, use_gray_icons)
			Result.select_actions.put_front (~execute_from (Result))
		end

	new_menu_item: EB_COMMAND_MENU_ITEM is
		do
			Result := {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} Precursor
			Result.select_actions.put_front (~execute_from (Result))
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

end -- class EB_EXEC_FORMAT_CMD
