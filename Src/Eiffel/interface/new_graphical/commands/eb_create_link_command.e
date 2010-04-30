note
	description: "Command to select which kind of new link will be created."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CREATE_LINK_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_sd_toolbar_item,
			make,
			description,
			menu_name
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like tool)
			-- Initialize `Current'.
			-- Client-supplier links are selected by default.
		do
			Precursor (a_target)
			selected_type := supplier
			execute
		end

feature -- Basic operations

	execute
			-- Perform operation.
		do
			if selected_type = conforming_inheritance then
				tool.on_new_inheritance_click
			elseif selected_type = Supplier then
				tool.on_new_client_click
			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			current_sd_button := Result
			Result.set_menu_function (agent new_menu)
		end

feature -- Status report

	selected_type: INTEGER
			-- Currently selected type of new links

	supplier: INTEGER = 1
	conforming_inheritance: INTEGER = 2

feature -- Status setting

	select_type (a_type: INTEGER)
			-- Set current type of link to `Supplier', `conforming_inheritance'.
		require
			valid_type: a_type = conforming_inheritance or else a_type = Supplier
		local
			l_sd_button: like new_sd_toolbar_item
			tt: STRING_GENERAL
		do
			selected_type := a_type
			execute

			tt := tooltip.twin
			if shortcut_available then
				tt.append (Opening_parenthesis)
				tt.append (shortcut_string)
				tt.append (Closing_parenthesis)
			end

			if internal_managed_sd_toolbar_items /= Void then
				from
					internal_managed_sd_toolbar_items.start
				until
					internal_managed_sd_toolbar_items.after
				loop
					l_sd_button := internal_managed_sd_toolbar_items.item
					l_sd_button.set_pixel_buffer (pixel_buffer)
					l_sd_button.set_tooltip (tt)
					if is_sensitive then
						l_sd_button.enable_sensitive
					else
						l_sd_button.disable_sensitive
					end
					internal_managed_sd_toolbar_items.forth
				end
			end
		end

feature {NONE} -- Implementation

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			if selected_type = conforming_inheritance then
				Result := pixmaps.icon_pixmaps.new_inheritance_link_icon
			elseif selected_type = Supplier then
				Result := pixmaps.icon_pixmaps.new_supplier_link_icon
			end
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			if selected_type = conforming_inheritance then
				Result := pixmaps.icon_pixmaps.new_inheritance_link_icon_buffer
			elseif selected_type = Supplier then
				Result := pixmaps.icon_pixmaps.new_supplier_link_icon_buffer
			end
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			if selected_type = conforming_inheritance then
				Result := Interface_names.f_diagram_create_inheritance_links
			elseif selected_type = Supplier then
				Result := Interface_names.f_diagram_create_supplier_links
			end
		end

	description: STRING_GENERAL
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_create_links
		end

	name: STRING = "New_links"
			-- Name of the command. Used to store the command in the
			-- preferences.

	menu_name: STRING_GENERAL
			-- Name on corresponding menu items
		do
			Result := tooltip
		end

	new_menu: EV_MENU
		local
			menu_item: EV_CHECK_MENU_ITEM
		do
			create Result

			create menu_item
			menu_item.set_text (Interface_names.f_diagram_create_supplier_links)
			Result.extend (menu_item)
			if selected_type = Supplier then
				menu_item.enable_select
			end
			menu_item.select_actions.extend (agent select_type (Supplier))

			create menu_item
			menu_item.set_text (Interface_names.f_diagram_create_inheritance_links)
			if selected_type = conforming_inheritance then
				menu_item.enable_select
			end
			menu_item.select_actions.extend (agent select_type (conforming_inheritance))
			Result.extend (menu_item)
		end

	show_text_menu
			-- Show menu to enable selection of link type.
		local
			menu: EV_MENU
		do
			menu := new_menu
			menu.show_at (current_widget, current_widget.pointer_position.x, button_height)
		end

	current_widget: EV_WIDGET
			-- Current widget
		do
			if current_sd_button /= Void then
				Result ?= current_sd_button.tool_bar
			end
		end

	button_height: INTEGER
			-- Height of button
		do
			if current_sd_button /= Void then
				Result := current_sd_button.tool_bar.height
			end
		end

feature {ES_DIAGRAM_TOOL_PANEL} -- Implementation

	current_sd_button: EB_SD_COMMAND_TOOL_BAR_BUTTON;
			-- Current toggle button.

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end -- class EB_CREATE_LINK_COMMAND
