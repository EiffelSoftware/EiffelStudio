indexing
	description: "Root class of EiffelCOM Wizard, process arguments and run accordingly."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_APPLICATION

inherit
	EV_THREAD_APPLICATION

	WIZARD_SHARED_DATA
		export
			{NONE}
		undefine
			default_create,
			copy
		end

	WIZARD_SHARED_VERSION_NUMBER
		export
			{NONE}
		undefine
			default_create,
			copy
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Run the program.
		local
			l_parser: ARGUMENT_PARSER
			l_definition_file, l_text: STRING
			l_layout: WIZARD_EIFFEL_LAYOUT
		do
			create l_layout
			l_layout.check_environment_variable
			set_eiffel_layout (l_layout)

			default_create

			create l_parser.make
			l_parser.execute (agent start (l_parser))

			if not l_parser.is_successful then
				(create {EXCEPTIONS}).die (1)
			end
		end

	start (a_parser: ARGUMENT_PARSER) is
			-- Launch application from command line
		require
			a_parser_attached: a_parser /= Void
			a_parser_successful: a_parser.is_successful
		local
			l_definition_file, l_text: STRING
		do
			if a_parser.show_graphical_wizard then
				make_and_launch
			else
				check
					generating_code: a_parser.generate_for_client or a_parser.generate_for_server or a_parser.add_to_eiffel_project
				end

				if a_parser.add_to_eiffel_project then
					environment.set_source_ecf_file_name (a_parser.eiffel_configuration_file)
					if a_parser.use_facade_class then
						environment.set_eiffel_class_name (a_parser.facade_class)
						if a_parser.use_facade_cluster then
							environment.set_class_cluster_name (a_parser.facade_class_cluster)
						end
					end

					environment.set_is_eiffel_interface
					environment.set_eiffel_target (a_parser.eiffel_target)
					environment.set_project_name (a_parser.eiffel_target.twin)

					if a_parser.use_eiffel_project_path then
						environment.set_eiffel_project_path (a_parser.eiffel_project_path)
					end
				end

				environment.set_backup (a_parser.backup_files)
				environment.set_compile_eiffel (False)
				environment.set_compile_c (a_parser.compile_c_code)
				environment.set_compile_eiffel (a_parser.compile_eiffel_code)
				if a_parser.use_destination_folder then
					environment.set_destination_folder (a_parser.destination)
				else
					environment.set_destination_folder (a_parser.eiffel_project_path.twin)
				end

				if a_parser.generate_for_client then
					l_definition_file := a_parser.library_definition.as_lower
					environment.set_is_client
				elseif a_parser.generate_for_server then
					l_definition_file := a_parser.library_definition.as_lower
					environment.set_is_new_component
					if a_parser.use_custom_marshaller then
						if l_definition_file.count > 4 and then l_definition_file.substring (l_definition_file.count - 3, l_definition_file.count).is_equal (".idl") then
							environment.set_marshaller_generated (True)
						else
							print ("%NWARNING: Option -m ignored because definition file is not an IDL file%N")
						end
					end
				end
				if a_parser.out_of_process then
					environment.set_is_out_of_process
				else
					environment.set_is_in_process
				end
				environment.set_cleanup (a_parser.clean_up_destination)
				if l_definition_file /= Void then
					if l_definition_file.substring_index (".idl", l_definition_file.count - 3) = l_definition_file.count - 3 then
						environment.set_idl_file_name (l_definition_file)
					else
						environment.set_type_library_file_name (l_definition_file)
						environment.set_idl (False)
					end
					environment.set_project_name (l_definition_file.substring (l_definition_file.last_index_of ('\', l_definition_file.count) + 1, l_definition_file.count))
				end
				generate
			end
		end

	make_and_launch is
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		do
			create main_window.make
			main_window.show
			launch
		end

feature {NONE} -- Implementation

	generate is
			-- Start generation according to settings stored in `environment'.
		local
			l_manager: WIZARD_MANAGER
		do
			set_progress_report (create {WIZARD_PROGRESS_REPORT}.make (agent dummy_process))
			set_message_output (create {WIZARD_MESSAGE_OUTPUT}.make (agent display_output))
			create l_manager
			l_manager.run
			if environment.abort then
				(create {EXCEPTIONS}).die (1)
			else
				(create {EXCEPTIONS}).die (0)
			end
		end

	dummy_process (a_event: EV_THREAD_EVENT) is
			-- Do nothing.
		do

		end

	display_output (a_event: EV_THREAD_EVENT) is
			-- Display output according to `a_event'.
		require
			non_void_event: a_event /= Void
		local
			l_output_event: WIZARD_OUTPUT_EVENT
			l_underline: STRING
		do
			l_output_event ?= a_event
			if l_output_event /= Void then
				inspect
					l_output_event.id
				when {WIZARD_OUTPUT_EVENT_ID}.Display_error then
					print ("ERROR:%N")
					print (l_output_event.text)
					print ("%N%N")
				when {WIZARD_OUTPUT_EVENT_ID}.Display_message then
					print (l_output_event.text)
					print ("%N")
				when {WIZARD_OUTPUT_EVENT_ID}.Display_text then
					print (l_output_event.text)
				when {WIZARD_OUTPUT_EVENT_ID}.Display_title then
					print ("%N")
					print (l_output_event.text)
					create l_underline.make (l_output_event.text.count)
					l_underline.fill_character ('-')
					print ("%N")
					print (l_underline)
					print ("%N%N")
				when {WIZARD_OUTPUT_EVENT_ID}.Display_warning then
					print ("WARNING:%N")
					print (l_output_event.text)
					print ("%N")
				else
				end
			end
		end

feature {NONE} -- Private Access

	main_window: WIZARD_MAIN_WINDOW
		-- Main window of `Current'.

;indexing
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
end -- class WIZARD_APPLICATION


