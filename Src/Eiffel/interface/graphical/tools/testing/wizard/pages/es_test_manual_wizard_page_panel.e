note
	description: "Summary description for {ES_TEST_GENERATION_WIZARD_PAGE_PANEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_MANUAL_WIZARD_PAGE_PANEL

inherit
	ES_TEST_WIZARD_PAGE_PANEL

create
	make

feature {NONE} -- Initialization

	build_widget_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		do
			build_routine_name_interface (a_widget)
			build_options_interface (a_widget)
		end

	build_routine_name_interface (a_widget: EV_VERTICAL_BOX)
			-- Initialize `routine_name'.
		local
			l_hbox: EV_HORIZONTAL_BOX
		do
			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			extend_no_expand (l_hbox, create {EV_LABEL}.make_with_text (
				locale_formatter.translation (routine_name_text)))

			create routine_name.make (create {EV_TEXT_FIELD}, agent on_validate_test_name)
			l_hbox.extend (routine_name)

			extend_no_expand (a_widget, l_hbox)
		end

	build_options_interface (a_widget: EV_VERTICAL_BOX)
			-- Initialize options.
		local
			l_vbox: EV_VERTICAL_BOX
			l_frame: EV_FRAME
		do
			create l_vbox
			l_vbox.set_border_width ({ES_UI_CONSTANTS}.frame_border)

			create setup_checkbox
			setup_checkbox.set_text (locale_formatter.formatted_translation (b_setup_routine, [{ETEST_CONSTANTS}.prepare_routine_name]))
			extend_no_expand (l_vbox, setup_checkbox)

			create tear_down_checkbox
			tear_down_checkbox.set_text (locale_formatter.formatted_translation (b_tear_down_routine, [{ETEST_CONSTANTS}.clean_routine_name]))
			extend_no_expand (l_vbox, tear_down_checkbox)

			create system_level_test_checkbox
			system_level_test_checkbox.set_text (locale_formatter.translation (b_system_level_test))
			extend_no_expand (l_vbox, system_level_test_checkbox)

			create l_frame.make_with_text (locale_formatter.translation (options_title))
			l_frame.extend (l_vbox)
			extend_no_expand (a_widget, l_frame)
		end

	initialize_with_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			l_session: SESSION_I
		do
			l_session := a_service.retrieve (True)

			routine_name.valid_state_changed_actions.extend (agent on_valid_state_changed)

			if
				attached {STRING} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.routine_name,
					{TEST_SESSION_CONSTANTS}.routine_name_default) as l_routine_name
			then
				routine_name.set_text (l_routine_name)
			end

			if
				attached {BOOLEAN} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.has_prepare,
					{TEST_SESSION_CONSTANTS}.has_prepare_default) as l_has_prepare and then l_has_prepare
			then
				setup_checkbox.enable_select
			end

			if
				attached {BOOLEAN} l_session.value_or_default ({TEST_SESSION_CONSTANTS}.has_clean,
					{TEST_SESSION_CONSTANTS}.has_clean_default) as l_has_clean and then l_has_clean
			then
				tear_down_checkbox.enable_select
			end

			system_level_test_checkbox.disable_sensitive
		end

feature {NONE} -- Access

	routine_name: ES_VALIDATING_WRAPPED_WIDGET
			-- Text field for new test class name

	setup_checkbox: EV_CHECK_BUTTON
			-- Checkbox for creating setup routine

	tear_down_checkbox: EV_CHECK_BUTTON
			-- Checkbox for creating tear down routine

	system_level_test_checkbox: EV_CHECK_BUTTON
			-- Checkbox for creating a system level test

	feature_name_validator: ES_FEATURE_NAME_VALIDATOR
			-- Validator for `test_name'
		once
			create Result
		end

feature -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := routine_name.is_valid
		end

feature {ES_TEST_WIZARD_PAGE} -- Basic operations

	store_to_session (a_service: SESSION_MANAGER_S)
			-- <Precursor>
		local
			l_session: SESSION_I
		do
			l_session := a_service.retrieve (True)

			l_session.set_value (routine_name.text.as_string_8, {TEST_SESSION_CONSTANTS}.routine_name)
			l_session.set_value (setup_checkbox.is_selected, {TEST_SESSION_CONSTANTS}.has_prepare)
			l_session.set_value (tear_down_checkbox.is_selected, {TEST_SESSION_CONSTANTS}.has_clean)
		end

feature {NONE} -- Basic operations

	on_validate_test_name (a_name: STRING_32): TUPLE [BOOLEAN, detachable STRING_32]
			-- Called when `class_name' content needs to be validated
		local
			l_valid: BOOLEAN
			l_msg: STRING_32
			l_name: STRING
		do
			l_name := a_name.to_string_8
			check l_name /= Void end
			feature_name_validator.validate_feature_name (l_name)
			l_valid := feature_name_validator.is_valid
			l_msg := feature_name_validator.last_error_message
			if l_valid then
				if l_name.is_equal ({ETEST_CONSTANTS}.prepare_routine_name) or l_name.is_equal ({ETEST_CONSTANTS}.clean_routine_name) then
					l_valid := False
					l_msg := locale_formatter.formatted_translation (e_bad_test_name, [a_name])
				end
			end
			Result := [l_valid, l_msg]
		end

feature {NONE} -- Internationalization

	routine_name_text: STRING = "Test name: "

	options_title: STRING = "Class options"

	b_setup_routine: STRING = "Redefine `$1'"
	b_tear_down_routine: STRING = "Redefine `$1'"
	b_system_level_test: STRING = "System level test"

	e_bad_test_name: STRING = "$1 can not be used as a new test routine name since it already exists in one of the ancestor classes."

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
