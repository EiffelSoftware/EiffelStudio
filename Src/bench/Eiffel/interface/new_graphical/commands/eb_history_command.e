indexing
	description	: "Command to go back/forth in the history."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_HISTORY_COMMAND

inherit
	EB_TARGET_COMMAND
		redefine
			target
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			new_mini_toolbar_item,
			new_menu_item
		end

	EB_HISTORY_MANAGER_OBSERVER
		redefine
			on_position_changed, on_update, on_item_added, on_item_removed
		end

	EB_RECYCLABLE

feature -- Execution

	execute is
			-- Save a file with the chosen name.
		do
			operate
--			if target /= Void then
--				target.check_and_save(~operate)
--				target.set_stone (history_manager.active)
--			end
		end

feature -- Basic operations

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			do
				start_observer
				if not executable then
					disable_sensitive
				end

				Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text, use_gray_icons)
			end

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			do
				start_observer
				if not executable then
					disable_sensitive
				end

				Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			end

	new_menu_item: EB_COMMAND_MENU_ITEM is
			-- Create a new menu entry for this command.
			do
				start_observer
				if not executable then
					disable_sensitive
				end

				Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			end

feature -- Recycle

	recycle is
			-- Recycle current command.
		do
			if observer_started then
				history_manager.remove_observer (Current)
			end
		end

feature -- Properties

	target: EB_HISTORY_OWNER
			-- That that owns the history that will be modified.

feature {EB_HISTORY_COMMAND_TOOL_BAR, EB_HISTORY_COMMAND_MENU_ITEM} -- Implementation

	history_manager: EB_HISTORY_MANAGER is
			-- Manager for history. It encapsulates the history.
		do
			Result := target.history_manager
		end

feature {NONE} -- Implementation

	operate is
			-- Move backward or forward in the history.
		deferred
		end

feature {NONE} -- Implementation / Observer pattern

	observer_started: BOOLEAN
			-- The observer has been set up.

	start_observer is
			-- Start observing the stack
		do
			if not observer_started then
				history_manager.add_observer (Current)
				observer_started := True
				target.add_recyclable (Current)
			end
		end

	on_update is
			-- History has changed
		do
				-- Update the "sensitive" status of buttons and menus.
			if is_sensitive and then (not executable) then
				 disable_sensitive
			elseif (not is_sensitive) and then executable then
				enable_sensitive
			end
		end

	on_position_changed is
			-- Index in history has changed.
		do
			on_update
		end

	on_item_added (a_stone: STONE; a_stone_position: INTEGER) is
			-- A new stone was added in the history.
		do
			on_update
		end

	on_item_removed (a_stone: STONE; index_item: INTEGER) is
			-- A new stone was added in the history.
		do
			on_update
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_HISTORY_COMMAND
