indexing
	description: "Window that lets the user edit a database %
			%table content."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_WINDOW

inherit
	STATUS_WINDOW

create
	make_with_table_code

feature -- Initialization

	make_with_table_code (code: INTEGER) is
			-- Create window to edit content of database table
			-- with `code'.
		require
			is_valid_code: is_valid_code (code)
		do
			table_description := tables.description (code)
			make
			set_title (table_window_title (table_description.Table_name))
			close_request_actions.extend (~destroy)
		end

	set_initial_focus is
			-- Set initial focus to the search frame first combo-box.
		do
			focusable_cbox.set_focus
		end

feature {NONE} -- Implementation

	create_window_content is
			-- Add widgets to the window.
		local
			navigation_bar: DV_HORIZONTAL_BOX
			fields_component: DV_TABLEROW_FIELDS
			table_component: DV_TABLE_COMPONENT
			field_display: DV_VERTICAL_BOX
			fields_list_comp: DV_CONTROL_NAVIGATOR
			frame: DV_FRAME
			tablerow_list: DV_TABLEROW_MULTILIST
		do
			container.disable_default_expand
			create table_component.make
			table_component.set_tablecode (table_description.Table_code)
			table_component.set_warning_handler (~send_warning (?))
			table_component.set_status_handler (~send_status (?))
			table_component.set_confirmation_handler (~send_confirmation (?, ?))
			create frame.make_with_text ("Search:")
			container.extend (frame)
			factory.add_display_searcher (table_component, frame)
			focusable_cbox := factory.first_cbox
			create tablerow_list
			container.extend (tablerow_list)
			container.enable_item_expand (tablerow_list)
			create fields_list_comp.make
			fields_list_comp.set_display_list (tablerow_list)
			table_component.set_db_tablerow_navigator (fields_list_comp)
			create field_display.make
			container.extend (field_display)
			container.extend_separator
			field_display.disable_default_expand
			create fields_component.make
			add_fields (fields_component, field_display)
			table_component.set_db_fields_component (fields_component)
			create navigation_bar.make
			container.extend (navigation_bar)
			navigation_bar.disable_default_expand
			factory.add_controls (table_component, navigation_bar)
			table_component.activate
		end

	add_fields (fields_component: DV_TABLEROW_FIELDS; cont: DV_BOX) is
			-- Create fields layout.
		local
			hbox: DV_HORIZONTAL_BOX
			code_list: ARRAYED_LIST [INTEGER]
			max_col_count, col_index: INTEGER
		do
			create hbox.make_without_borders
			cont.extend (hbox)
			if table_description.is_valid_code (table_description.Id_code) then
				factory.insensitive_field (Attribute_field_width, table_description.Id_code)
				factory.model.set_title ("ID")
				fields_component.add_field (factory.model)
				hbox.extend (factory.view)
			end
			code_list := table_description.attribute_code_list
			max_col_count := sqrt (code_list.count)
			from
				code_list.start
				col_index := 0
			until
				code_list.after
			loop
				if code_list.item /= table_description.Id_code then
					factory.sensitive_field (Attribute_field_width, code_list.item)
					fields_component.add_field (factory.model)
					hbox.extend (factory.view)
				end
				col_index := col_index + 1
				if col_index = max_col_count then
					col_index := 0
					create hbox.make_without_borders
					cont.extend (hbox)
				end
				code_list.forth
			end
		end

	sqrt (i: INTEGER): INTEGER is
			-- Square root of `i' (ceiling).
		local
			math: DOUBLE_MATH
		do
			create math
			Result := math.sqrt (i).ceiling
		end

	table_description: DB_TABLE_DESCRIPTION
			-- Description of database table to deal with.

	focusable_cbox: DV_COMBO_BOX;
			-- Combo box receiving focus.

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
end -- class TABLE_WINDOW
