indexing
	description: "Command to separate the stone management between the development%
				%window and the context tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_UNIFY_STONE_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			tooltext
		end

create
	make

feature -- Initialization

	make (dev: EB_DEVELOPMENT_WINDOW) is
			-- Initialize `Current' and associate it with `dev'.
		do
			window := dev
			enable_sensitive
		end

feature -- Status report

	description: STRING is
		do
			Result := Interface_names.e_Toggle_stone_management
		end

	name: STRING is "Toggle_stone"

	pixmap: ARRAY [EV_PIXMAP] is
		do
			Result := Pixmaps.Icon_unify_stone
		end

	tooltip: STRING is
		do
			if window.unified_stone then
				Result := Interface_names.e_Separate_stone
			else
				Result := Interface_names.e_Unify_stone
			end
		end

	tooltext: STRING is
			-- Text displayed on the toolbar button.
		do
			Result := Interface_names.b_Toggle_stone_management
		end

	menu_name: STRING is
		do
			if window.unified_stone then
				Result := Interface_names.m_Separate_stone
			else
				Result := Interface_names.m_Unify_stone
			end
		end

feature -- Basic operations

	execute is
			-- Toggle between a unified mode and a separate mode.
		do
			if not flag then
				flag := True
				window.toggle_unified_stone
				if managed_menu_items /= Void then
					from
						managed_menu_items.start
					until
						managed_menu_items.after
					loop
						managed_menu_items.item.remove_text
						managed_menu_items.item.set_text (menu_name)
						managed_menu_items.forth
					end
				end
				if managed_toolbar_items /= Void then
					from
						managed_toolbar_items.start
					until
						managed_toolbar_items.after
					loop
						managed_toolbar_items.item.select_actions.block
						managed_toolbar_items.item.toggle
						managed_toolbar_items.item.select_actions.resume
						managed_toolbar_items.forth
					end
				end
				update_tooltip
				flag := False
			end
		end

	update_tooltip is
			-- Display the good tooltip on buttons.
		do
			if managed_toolbar_items /= Void then
				from
					managed_toolbar_items.start
				until
					managed_toolbar_items.after
				loop
--					managed_toolbar_items.item.remove_tooltip
					managed_toolbar_items.item.set_tooltip (tooltip)
					managed_toolbar_items.forth
				end
			end
		end

	toggle_buttons is
			-- Display the good tooltip on buttons.
		do
			if managed_toolbar_items /= Void then
				from
					managed_toolbar_items.start
				until
					managed_toolbar_items.after
				loop
					managed_toolbar_items.item.select_actions.block
					managed_toolbar_items.item.toggle
					managed_toolbar_items.item.select_actions.resume
					managed_toolbar_items.forth
				end
			end
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
				-- Create the button
			create Result.make (Current)
			initialize_toolbar_item (Result, display_text, use_gray_icons)
			if window.unified_stone then
				Result.toggle
			end
			Result.select_actions.extend (agent execute)
			Result.select_actions.extend (agent toggle_buttons)
			Result.enable_sensitive
		end

feature {NONE} -- Implementation

	flag: BOOLEAN
			-- Is `Current' being executed?

	window: EB_DEVELOPMENT_WINDOW;
			-- Window `Current' is associated with.

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

end -- class EB_UNIFY_STONE_CMD
