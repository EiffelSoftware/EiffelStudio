indexing
	description	: "Command that can be added in a menu and in a toolbar."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_TOOLBARABLE_AND_MENUABLE_TOGGLE_COMMAND

inherit
	EB_TOOLBARABLE_TOGGLE_COMMAND
		undefine
			enable_sensitive,
			disable_sensitive,
			set_select
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		undefine
			new_sd_toolbar_item,
			initialize_sd_toolbar_item,
			new_mini_sd_toolbar_item,
			update
		redefine
			initialize_menu_item,
			new_menu_item
		end

feature -- Access

	new_menu_item: EB_COMMAND_CHECK_MENU_ITEM is
			-- New menu item
		do
			create Result.make (Current)
			initialize_menu_item (Result)
			Result.select_actions.extend (agent execute)
		end

feature -- Change

	set_select (b: BOOLEAN) is
			-- Set Current selected if `b' is True, otherwise set Current deselected
		local
			lst: like internal_managed_menu_items
			men: like new_menu_item
		do
			Precursor {EB_TOOLBARABLE_TOGGLE_COMMAND} (b)
			lst := internal_managed_menu_items
			if lst /= Void and then not lst.is_empty then
				from
					lst.start
				until
					lst.after
				loop
					men := lst.item
					if men /= Void then
						men.select_actions.block
						if b then
							men.enable_select
						else
							men.disable_select
						end
						men.select_actions.resume
					end
					lst.forth
				end
			end
		end

	update_items is
			-- Update associated items (menu items and toolbar items)
		local
			menu_items: like internal_managed_menu_items
			sd_toolbar_items: like internal_managed_sd_toolbar_items
			t: STRING_GENERAL
			tt: like tooltip
			p: like pixmap
			mpb: like mini_pixel_buffer
			mi: EV_MENU_ITEM
			tbi: SD_TOOL_BAR_BUTTON
		do
			p := pixmap
			mpb := mini_pixel_buffer
			t := menu_name

			menu_items := internal_managed_menu_items
			if menu_items /= Void then
				from
					menu_items.start
				until
					menu_items.after
				loop
					mi := menu_items.item
					if mi /= Void then
						mi.set_text (t)
						mi.set_pixmap (p)
					end
					menu_items.forth
				end
			end

			sd_toolbar_items := internal_managed_sd_toolbar_items
			if sd_toolbar_items /= Void then
				t := tooltext
				tt := tooltip

				from
					sd_toolbar_items.start
				until
					sd_toolbar_items.after
				loop
					tbi := sd_toolbar_items.item
					if tbi /= Void then
						if {it: STRING_GENERAL} (tbi.text) and then not it.is_empty then
							tbi.set_text (t)
						end
						if tt /= Void then
							tbi.set_tooltip (tt)
						end
						tbi.set_pixel_buffer (mpb)
					end
					sd_toolbar_items.forth
				end
			end
		end

feature {NONE} -- Implementation

	initialize_menu_item (a_menu_item: EV_MENU_ITEM) is
			-- Create a new menu entry for this command.
		local
			l_item: like new_menu_item
		do
			Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (a_menu_item)
				-- Create the menu item
			l_item ?= a_menu_item
			if l_item /= Void then
				if is_selected then
					l_item.enable_select
				else
					l_item.disable_select
				end
			end
			if pixmap /= Void then
				a_menu_item.set_pixmap (pixmap)
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

end -- class EB_TOOLBARABLE_AND_MENUABLE_COMMAND
