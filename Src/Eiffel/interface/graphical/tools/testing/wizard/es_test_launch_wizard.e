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
			make,
			on_valid_state_change,
			load_page
		end

	SHARED_EIFFEL_PROJECT

	SHARED_DEBUGGER_MANAGER

	ES_SHARED_TEST_SERVICE

	ES_SHARED_LOCALE_FORMATTER

	CONF_ACCESS

	CONF_FILE_CONSTANTS

	EB_SHARED_GRAPHICAL_COMMANDS

create
	make

feature {NONE} -- Initialization

	make (a_composition: like composition; a_window: EV_WINDOW)
			-- <Precursor>
		local
			l_project: E_PROJECT
			l_uuid: UUID
			l_debugger_manager: like debugger_manager
		do
			composition := a_composition
			window := a_window
			initialize_dialog
			composition.attach_to_window (Current)

			l_project := eiffel_project
			create l_uuid.make_from_string (testing_library_uuid)
			if
				attached l_project.universe.target and then
				l_project.universe.library_of_uuid (l_uuid, False).is_empty and then
				not library_prompt_cell.item
			then
					-- Testing library has not been added yet
				library_prompt_cell.put (True)
				l_debugger_manager := debugger_manager
				if l_debugger_manager.application_is_executing then
					prompts.show_question_prompt_with_cancel (
						locale_formatter.translation (q_add_library), current_window,
						agent add_library (l_project, False), agent launch_wizard, agent
							do
								library_prompt_cell.put (False)
								dialog.destroy
							end)
				else
					prompts.show_question_prompt_with_cancel (
						locale_formatter.translation (q_add_library_and_recompile), current_window,
						agent add_library (l_project, True), agent launch_wizard, agent
							do
								library_prompt_cell.put (False)
								dialog.destroy
							end)
				end
			else
				launch_wizard
			end
		end

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

	library_prompt_cell: CELL [BOOLEAN]
			-- Cell containing status of library prompt
		once
			create Result.put (False)
		ensure
			result_attached: Result /= Void
		end

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

feature {NONE} -- Implementation

	add_library (a_project: E_PROJECT; a_recompile: BOOLEAN)
			-- Add testing library to current target.
			--
			-- `a_recompile': Should project be recompiled after adding library?
		local
			l_location: STRING
			l_factory: CONF_PARSE_FACTORY
			l_library: CONF_LIBRARY
			l_system: CONF_SYSTEM
			l_target: CONF_TARGET
			l_manager: EB_CLUSTER_MANAGER
			l_name: STRING
		do
			l_target := a_project.universe.target
			create l_factory
			l_location := testing_library_path
			if a_project.universe.group_of_name (testing_library_name) /= Void then
				l_name := testing_library_name + "_library"
			else
				l_name := testing_library_name
			end
			l_library := l_factory.new_library (l_name, l_location, l_target)
			l_library.set_classes (create {STRING_TABLE [CONF_CLASS]}.make (0))
			l_system := l_factory.new_system_generate_uuid_with_file_name ("dummy-system-file-name.ecf", "temp", latest_namespace)
			l_system.set_application_target (l_target)
			l_library.set_library_target (l_factory.new_target ("temp", l_system))
			l_target.add_library (l_library)
			l_target.system.store

			if l_target.system.store_successful then
				create l_manager.make (window_manager.last_focused_development_window)
				l_manager.refresh

				if a_recompile and discover_melt_cmd.executable then
					discover_melt_cmd.execute
				end

				launch_wizard
			else
				prompts.show_error_prompt (warning_messages.w_not_writable (l_target.system.file_name), window, Void)
				library_prompt_cell.put (False)
				dialog.destroy
			end

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

	testing_library_name: STRING = "testing"

feature {NONE} -- Internationalization

	t_title: STRING = "New Eiffel Test"

	q_add_library: STRING =
		"The testing library which is needed to compile and execute tests has not been added yet.%N%N%
		%Since you are currently debugging an application, EiffelStudio will add the library without recompiling the project. %
		%New tests will not appear in the testing tool until you stop the debugging session and recompile the project manually.%N%N%
		%Would you like EiffelStudio to add the testing library before launching the test creation wizard?"

	q_add_library_and_recompile: STRING =
		"The testing library which is needed to compile and execute tests has not been added yet.%N%N%
		%Would you like EiffelStudio to add the library and recompile before launching the test creation wizard?"

	e_project_not_compiled: STRING = "Please compile the project first"

	back_text: STRING = "Back"
	next_text: STRING = "Next"

	launch_text: STRING = "Launch"

	cancel_text: STRING = "Cancel"

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
