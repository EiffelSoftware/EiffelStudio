note
	description: "Summary description for {ES_TEST_GENERATION_WIZARD_PAGE_PANEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_EXTRACTION_WIZARD_PAGE_PANEL

inherit
	ES_TEST_WIZARD_PAGE_PANEL

create
	make

feature {NONE} -- Initialization

	build_widget_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_frame: EV_FRAME
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			create l_frame.make_with_text (locale.translation (options_text))
			extend_no_expand (a_widget, l_frame)

			create l_vbox
			l_vbox.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			l_frame.extend (l_vbox)

			create l_hbox
			extend_no_expand (l_vbox, l_hbox)
			create stack_frame_count
			stack_frame_count.set_minimum_width_in_characters (4)
			stack_frame_count.value_range.resize_exactly (1, {INTEGER_32}.max_value)
			stack_frame_count.align_text_right

			create l_label.make_with_text (locale.translation (stack_frames_text))
			l_label.align_text_left
			l_hbox.extend (l_label)
			extend_no_expand (l_hbox, stack_frame_count)
		end

	initialize_with_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			l_session: SESSION_I
		do
			l_session := a_service.retrieve (False)
			if
				attached {NATURAL} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.stack_frames,
					{TEST_SESSION_CONSTANTS}.stack_frames_default) as l_count
			then
				stack_frame_count.set_value (l_count.as_integer_32)
			end
		end

feature {NONE} -- Access

	stack_frame_count: EV_SPIN_BUTTON
			-- Text field containg random number seed

feature -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {ES_TEST_WIZARD_PAGE} -- Basic operations

	store_to_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			l_session: SESSION_I
		do
			l_session := a_service.retrieve (False)
			l_session.set_value (stack_frame_count.value.as_natural_32, {TEST_SESSION_CONSTANTS}.stack_frames)
		end

feature {NONE} -- Internationalization

	options_text: STRING = "Options"
	stack_frames_text: STRING = "Number of extracted stack frames"

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
