note
	description: "Summary description for {ES_TEST_WIZARD_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_MANAGER

inherit
	EB_WIZARD_MANAGER

	ES_SHARED_TEST_SERVICE

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	CONF_ACCESS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_development_window: like development_window)
			-- Initialize `Current'.
		local
			l_service: TEST_SUITE_S
			l_shared_prefs: EB_SHARED_PREFERENCES
		do
			development_window := a_development_window
			create l_shared_prefs
			create wizard_info.make (l_shared_prefs.preferences.testing_tool_data)

			if test_suite.is_service_available then
				l_service := test_suite.service
				if l_service.is_project_initialized then
					launch_with_service (l_service)
				else
					prompts.show_error_prompt (locale.translation (e_project_not_compiled), current_window, Void)
				end
			else
				prompts.show_error_prompt (locale.translation (e_service_not_available), current_window, Void)
			end
		end

	launch_with_service (a_service: TEST_SUITE_S)
		require
			a_service_attached: a_service /= Void
			a_service_initialized: a_service.is_project_initialized
		local
			l_project: E_PROJECT
			l_uuid: UUID
			l_debugger_manager: like debugger_manager
		do
			l_project := a_service.eiffel_project
			create l_uuid.make_from_string (testing_library_uuid)
			if l_project.universe.library_of_uuid (l_uuid, False).is_empty and not library_prompt_cell.item then
					-- Testing library has not been added yet
				library_prompt_cell.put (True)
				l_debugger_manager := debugger_manager
				if l_debugger_manager.application_is_executing then
					prompts.show_question_prompt_with_cancel (
						locale_formatter.translation (q_add_library), current_window,
						agent add_library (l_project, False), agent launch_wizard, agent library_prompt_cell.put (False))
				else
					prompts.show_question_prompt_with_cancel (
						locale_formatter.translation (q_add_library_and_recompile), current_window,
						agent add_library (l_project, True), agent launch_wizard, agent library_prompt_cell.put (False))
				end
			else
				launch_wizard
			end
		end

	launch_wizard
		do
			make_and_show (development_window.window, create {ES_TEST_WIZARD_INITIAL_WINDOW}.make_window (development_window, wizard_info))
		end

feature -- Access

	wizard_title: STRING_32
			-- <Precursor>
		do
			Result := locale_formatter.translation (t_title)
		end

	wizard_icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := Pixmaps.bm_Wizard_testing_icon

			-- Make sure satisfy the postcondition if delivery is corrupted (default pixmap created is 16X16)
			if Result.width /= 60 or Result.height /= 60 then
				Result.set_size (60, 60)
			end
		end

	wizard_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := Pixmaps.bm_Wizard_blue

			-- Make sure satisfy the postcondition if delivery is corrupted (default pixmap created is 16X16)
			if Result.width < 165 or Result.height < 312 then
				Result.set_size (165, 312)
			end
		end

	wizard_window_icon: EV_PIXMAP
			-- <Precursor>
		do
		end

feature {NONE} -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Development window in which `Current' was launched

	current_window: attached EV_WINDOW
			-- <Precursor>
		local
			l_window: detachable like current_window
		do
			l_window := first_window
			if l_window = Void then
				l_window := development_window.window
				check l_window /= Void end
			end
			Result := l_window
		end

	wizard_info: ES_TEST_WIZARD_INFORMATION
			-- Information

	library_prompt_cell: attached CELL [BOOLEAN]
			-- Cell containing status of library prompt
		once
			create Result.put (False)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	add_library (a_project: E_PROJECT; a_recompile: BOOLEAN)
			-- Add testing library to current target.
			--
			-- `a_recompile': Should project be recompiled after adding library?
		local
			l_location: CONF_FILE_LOCATION
			l_factory: CONF_PARSE_FACTORY
			l_library: CONF_LIBRARY
			l_system: CONF_SYSTEM
			l_target: CONF_TARGET
			l_manager: EB_CLUSTER_MANAGER
			l_name: STRING
		do
			l_target := a_project.universe.target
			create l_factory
			if l_target.options.void_safety.item = {CONF_OPTION}.void_safety_index_all then
				l_location := l_factory.new_location_from_full_path (testing_library_path_safe, l_target)
			else
				l_location := l_factory.new_location_from_full_path (testing_library_path, l_target)
			end
			if a_project.universe.group_of_name (testing_library_name) /= Void then
				l_name := testing_library_name + "_library"
			else
				l_name := testing_library_name
			end
			l_library := l_factory.new_library (l_name, l_location, l_target)
			l_library.set_classes (create {HASH_TABLE [CONF_CLASS, STRING]}.make (0))
			l_system := l_factory.new_system_generate_uuid ("temp")
			l_system.set_application_target (l_target)
			l_library.set_library_target (l_factory.new_target ("temp", l_system))
			l_target.add_library (l_library)
			l_target.system.store

			create l_manager.make (development_window)
			l_manager.refresh

			if a_recompile and discover_melt_cmd.executable then
				discover_melt_cmd.execute
			end

			launch_wizard
		end

feature {NONE} -- Constants

	testing_library_name: STRING = "testing"

feature {NONE} -- Internationalization

	t_title: STRING = "New Eiffel test"

	q_add_library: STRING =
		"The testing library which is needed to compile and execute tests has not been added yet.%N%N%
		%Since you are currently debugging an application, EiffelStudio will add the library without recompiling the project. %
		%New tests will not appear in the testing tool until you stop the debugging session and recompile the project manually.%N%N%
		%Would you like EiffelStudio to add the testing library before launching the test creation wizard?"

	q_add_library_and_recompile: STRING =
		"The testing library which is needed to compile and execute tests has not been added yet.%N%N%
		%Would you like EiffelStudio to add the library and recompile before launching the test creation wizard?"

	e_project_not_compiled: STRING = "Please compile the project first"

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
