indexing
	description	: "Command to show/hide a tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SHOW_TOOL_COMMAND

inherit
	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			make as target_make
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			new_menu_item,
			initialize_menu_item,
			tooltext,
			is_tooltext_important
		end

	EB_SELECTABLE

create
	make

feature {NONE} -- Initialization

	make (a_target: EB_DEVELOPMENT_WINDOW; an_explorer_bar_item: EB_EXPLORER_BAR_ITEM) is
		require
			valid_item: an_explorer_bar_item /= Void and then an_explorer_bar_item.is_closeable
			item_has_pixmap: an_explorer_bar_item.pixmap /= Void
		do
			target_make (a_target)
			explorer_bar_item := an_explorer_bar_item
			explorer_bar_item.set_associated_command (Current)
			is_selected := explorer_bar_item.is_visible
			is_sensitive := True
				-- Show tools are always sensitive
		end

feature -- Access

	explorer_bar_item: EB_EXPLORER_BAR_ITEM
			-- Tool associated with Current.

	tooltip: STRING is
			-- Tooltip for Current
		do
			if is_selected then
				Result := "Hide "
			else
				Result := "Show "
			end
			Result.append_string (explorer_bar_item.title)
		end

	tooltext: STRING is
			-- Text for toolbar button.
		do
			Result := explorer_bar_item.title
		end

	is_tooltext_important: BOOLEAN is
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := True
		end

	description: STRING is
			-- Description for current command.
		do
			Result := "Show/hide " + explorer_bar_item.title
		end

	menu_name: STRING is
			-- Name as it appears in menus.
		do
			Result := explorer_bar_item.menu_name
		end

	name: STRING is
			-- Name to be displayed.
		do
			Result := explorer_bar_item.title
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		do
			Result := explorer_bar_item.pixmap
		end

feature -- Execution

	execute is
			-- Execute command (toggle between show and hide).
		do
			set_selected (not is_selected)
		end

	enable_selected is
			-- Set `is_selected' to True.
		do
			set_selected (True)
		end

	disable_selected is
			-- Set `is_selected' to False.
		do
			set_selected (False)
		end

feature -- Basic operations

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			create Result.make (Current)
			initialize_toolbar_item (Result, display_text, use_gray_icons)
			if is_selected then
				Result.enable_select
			end
			Result.select_actions.extend (agent execute)
			Result.select_actions.extend (agent update_tooltip (Result))
		end

	new_menu_item: EB_COMMAND_CHECK_MENU_ITEM is
			-- Create a new menu entry for this command.
		do
				-- Create the menu item
			create Result.make (Current)
			initialize_menu_item (Result)
			if is_selected then
				Result.enable_select
			else
				Result.disable_select
			end
			Result.select_actions.extend (agent execute)
		end

feature -- Element change

	set_accelerator (a_accel: EV_ACCELERATOR) is
			-- Set `accelerator' with `a_accel'.
		require
			a_accel_attached: a_accel /= Void
		do
			accelerator := a_accel
		ensure
			accelerator_not_void: accelerator = a_accel
		end

feature {NONE} -- Implementation

	set_selected (a_selected: BOOLEAN)is
			-- Set `is_selected' to `a_selected'.
		local
			toolbar_items: like managed_toolbar_items
			menu_items: like managed_menu_items
		do
			if not safety_flag then
				safety_flag := True
				is_selected := a_selected
				toolbar_items := managed_toolbar_items
				if toolbar_items /= Void then
					from
						toolbar_items.start
					until
						toolbar_items.after
					loop
						if a_selected then
							toolbar_items.item.enable_select
						else
							toolbar_items.item.disable_select
						end
						toolbar_items.forth
					end
				end

				menu_items := managed_menu_items
				if menu_items /= Void then
					from
						menu_items.start
					until
						menu_items.after
					loop
						if a_selected then
							menu_items.item.enable_select
						else
							menu_items.item.disable_select
						end
						menu_items.forth
					end
				end

				if a_selected then
					explorer_bar_item.show
				else
					explorer_bar_item.close
				end
				safety_flag := False
			end
		end

	update_tooltip (toggle: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON) is
			-- Update tooltip of `toggle'.
		do
			toggle.set_tooltip (tooltip)
		end

feature {NONE} -- Implementation

	initialize_menu_item (a_menu_item: EB_COMMAND_MENU_ITEM) is
			-- Create a new menu entry for this command.
		do
			Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (a_menu_item)
				-- We do not want pixmaps for check items.
			a_menu_item.remove_pixmap
		end

	safety_flag: BOOLEAN;
			-- Are we changing the `is_selected' attribute? (To prevent stack overflows)

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

end -- class EB_SHOW_TOOL_COMMAND
