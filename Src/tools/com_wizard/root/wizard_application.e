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

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Run the program.
		local
			l_cls: COMMAND_LINE_SYNTAX
			l_clp: COMMAND_LINE_PARSER
			l_valid_options: HASH_TABLE [LIST [STRING], STRING]
			l_definition_file, l_text: STRING
		do
			create l_cls.make (option_specifications)
			create l_clp.make (l_cls)
			l_clp.parse ((create {ARGUMENTS}).argument_array)
			exe_name := l_clp.executable_without_suffix
			l_valid_options := l_clp.valid_options
			if l_clp.invalid_options_found then				
				print (l_clp.error_message)
				print (l_cls.program_usage (exe_name) + "%N")
				print ("Use -h/--help for more help." + "%N")
			else
				if l_valid_options.has ("-g") then
					make_and_launch
				else
					if l_valid_options.has ("-v") then
						print_version_info
					elseif l_valid_options.has ("-h") then
						print (l_cls.program_help (exe_name, Void, Void))
					elseif not l_valid_options.is_empty then
						if l_valid_options.has ("-e") and not (l_valid_options.has ("-a") and l_valid_options.has ("-f") and l_valid_options.has ("-u")) then
							print ("Options '-a', '-f' and '-u' required by option '-e'.")
							print (l_cls.program_usage (exe_name) + "%N")
							print ("Use -h/--help for more help." + "%N")
						else
							if l_valid_options.has ("-m") and not l_valid_options.has ("-s") then
								print ("Option '-s' required by option '-m'.")
								print (l_cls.program_usage (exe_name) + "%N")
								print ("Use -h/--help for more help." + "%N")
							else
								l_valid_options.search ("-a")
								if l_valid_options.found then
									environment.set_ace_file_name (l_valid_options.found_item.first.twin)
								end
								environment.set_backup (l_valid_options.has ("-b"))
								l_valid_options.search ("-u")
								if l_valid_options.found then
									environment.set_class_cluster_name (l_valid_options.found_item.first.twin)
								end
								environment.set_compile_c (l_valid_options.has ("-i") or l_valid_options.has ("-l"))
								environment.set_compile_eiffel (l_valid_options.has ("-l"))
								l_valid_options.search ("-d")
								if l_valid_options.found then
									environment.set_destination_folder (l_valid_options.found_item.first.twin)
								else
									environment.set_destination_folder ((create {EXECUTION_ENVIRONMENT}).current_working_directory)
								end
								l_valid_options.search ("-f")
								if l_valid_options.found then
									environment.set_eiffel_class_name (l_valid_options.found_item.first.twin)
								end
								l_valid_options.search ("-e")
								if l_valid_options.found then	
									l_text := l_valid_options.found_item.first.twin
									environment.set_is_eiffel_interface
									environment.set_eiffel_project (l_text)
									environment.set_project_name (l_text.substring (l_text.last_index_of ('\', l_text.count) + 1, l_text.count))
								end
								l_valid_options.search ("-c")
								if l_valid_options.found then
									l_definition_file := l_valid_options.found_item.first.as_lower
									environment.set_is_client
								end
								l_valid_options.search ("-s")
								if l_valid_options.found then
									l_definition_file := l_valid_options.found_item.first.as_lower
									environment.set_is_new_component
									if l_valid_options.has ("-m") then
										if l_definition_file.count > 4 and then l_definition_file.substring (l_definition_file.count - 3, l_definition_file.count).is_equal (".idl") then
											environment.set_marshaller_generated (True)
										else
											print ("%NWARNING: Option -m ignored because definition file is not an IDL file%N")
										end
									end
								end
								if l_valid_options.has ("-o") then
									environment.set_is_out_of_process
								else
									environment.set_is_in_process
								end
								environment.set_cleanup (l_valid_options.has ("-p"))
								if l_definition_file /= Void then
									if l_definition_file.substring_index (".idl", l_definition_file.count - 3) = l_definition_file.count - 3 then
										environment.set_idl_file_name (l_definition_file)
									else
										environment.set_type_library_file_name (l_definition_file)
										environment.set_idl (False)
									end
									environment.set_project_name (l_definition_file.substring (l_definition_file.last_index_of ('\', l_definition_file.count) + 1, l_definition_file.count))
								end
								no_logo := l_valid_options.has ("-n")
								generate
							end
						end
					end
				end
			end
		end
		
	make_and_launch is
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		do
			default_create
			create main_window
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
			if not no_logo then
				print_version_info
			end
			l_manager.run
			if environment.abort then
				(create {EXCEPTIONS}).die (1)
			else
				(create {EXCEPTIONS}).die (0)
			end
		end

	print_version_info is 
			-- Print version information.
		local
			s: STRING
		do
			s := "EiffelCOM Wizard " + version_number + "%N"
			s.append ("Copyright (c) 2005, Eiffel Software. All rights reserved." + "%N")
			print (s)
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
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_error then
					print ("ERROR:%N")
					print (l_output_event.text)
					print ("%N%N")
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_message then
					print (l_output_event.text)
					print ("%N")
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_text then
					print (l_output_event.text)
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_title then
					print ("%N")
					print (l_output_event.text)
					create l_underline.make (l_output_event.text.count)
					l_underline.fill_character ('-')
					print ("%N")
					print (l_underline)
					print ("%N%N")
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_warning then
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

	option_specifications: ARRAY [STRING] is
			-- The recognized options of this program
		once
			Result := <<"-v,--version#Print version information.",
				    "-h,--help#Print help on how to use the program.",
				    "-c,--client=DEFINITION_FILE!#Build client to access COM component described by DEFINITION_FILE.",
				    "-s,--server=DEFINITION_FILE!#Build new COM component as described by DEFINITION_FILE.",
				    "-e,--eiffel=PROJECT_FILE!#Add COM interface to Eiffel project with project file (*.epr) PROJECT_FILE.",
				    "-a,--ace=ACE_FILE!#Path to ace file of Eiffel project PROJECT_FILE. Use with '-e'.",
				    "-f,--facade=FACADE_CLASS!#Expose features from FACADE_CLASS to COM. Use with '-e'.",
				    "-u,--cluster=CLUSTER!#Cluster containing FACADE_CLASS given with option '-f'.",
				    "-m,--marshaller#Build marshaller DLL, can only be used with '--server' and if definition file is an IDL file.",
				    "-d,--destination=DESTINATION!#Generate files in DESTINATION folder. By default files are generated in current folder.",
				    "-o,--outofprocess#Access or build out of process component. By default access or build in-process component (DLL).",
				    "-i,--compilec#Compile generated C code.",
				    "-l,--compileeiffel#Compile eiffel code, also compile C code (implies -i).",
				    "-b,--backup#Backup overriden files by adding extension '.bac'.",
				    "-p,--cleanup#Cleanup destination folder prior to generation.",
				    "-n,--nologo#Do not display copyright information.",
				    "-g,--graphical#Launch GUI.",
				    "(-c|-s|-e)",
				    "(-p|-b)">>
		end
	
	exe_name: STRING
			-- Name of this executable

	no_logo: BOOLEAN;
			-- Should no logo be displayed?

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
end -- class WIZARD_APPLICATION

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

