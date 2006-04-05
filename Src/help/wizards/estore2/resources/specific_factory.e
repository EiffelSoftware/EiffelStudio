indexing
	description: "Objects that can easily create display objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

class
	SPECIFIC_FACTORY

inherit
	DV_FACTORY

	SHARED

create
	make

feature -- Settings

	add_controls (table_component: DV_TABLE_COMPONENT; cont: DV_BOX) is
			-- Add standard controls to `table_component', create associated buttons and
			-- add them to `cont'.
		local
			button: DV_BUTTON
		do
			create button.make_with_text ("Apply")
			cont.extend (button)
			table_component.set_writing_control (button)
			create button.make_with_text ("Refresh")
			cont.extend (button)
			table_component.set_refreshing_control (button)
			create button.make_with_text ("Create")
			cont.extend (button)
			add_creator (table_component, button)
			create button.make_with_text ("Delete")
			cont.extend (button)
			table_component.set_deleting_control (button)
		end

	add_creator (table_comp: DV_TABLE_COMPONENT; button: DV_BUTTON) is
			-- Set a creator component to `table_comp'.
		local
			db_creator: DV_CHOICE_CREATOR
			db_tablerow_selector: DV_TABLEROW_ID_PROVIDER
			fields_list_comp: DV_CONTROL_NAVIGATOR
			tr_list: DV_TABLEROW_MULTILIST
			selection_window: DV_SELECTION_WINDOW
		do
			create db_creator.make
			db_creator.set_control (button)
			create tr_list
			create fields_list_comp.make
			fields_list_comp.set_display_list (tr_list)
			create db_tablerow_selector.make
			db_tablerow_selector.set_db_tablerow_navigator (fields_list_comp)
			create selection_window.make
			selection_window.set_display_list (tr_list)
			selection_window.set_content
			db_tablerow_selector.set_selecting_control (selection_window.selecting_control)
			db_tablerow_selector.set_raising_action (selection_window~show)
			db_creator.set_tablerow_selector (db_tablerow_selector)
			table_comp.set_db_creator (db_creator)
		end

	add_display_searcher (table_component: DV_TABLE_COMPONENT; cont: EV_CONTAINER) is
			-- Add a graphical searcher to `table_component' and add its display
			-- to `cont'.
		local
			button: DV_BUTTON
			cbox: DV_COMBO_BOX
			tfield: DV_TEXT_FIELD
			db_searcher: DV_INTERACTIVE_SEARCHER
			cbutton: DV_CHECK_BUTTON
			bar: DV_HORIZONTAL_BOX
		do
			create bar.make
			create db_searcher.make
			create first_cbox.make_with_integer_data
			fill_column_selecting_cbox (first_cbox, table_component.table_description)
			db_searcher.set_column_selector (first_cbox)
			bar.extend (first_cbox)
			create cbox.make_with_integer_data
			fill_basic_qualifying_cbox (cbox, db_manager)
			db_searcher.set_qualification_selector (cbox)
			bar.extend (cbox)
			create tfield
			db_searcher.set_value_selector (tfield)
			bar.extend (tfield)
			bar.enable_item_expand (tfield)
			create cbutton.make_with_text ("Case sensitive")
			db_searcher.set_case_selector (cbutton)
			bar.extend (cbutton)
			bar.disable_item_expand (cbutton)
			create button.make_with_text ("Go!")
			db_searcher.set_control (button)
			bar.extend (button)
			bar.disable_item_expand (button)
			table_component.set_db_searcher (db_searcher)
			cont.extend (bar)
		end

feature -- Access

	first_cbox: DV_COMBO_BOX;
			-- First combo box created through `add_display_searcher'.

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
end -- class SPECIFIC_FACTORY
