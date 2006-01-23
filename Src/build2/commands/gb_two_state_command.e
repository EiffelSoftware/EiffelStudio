indexing
	description: "Objects that represent a command with two states%
		%e.g. hide/show."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_TWO_STATE_COMMAND
		-- Note that there is no support for changing pixmaps for the different
		-- states. This can easily be added if necessary.

inherit

	GB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			new_menu_item
		end

feature {NONE} -- Initialization


	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current', assign `a_components' to `components' and initialize.
		require
			components_not_void: a_components /= Void
		deferred
		ensure
			components_set: components = a_components
		end

feature -- Access

	tooltip: STRING is
			-- Tooltip for Current
		do
			Result := description
		end

	description: STRING is
			-- Description for current command.
		do
			Result := menu_name
		end

	menu_name: STRING is
			-- Name as it appears in menus.
		deferred
		end

	name: STRING is
		do
			Result := menu_name.twin
			Result.prune_all ('&')
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		deferred
		end

feature -- Execution

	execute is
			-- Execute command (toggle between show and hide).
		deferred
		end

	enable_selected is
			-- Set `is_selected' to True.
		do
			is_selected := True
			update_controls (is_selected)
			--set_selected (True)
		end

	disable_selected is
			-- Set `is_selected' to False.
		do
			is_selected := False
			update_controls (is_selected)
			--set_selected (False)
		end

	safe_disable_selected is
			-- Set `is_selected' to False
			-- only if `is_selected' currently True.
		do
			if is_selected then
				execute
			end
		end

	reverse_is_selected is
			-- Assign not `is_selected' to
			-- `is_selected'.
		do
			is_selected := not is_selected
		ensure
			reversed: old is_selected /= is_selected
		end



feature -- Basic operations

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): GB_COMMAND_TOGGLE_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		local
			tt: STRING
		do
				-- Add it to the managed toolbar items
			if managed_toolbar_items = Void then
				create managed_toolbar_items.make (1)
			end
				-- Create the button
			create Result.make (Current)
			if display_text and pixmap.count >= 2 then
				Result.set_pixmap (pixmap @ 2)
			else
				Result.set_pixmap (pixmap @ 1)
			end
			if is_selected then
				Result.enable_select
			end
			Result.select_actions.extend (agent execute)
			Result.enable_sensitive
			tt := tooltip.twin
			if accelerator /= Void then
				tt.append (Opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (Closing_parenthesis)
			end
			Result.set_tooltip (tt)
			if drop_agent /= Void then
				Result.drop_actions.extend (drop_agent)
			end
			if veto_drop_agent /= Void then
				Result.drop_actions.set_veto_pebble_function (veto_drop_agent)
			end
			if pebble_function /= Void then
				Result.set_pebble_function (pebble_function)
			end
		end

	new_menu_item: GB_COMMAND_CHECK_MENU_ITEM is
			-- Create a new menu entry for this command.
		local
			mname: STRING
		do
				-- Add it to the managed menu items
			if managed_menu_items = Void then
				create managed_menu_items.make (1)
			end
				-- Create the menu item
			create Result.make (Current)
			mname := menu_name.twin
			if accelerator /= Void then
				mname.append (Tabulation)
				mname.append (accelerator.out)
			end
			Result.set_text (mname)
			if pixmap /= Void then
				if pixmap.count >= 2 then
					Result.set_pixmap (pixmap @ 2)
				else
					Result.set_pixmap (pixmap @ 1)
				end
			end
			Result.select_actions.extend (agent execute)
			Result.enable_sensitive
			if is_selected then
				Result.enable_select
			else
				Result.disable_select
			end
		end

feature {NONE} -- Implementation

	update_controls (a_selected: BOOLEAN) is
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
						toolbar_items.item.select_actions.block
						if a_selected then
							toolbar_items.item.enable_select
						else
							toolbar_items.item.disable_select
						end
						toolbar_items.item.set_tooltip (tooltip)
						toolbar_items.item.select_actions.resume
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
						menu_items.item.set_text (menu_name)
						menu_items.forth
					end
				end
				--execute
				safety_flag := False
			end
		end

feature {NONE} -- Implementation

	safety_flag: BOOLEAN
			-- Are we changing the `is_selected' attribute? (To prevent stack overflows)

	is_selected: BOOLEAN;
		-- Is current selected?

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


end -- class GB_TWO_STATE_COMMAND
