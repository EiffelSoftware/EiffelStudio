indexing
	description: "Main window: lets the user choose %
			%which database table to edit."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	STATUS_WINDOW

create
	make_from_application

feature -- Initialization

	make_from_application (appl: APPLICATION) is
			-- Initialize.
		require
			not_void: appl /= Void
		do
			make
			close_request_actions.extend (appl~destroy)
			set_title (main_window_title)
			create table_window_list.make (10)
		end

	set_initial_focus is
			-- Set initial focus to the table selection combo-box.
		do
			table_selection_cbox.set_focus
		end

feature {NONE} -- Implementation

	create_window_content is
			-- Add window content.
		local
			vbox: DV_VERTICAL_BOX
			label: DV_LABEL
			button: DV_BUTTON
		do
			create vbox.make
			container.extend (vbox)
			create label.make_with_text (Table_select_label_text)
			vbox.extend (label)
			create table_selection_cbox.make_with_integer_data
			vbox.extend (table_selection_cbox)
			fill_cbox
			create button.make_with_text (Table_select_button_text)
			button.add_action (~popup_table_window)
			vbox.extend (button)
			vbox.extend_separator
			create button.make_with_text (Exit_button_text)
			button.add_action (close_request_actions~call ([]))
			vbox.extend (button)
		end

	fill_cbox is
			-- Fill `table_selection_cbox' with database table names.
		require
			not_void: table_selection_cbox /= Void
		local
			tname_list: ARRAYED_LIST [STRING]
		do
			tname_list := tables.Name_list
			from
				tname_list.start
			until
				tname_list.after
			loop
				table_selection_cbox.add_data_choice (tname_list.index, tname_list.item)
				tname_list.forth
			end
		end

	popup_table_window is
			-- Pop up a window to edit content of database table selected in
			-- `table_selection_cbox'.
		local
			table_window: TABLE_WINDOW
		do
			create table_window.make_with_table_code (table_selection_cbox.value)
			table_window.show
			table_window.set_initial_focus
			table_window_list.extend (table_window)
		end

	table_selection_cbox: DV_COMBO_BOX
			-- Combo box to select a database table.

	table_window_list: ARRAYED_LIST [TABLE_WINDOW];
			-- Table window list. To avoid problems linked to 
			-- the use of a lv.

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
end -- class MAIN_WINDOW
