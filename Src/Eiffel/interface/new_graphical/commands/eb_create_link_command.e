indexing
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
			new_toolbar_item,
			make,
			description
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like tool) is
			-- Initialize `Current'.
			-- Client-supplier links are selected by default.
		do
			Precursor (a_target)
			selected_type := Inheritance
		end


feature -- Basic operations

	execute is
			-- Perform operation.
		do
			if selected_type = inheritance then
				tool.on_new_inherit_click
			elseif selected_type = Supplier then
				tool.on_new_client_click
			else
				tool.on_new_agg_client_click
			end
		end

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			create Result.make (Current)
			initialize_toolbar_item (Result, display_text)
			current_button := Result
			Result.select_actions.extend (agent show_text_menu)
		end

feature -- Status report

	selected_type: INTEGER
			-- Currently selected type of new links

	inheritance, supplier, aggregate: INTEGER is unique
			-- Possible values for `selected_type'.

feature -- Status setting

	select_type (a_type: INTEGER) is
			-- Set current type of link to `Supplier', `Inheritance' or`Aggregate'.
		require
			valid_type: a_type = Inheritance or else a_type = Supplier or else a_type = Aggregate
		local
			tbb: EB_COMMAND_TOOL_BAR_BUTTON
			tt: STRING
		do
			selected_type := a_type
			execute

			tt := tooltip.twin
			if accelerator /= Void then
				tt.append (Opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (Closing_parenthesis)
			end
			from
				managed_toolbar_items.start
			until
				managed_toolbar_items.after
			loop
				tbb := managed_toolbar_items.item
				tbb.set_pixmap (pixmap)
				tbb.set_tooltip (tt)
				if is_sensitive then
					tbb.enable_sensitive
				else
					tbb.disable_sensitive
				end
				managed_toolbar_items.forth
			end
		end
feature {NONE} -- Implementation

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			if selected_type = inheritance then
				Result := Pixmaps.Icon_new_inherit
			elseif selected_type = Supplier then
				Result := Pixmaps.Icon_new_supplier
			else
				Result := Pixmaps.Icon_new_aggregate_supplier
			end
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			if selected_type = inheritance then
				Result := Interface_names.f_diagram_create_inheritance_links
			elseif selected_type = Supplier then
				Result := Interface_names.f_diagram_create_supplier_links
			else
				Result := Interface_names.f_diagram_create_aggregate_supplier_links
			end
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_create_links
		end

	name: STRING is "New_links"
			-- Name of the command. Used to store the command in the
			-- preferences.

	show_text_menu is
			-- Show menu to enable selection of link type.
		local
			menu: EV_MENU
			menu_item: EV_CHECK_MENU_ITEM
		do
			create menu
			create menu_item
			menu_item.set_text (Interface_names.f_diagram_create_inheritance_links)
			if selected_type = Inheritance then
				menu_item.enable_select
			end
			menu_item.select_actions.extend (agent select_type (Inheritance))
			menu.extend (menu_item)
			create menu_item
			menu_item.set_text (Interface_names.f_diagram_create_supplier_links)
			menu.extend (menu_item)
			if selected_type = Supplier then
				menu_item.enable_select
			end
			menu_item.select_actions.extend (agent select_type (Supplier))
			create menu_item
			menu_item.set_text (Interface_names.f_diagram_create_aggregate_supplier_links)
			if selected_type = Aggregate then
				menu_item.enable_select
			end
			menu_item.select_actions.extend (agent select_type (Aggregate))
			menu.extend (menu_item)
			menu.show_at (current_button.parent, current_button.parent.pointer_position.x, current_button.parent.height)
		end

feature {EB_CONTEXT_EDITOR} -- Implementation

	current_button: EB_COMMAND_TOOL_BAR_BUTTON;
			-- Current toggle button.

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

end -- class EB_CREATE_LINK_COMMAND
