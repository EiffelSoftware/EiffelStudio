indexing
	description	: "Command to perform an undo/redo operation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	UNDO_REDO_OBSERVER
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

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			do
				start_observer

				Result := Precursor (display_text)
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

end -- class EB_UNDO_REDO_COMMAND
