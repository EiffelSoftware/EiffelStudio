indexing
	description	: "Command to perform an undo/redo operation"
	date		: "$Date$"
	revision	: "$Revision $"

deferred class
	EB_UNDO_REDO_COMMAND

inherit
	EB_DEVELOPMENT_WINDOW_COMMAND

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			new_menu_item
		end

	EB_UNDO_REDO_OBSERVER
		redefine
			on_changed
		end

	EB_RECYCLABLE

feature {NONE} -- initialization

feature -- Execution

	accelerator_execute is
			-- Execute command if neccessary when called via an accelerator
		do
			if editor.has_focus and then is_sensitive then
				execute
			end
		end

feature -- Basic operations

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			do
				start_observer 

				Result := Precursor (display_text, use_gray_icons)
			end

	new_menu_item: EB_COMMAND_MENU_ITEM is
			-- Create a new menu entry for this command.
		do
			start_observer

			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
		end

feature -- recycle
	
	recycle is
			-- Recycle Current
		do
			if observer_started then
				editor.remove_history_observer (Current)
			end
		end

feature {NONE} -- Implementation / Observer pattern

	observer_started: BOOLEAN
			-- The observer has been set up.

	start_observer is
			-- Start observing the stack
		do
			if not observer_started then
				editor.add_history_observer (Current)
				observer_started := True
					-- Why should we destroy the command when destroying the window???
					-- It is enough to destroy it when destroying the stack?!
--				target.add_recyclable (Current)
			end
		end

feature {NONE} -- Implementation

	editor: EB_EDITOR is
			-- Editor corresponding to Current
		do
			Result := target.editor_tool.text_area
		end

--	undo_redo_stack: UNDO_REDO_STACK is
--			-- Undo-redo stack.
--		do
--			Result := editor.history
--		end

	on_changed is
			-- The undo/redo stack has changed.
		local
			sensitive: BOOLEAN
			operation_possible: BOOLEAN
		do
			sensitive := is_sensitive 
			operation_possible := executable

			if sensitive and (not operation_possible) then
				disable_sensitive
			elseif (not sensitive) and (operation_possible) then
				enable_sensitive
			end
		end

end -- class EB_UNDO_REDO_COMMAND
