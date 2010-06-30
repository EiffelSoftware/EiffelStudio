note
	description: "Summary description for {ES_TEST_GENERATION_WIZARD_PAGE_PANEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_EXECUTION_WIZARD_PAGE_PANEL

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
			create l_label.make_with_text (locale.translation (concurrent_text))
			l_label.align_text_left
			l_hbox.extend (l_label)

			create concurrent_count
			concurrent_count.align_text_right
			concurrent_count.set_minimum_width (50)
			concurrent_count.value_range.resize_exactly (1, {INTEGER_32}.max_value)
			extend_no_expand (l_hbox, concurrent_count)

			extend_no_expand (l_vbox, l_hbox)
			build_keep_checkboxes (a_widget)
		end

	build_keep_checkboxes (a_widget: EV_VERTICAL_BOX)
			-- Build check boxes for keeping test files/directories.
		local
			l_frame: EV_FRAME
			l_vbox: EV_VERTICAL_BOX
		do
			create l_frame.make_with_text (locale.translation (testing_directory_text))
			extend_no_expand (a_widget, l_frame)

			create l_vbox
			l_vbox.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			l_frame.extend (l_vbox)

			create keep_failing_checkbox.make_with_text (locale.translation (keep_failing_text))
			extend_no_expand (l_vbox, keep_failing_checkbox)

			create keep_unresolved_checkbox.make_with_text (locale.translation (keep_unresolved_text))
			extend_no_expand (l_vbox, keep_unresolved_checkbox)

			create keep_passing_checkbox.make_with_text (locale.translation (keep_passing_text))
			extend_no_expand (l_vbox, keep_passing_checkbox)
		end

	initialize_with_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			l_session: SESSION_I
		do
			l_session := a_service.retrieve (False)
			if
				attached {NATURAL} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.concurrent_executors,
					{TEST_SESSION_CONSTANTS}.concurrent_executors_default) as l_count
			then
				concurrent_count.set_value (l_count.as_integer_32)
			end

			if
				attached {BOOLEAN} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.keep_failing,
					{TEST_SESSION_CONSTANTS}.keep_failing_default) as l_keep and then l_keep
			then
				keep_failing_checkbox.enable_select
			else
				keep_failing_checkbox.disable_select
			end

			if
				attached {BOOLEAN} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.keep_unresolved,
					{TEST_SESSION_CONSTANTS}.keep_unresolved_default) as l_keep and then l_keep
			then
				keep_unresolved_checkbox.enable_select
			else
				keep_unresolved_checkbox.disable_select
			end

			if
				attached {BOOLEAN} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.keep_passing,
					{TEST_SESSION_CONSTANTS}.keep_passing_default) as l_keep and then l_keep
			then
				keep_passing_checkbox.enable_select
			else
				keep_passing_checkbox.disable_select
			end
		end

feature {NONE} -- Access

	concurrent_count: EV_SPIN_BUTTON
			-- Text field containg random number seed

	keep_failing_checkbox: EV_CHECK_BUTTON
			-- Check box for keeping failing test files

	keep_unresolved_checkbox: EV_CHECK_BUTTON
			-- Check box for keeping unresolved test files

	keep_passing_checkbox: EV_CHECK_BUTTON
			-- Check box for keeping passing test files

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
			l_session.set_value (concurrent_count.value.as_natural_32, {TEST_SESSION_CONSTANTS}.concurrent_executors)
			l_session.set_value (keep_failing_checkbox.is_selected, {TEST_SESSION_CONSTANTS}.keep_failing)
			l_session.set_value (keep_unresolved_checkbox.is_selected, {TEST_SESSION_CONSTANTS}.keep_unresolved)
			l_session.set_value (keep_passing_checkbox.is_selected, {TEST_SESSION_CONSTANTS}.keep_passing)
		end

feature {NONE} -- Internationalization

	options_text: STRING = "Options"
	concurrent_text: STRING = "Number of tests that can run in parallel"

	testing_directory_text: STRING = "Testing directory and files"
	keep_failing_text: STRING = "Keep working directory of failing tests"
	keep_unresolved_text: STRING = "Keep working directory of unresolved tests"
	keep_passing_text: STRING = "Keep working directory of passing tests"

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
