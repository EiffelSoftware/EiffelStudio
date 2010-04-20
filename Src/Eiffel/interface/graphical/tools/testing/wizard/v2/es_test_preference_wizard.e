note
	description: "Summary description for {ES_TEST_PREFERENCE_WIZARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_PREFERENCE_WIZARD

inherit
	ES_TEST_WIZARD
		redefine
			on_valid_state_change
		end

create
	make

feature {NONE} -- Initialize

	initialize_dialog_content (a_vbox: EV_VERTICAL_BOX)
			-- <Precursor>
		do
			initialize_notebook (a_vbox)
			initialize_navigation (a_vbox)

			dialog.set_default_cancel_button (close_button)
			dialog.set_default_push_button (close_button)
		end

	initialize_notebook (a_vbox: EV_VERTICAL_BOX)
			-- Initialize `notebook'
		local
			l_cell: EV_CELL
			i: INTEGER
		do
			create l_cell
			l_cell.set_minimum_height (dialog_unit_to_pixels (10))
			extend_no_expand (a_vbox, l_cell)

			create notebook
			from
				i := 1
			until
				i > composition.count
			loop
				create l_cell
				if i = 1 then
					l_cell.extend (page_container)
				end
				notebook.extend (l_cell)
				notebook.item_tab (l_cell).set_text (composition.i_th (i).title)
				i := i + 1
			end
			notebook.selection_actions.extend (agent on_notebook_select)
			a_vbox.extend (notebook)
		end

	initialize_navigation (a_vbox: EV_VERTICAL_BOX)
			-- Initialize navigation buttons.
		local
			l_hbox: EV_HORIZONTAL_BOX
		do
			create l_hbox
			l_hbox.set_padding (default_border_size)
			l_hbox.set_border_width (large_border_size)

			l_hbox.extend (create {EV_CELL})

			create close_button.make_with_text_and_action (locale.translation (close_text), agent on_close)
			close_button.set_minimum_width (default_button_width)

			l_hbox.extend (close_button)
			l_hbox.disable_item_expand (close_button)

			extend_no_expand (a_vbox, l_hbox)
		end

feature {NONE} -- Access

	notebook: EV_NOTEBOOK
			-- Notebook for switching between wizard pages

	close_button: EV_BUTTON
			-- Button for closing wizard

feature {NONE} -- Events

	on_close
			-- Called when `close_button' is pressed.
		do
			close_wizard (True)
		end

	on_valid_state_change
			-- <Precursor>
		local
			l_valid: BOOLEAN
		do
			l_valid := page.is_valid and then composition.are_pages_valid
			adjust_sensitivity (close_button, l_valid)
		end

	on_notebook_select
			-- Called when a notebook tab is selected.
		local
			l_index: INTEGER
		do
			if attached {EV_CELL} page_container.parent as l_cell then
				l_cell.wipe_out
			end
			if attached {EV_CELL} notebook.selected_item as l_cell then
				l_cell.extend (page_container)
			end
			l_index := notebook.selected_item_index
			check valid_index: is_valid_page_index (l_index) end
			load_page (l_index)
		end

feature {NONE} -- Internationalization

	close_text: STRING = "Close"

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end
