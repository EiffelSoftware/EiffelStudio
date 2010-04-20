note
	description: "Summary description for {ES_TEST_LAUNCH_WIZARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_LAUNCH_WIZARD

inherit
	ES_TEST_WIZARD
		redefine
			on_valid_state_change,
			load_page
		end

create
	make

feature {NONE} -- Initialization

	initialize_dialog_content (a_vbox: EV_VERTICAL_BOX)
			-- <Precursor>
		do
			initialize_title (a_vbox)
			initialize_page_content (a_vbox)
			initialize_navigation (a_vbox)

			dialog.set_default_cancel_button (cancel_button)
			dialog.set_default_push_button (launch_button)
		end

	initialize_title (a_vbox: EV_VERTICAL_BOX)
			-- Initialize `title_box'.
		do
			create title_box
			title_box.set_minimum_height (dialog_unit_to_pixels (60))
			title_box.set_background_color (white)
			title_box.set_border_width (large_border_size)
			a_vbox.extend (title_box)
			a_vbox.disable_item_expand (title_box)

			create title
			title.align_text_left
			title.set_font (title_font)
			title.set_background_color (white)
			title_box.extend (title)

			extend_no_expand (a_vbox, create {EV_HORIZONTAL_SEPARATOR})
		end

	initialize_page_content (a_vbox: EV_VERTICAL_BOX)
			-- Initialize `frame'.
		do
			a_vbox.extend (page_container)
		end

	initialize_navigation (a_vbox: EV_VERTICAL_BOX)
			-- Initialize navigation buttons.
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
			l_sep: EV_HORIZONTAL_SEPARATOR
		do
			create l_sep
			a_vbox.extend (l_sep)
			a_vbox.disable_item_expand (l_sep)

			create l_hbox
			l_hbox.set_padding (default_border_size)
			l_hbox.set_border_width (large_border_size)

			l_hbox.extend (create {EV_CELL})

			create back_button.make_with_text_and_action (locale.translation (back_text), agent on_back)
			back_button.set_minimum_width (default_button_width)
			create next_button.make_with_text_and_action (locale.translation (next_text), agent on_next)
			next_button.set_minimum_width (default_button_width)
			create launch_button.make_with_text_and_action (locale.translation (launch_text), agent on_launch)
			launch_button.set_minimum_width (default_button_width)
			create cancel_button.make_with_text_and_action (locale.translation (cancel_text), agent on_cancel)
			cancel_button.set_minimum_width (default_button_width)

			l_hbox.extend (back_button)
			l_hbox.disable_item_expand (back_button)
			l_hbox.extend (next_button)
			l_hbox.disable_item_expand (next_button)

			create l_cell
			l_cell.set_minimum_width (small_padding_size)
			l_hbox.extend (l_cell)
			l_hbox.disable_item_expand (l_cell)

			l_hbox.extend (cancel_button)
			l_hbox.disable_item_expand (cancel_button)

			create l_cell
			l_cell.set_minimum_width (small_padding_size)
			l_hbox.extend (l_cell)
			l_hbox.disable_item_expand (l_cell)

			l_hbox.extend (launch_button)
			l_hbox.disable_item_expand (launch_button)

			a_vbox.extend (l_hbox)
			a_vbox.disable_item_expand (l_hbox)
		end

feature {NONE} -- Access

	title_box: EV_HORIZONTAL_BOX
			-- White box displaying page title

	title: EV_LABEL
			-- Label in `title_box'

	back_button,
	next_button,
	launch_button,
	cancel_button: EV_BUTTON
			-- Buttons for navigating through wizard

feature -- Status report

	is_launch_requested: BOOLEAN
			-- Has user requested launch before closing wizard?

feature -- Events

	on_valid_state_change
			-- <Precursor>
		local
			l_valid: BOOLEAN
		do
			l_valid := page.is_valid and then composition.are_pages_valid
			adjust_sensitivity (launch_button, l_valid)

			adjust_sensitivity (back_button, l_valid and page_index > 1)
			adjust_sensitivity (next_button, l_valid and page_index < composition.count)
		end

feature {NONE} -- Events

	on_cancel
			-- Called when `cancel_button' is pressed by the user.
		do
			is_launch_requested := False
			close_wizard (False)
		end

feature {NONE} -- Basic operations

	load_page (an_index: INTEGER_32)
			-- <Precursor>
		do
			Precursor (an_index)
			title.set_text (page.title)
		end

	on_back
			-- Called when user presses `back_button'.
		do
			if is_valid_page_index (page_index - 1) then
				load_page (page_index - 1)
			end
		end

	on_next
			-- Called when user presses `next_button'.
		do
			if is_valid_page_index (page_index + 1) then
				load_page (page_index + 1)
			end
		end

	on_launch
			-- Called when user preses `launch_button'.
		do
			is_launch_requested := True
			close_wizard (True)
		end

feature {NONE} -- Constants

	title_font: EV_FONT
			-- Title font
		once
			create Result
			Result.set_family ({EV_FONT_CONSTANTS}.Family_screen)
			Result.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
			Result.set_shape ({EV_FONT_CONSTANTS}.Shape_regular)
			Result.preferred_families.extend ("Tahoma")
			Result.preferred_families.extend ("Arial")
			Result.preferred_families.extend ("Helvetica")
		end

feature {NONE} -- Internationalization

	back_text: STRING = "Back"
	next_text: STRING = "Next"

	launch_text: STRING = "Launch"

	cancel_text: STRING = "Cancel"

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
