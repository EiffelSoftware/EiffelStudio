indexing
	description: "Summary description for {ES_TEST_WIZARD_INITIAL_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_INITIAL_WINDOW

inherit
	EB_WIZARD_INITIAL_STATE_WINDOW
		redefine
			build,
			wizard_information
		end

	ES_TEST_WIZARD_WINDOW
		redefine
			wizard_information
		end

create
	make_window

feature {NONE} -- Initialization

	build
			-- <Precursor>
		local
			l_parent: EV_CONTAINER
		do
			Precursor

			l_parent := choice_box

			create new_class_button
			new_class_button.set_text (locale_formatter.translation (b_new_class))
			new_class_button.enable_select
			new_class_button.select_actions.extend (agent wizard_information.set_new_manual_test_class)
			new_class_button.set_background_color (white_color)
			l_parent.extend (new_class_button)

			create existing_class_button
			existing_class_button.set_text (locale_formatter.translation (b_existing_class))
			existing_class_button.select_actions.extend (agent wizard_information.set_manual_test_class)
			existing_class_button.set_background_color (white_color)
			l_parent.extend (existing_class_button)

			create extraction_button
			extraction_button.set_text (locale_formatter.translation (b_extraction))
			extraction_button.select_actions.extend (agent wizard_information.set_extracted_test_class)
			extraction_button.set_background_color (white_color)
			l_parent.extend (extraction_button)

			create generate_button
			generate_button.set_text (locale_formatter.translation (b_generation))
			generate_button.select_actions.extend (agent wizard_information.set_generated_test_class)
			generate_button.set_background_color (white_color)
			l_parent.extend (generate_button)

			on_after_initialize
		end

	on_after_initialize
			-- Called after all widgets have been initialized.
		local
			l_button: like new_class_button
		do
			l_button := new_class_button

				-- Adding tests to existing classes is not implemented yet
			existing_class_button.disable_sensitive

			if debugger_manager.application_is_executing and then debugger_manager.application_is_stopped then
				extraction_button.enable_sensitive
				if wizard_information.is_extracted_test_class then
					l_button := extraction_button
				end
			else
				extraction_button.disable_sensitive
			end

				-- Auto Test not implemented yet
			if wizard_information.is_generated_test_class then
				l_button := generate_button
			end

			l_button.enable_select
			update_next_button_status
		end

feature {NONE} -- Access

	wizard_information: ES_TEST_WIZARD_INFORMATION
			-- Information user has provided to the wizard

feature {NONE} -- Access: widgets

	new_class_button: EV_RADIO_BUTTON
			-- Button for creating a new test class

	existing_class_button: EV_RADIO_BUTTON
			-- Button indicating that existing test class shall be used

	extraction_button: EV_RADIO_BUTTON
			-- Button for creating new extracted test

	generate_button: EV_RADIO_BUTTON
			-- Button for generating new tests

feature {NONE} -- Status report

	is_valid: BOOLEAN = True
			-- <Precursor>

feature -- Basic operations

	proceed_with_current_info
			-- <Precursor>
		do
			if wizard_information.is_manual_test_class then
				proceed_with_new_state(create {ES_TEST_WIZARD_CLASS_WINDOW}.make_window (development_window, wizard_information))
			else
				proceed_with_new_state(create {ES_TEST_WIZARD_NEW_CLASS_WINDOW}.make_window (development_window, wizard_information))
			end
		end

feature {NONE} -- Internationalization

	t_title: STRING = "New eiffel test wizard"
	t_subtitle: STRING = "This will create a new eiffel test"

	b_new_class: STRING = "Create new test class"
	b_existing_class: STRING = "Use existing test class"
	b_extraction: STRING = "Create test using current application status"
	b_generation: STRING = "Automatically generate new tests"

;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
end
