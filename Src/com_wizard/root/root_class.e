indexing
	description: "Objects that ..."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_CLASS

inherit
	ARGUMENTS

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		rename
			free as env_free
		export
			{NONE} all
		end

	WIZARD_OUTPUT_LEVEL
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

create
	make 

feature -- Initialization

	make is
			-- Initialize
		local
			a_project_name, new_eiffel_project: STRING
			new_com_project, com_file: STRING
			in_process, str_server: STRING
			str_automation, str_universal, str_compile_c: STRING 
			str_compile_eiffel, str_stop_on_error: STRING
			str_output_all, str_output_warning, str_output_none: STRING
			separator_index: INTEGER
		do
			if 
				separate_word_option_value ("help") /= Void or
				argument_count = 0
			then
				help
			else
				a_project_name := separate_word_option_value ("open") 
				new_eiffel_project := separate_word_option_value ("new_eiffel_project")
				eiffel_project_name := separate_word_option_value ("epr")
				eiffel_class_name := separate_word_option_value ("class")
				class_cluster_name := separate_word_option_value ("cluster")
				ace_file_name := separate_word_option_value ("ace")
				new_com_project := separate_word_option_value ("new_com_project")
				com_file := separate_word_option_value ("com_file") 
				destination_folder := separate_word_option_value ("destination")
				in_process := separate_word_option_value ("in_process")
				str_server := separate_word_option_value ("server")
				str_automation := separate_word_option_value ("automation")
				str_universal := separate_word_option_value ("universal")
				proxy_stub_file_name := separate_word_option_value ("proxy_stub")
				str_compile_c := separate_word_option_value ("compile_c")
				str_compile_eiffel := separate_word_option_value ("compile_eiffel") 
				str_stop_on_error := separate_word_option_value ("stop_on_error")
				str_output_all := separate_word_option_value ("output_all")
				str_output_warning := separate_word_option_value ("output_warning")
				str_output_none := separate_word_option_value ("output_none")
				not_spawn_ebench := separate_word_option_value ("not_spawn_ebench") /= Void
				
				set_message_output_and_progress_report
				if a_project_name /= Void and then not a_project_name.is_empty then
					open_project (a_project_name)
				else
					if new_eiffel_project /= Void then
						is_new_eiffel_project := True
						new_project  := True
						
						is_server := True
						project_name := clone (a_project_name)
						separator_index := project_name.last_index_of (Directory_separator, project_name.count)
						project_name.tail (project_name.count - separator_index)
						
					elseif new_com_project /= Void then
						is_new_eiffel_project := False
						new_project := True
						
						is_server := str_server /= Void 
						is_client := not (str_server /= Void)
						
						if is_server then
							automation := str_automation /= Void
							use_universal_marshaller := str_universal /= Void
						end
						
						if com_file.substring_index (idl_file_extension, 1) =
								(com_file.count - idl_file_extension.count + 1) then
							idl := True
							idl_file_name := com_file
						else
							type_library_file_name := com_file
						end
						project_name := clone (com_file)
						separator_index := project_name.last_index_of (Directory_separator, project_name.count)
						project_name.tail (project_name.count - separator_index)
					end
					
					if in_process /= Void then
						in_process_server := True
					else
						out_of_process_server := True
					end
					
					compile_c := str_compile_c /= Void
					if compile_c then
						compile_eiffel := str_compile_eiffel /= Void
					end
					
					if str_output_all /= Void then
						output_level := Output_all
					elseif str_output_warning /= Void then
						output_level := Output_warnings
					else
						output_level := Output_none
					end
					
					stop_on_error := str_stop_on_error /= Void
					initialize_shared_wizard_environment
				end
				if wizard_environment_set then
					run_wizard_manager
				end
			end
		end

feature -- Access

	eiffel_class_name: STRING
			-- Eiffel class name to generate IDL.

	class_cluster_name: STRING
			-- Cluster to which Eiffel class belongs.

	eiffel_project_name: STRING
			-- Eiffel project name.

	ace_file_name: STRING
			-- Eiffel Ace file.

	in_process_server: BOOLEAN
			-- Should in process server code be generated?
			
	out_of_process_server: BOOLEAN
			-- Should out of process server code be generated?

	idl_file_name: STRING
			-- Path to definition file.
	
	type_library_file_name: STRING
			-- Path to type library.

	destination_folder: STRING
			-- Path to destination folder.
	
	project_name: STRING
			-- Project name.

	is_new_eiffel_project: BOOLEAN
			-- Is new EiffelCOM project from Eiffel class?

	idl: BOOLEAN
			-- Is definition file an IDL file?

	proxy_stub_file_name: STRING
			-- Path to Proxy/Stub dll.
			
	use_universal_marshaller: BOOLEAN
			-- Should component use universal marshaller?

	is_server: BOOLEAN
			-- Should code for server be generated?

	is_client: BOOLEAN
			-- Should code for client be generated?

	automation: BOOLEAN
			-- Should server use automation?

	output_level: INTEGER
			-- Output level.

	compile_eiffel: BOOLEAN
			-- Should generated eiffel code be compiled?

	compile_c: BOOLEAN
			-- Should generated c code be compiled?

	stop_on_error: BOOLEAN
			-- Should wizard stop on compilation error?

	new_project: BOOLEAN
			-- Is new project selected?

	not_spawn_ebench: BOOLEAN
			-- Shouldn't wizard spawn EiffelBench at the end?

feature -- Basic operations

	help is
			-- Display help.
		do
			io.put_string ("Usage:%N%T%
					%ecom_wizard [-help | %N%T%
					%-open projectname | %N%T%
					%-new_eiffel_project -epr eiffel_project_name %N%T%
					%-class classname -cluster clustername %N%T%
					%-ace acefile_name |%N%T%
					%-new_com_project -com_file comfilename | %N%T%
					%-destination destination_folder_name | %N%T%
					%-in_process | -server  [-automation | %N%T%
					%-universal | -proxy_stub proxy_stub_path] |%N%T%
					%-compile_c | -compile_eiffel | %N%T%
					%-stop_on_error | %N%T%
					%[-output_all | -output_warnings | -output_none ] %N%T%
					%-not_spawn_ebench] %N%
				%Options: %N%T%
					%-ace: specify the Ace file.%N%T%
					%-automation: Component should use automation.%N%T%
					%-class: Eiffel class name to generate IDL.%N%T%
					%-cluster: Cluster to which Eiffel class belongs.%N%T%
					%-com_file:  Path to COM definition file.%N%T%
					%-compile_c: Should com_wizard compile generated C code?%N%T%
					%-compile_eiffel: Should com_wizard compile generated Eiffel code?%N%T%
					%-destination: specify destination folder.%N%T%
					%-epr: Eiffel project containing Eiffel class.%N%T%
					%-help: show this help message.%N%T%
					%-in_process: In-process server?%N%T%
					%-new_com_project: New project from COM definition file.%N%T%
					%-new_eiffel_project: New project from Eiffel project.%N%T%
					%-not_spawn_ebench: Do not spawn EiffelBench at the end. %N%T%
					%-open: specify the project file to load. %N%T%
					%-output_all: Output everything.%N%T%
					%-output_warnings: Output warnings and errors.%N%T%
					%-output_none: No output.%N%T%
					%-proxy_stub: Component should use Proxy/Stub dll. %N%T%T%
						%Specify path to Proxy/Stub dll.%N%T%
					%-server: Create server.%N%T%
					%-stop_on_error: stop on error.%N%T%
					%-universal: Component should use universal marshaller.%N")
		end

	open_project (a_project: STRING) is
			-- Open previous project saved in `a_project'.
		local
			retried: BOOLEAN
			an_environment: WIZARD_ENVIRONMENT
			f: RAW_FILE
		do
			if not retried then
				create f.make (a_project)
				if f.exists then
					f.open_read
					an_environment ?= f.retrieved
					f.close
				end
				if an_environment /= Void then
					set_shared_wizard_environment (an_environment)
					message_output.add_message (Current, "Project Loaded.")
					project_retrieved := True
				else
					message_output.add_message (Current, "ERROR: File does not include a valid project description")
					project_retrieved := False
				end
			else
				message_output.add_message (Current, "ERROR: File does not include a valid project description")
				project_retrieved := False
			end
		rescue
			retried := True
			retry
		end
	
feature {NONE} -- Implementation

	run_wizard_manager is
			-- Run Code generation manager.
		local
			wizard_manager: WIZARD_MANAGER
		do
			create wizard_manager
			wizard_manager.run
			wizard_manager := Void
		end

	set_message_output_and_progress_report is
			-- Set message output and progress report.
		do
			set_message_output (create {WIZARD_MESSAGE_OUTPUT}.set_output 
					(create {WIZARD_OUTPUT_WINDOW_CMD}))
			set_progress_report (create {WIZARD_PROGRESS_REPORT_CMD})
		end

	project_retrieved: BOOLEAN	
			-- Was project correctly retrieved?
			
	

	idl_file_extension: STRING is ".idl"
			-- IDL file extension

	initialize_shared_wizard_environment is
			-- Set `shared_wizard_environment'.
		do
			if ace_file_name /= Void and then not ace_file_name.is_empty then
				shared_wizard_environment.set_ace_file_name (ace_file_name)
			end
			shared_wizard_environment.set_in_process_server (in_process_server)
			shared_wizard_environment.set_output_level (output_level)
			shared_wizard_environment.set_out_of_process_server (out_of_process_server)
			if eiffel_class_name /= Void and then not eiffel_class_name.is_empty then
				shared_wizard_environment.set_eiffel_class_name (eiffel_class_name)
			end
			if class_cluster_name /= Void and then not class_cluster_name.is_empty then
				shared_wizard_environment.set_class_cluster_name (class_cluster_name)
			end
			if eiffel_project_name /= Void and then not eiffel_project_name.is_empty then
				shared_wizard_environment.set_eiffel_project_name (eiffel_project_name)
			end
			if destination_folder /= Void and then not destination_folder.is_empty then
				shared_wizard_environment.set_destination_folder (destination_folder)
			end
			if project_name /= Void and then not project_name.is_empty then
				shared_wizard_environment.set_project_name (project_name)
			end
			if proxy_stub_file_name /= Void and then not proxy_stub_file_name.is_empty then
				shared_wizard_environment.set_proxy_stub_file_name (proxy_stub_file_name)
			end
			if idl_file_name /= Void and then not idl_file_name.is_empty then
				shared_wizard_environment.set_idl_file_name (idl_file_name)
			end
			if type_library_file_name /= Void and then not type_library_file_name.is_empty then
				shared_wizard_environment.set_type_library_file_name (type_library_file_name)
			end
			shared_wizard_environment.set_new_eiffel_project (is_new_eiffel_project)
			shared_wizard_environment.set_idl (idl)
			shared_wizard_environment.set_client_server (is_client,is_server)
			shared_wizard_environment.set_use_universal_marshaller (use_universal_marshaller)
			shared_wizard_environment.set_automation (automation)
			shared_wizard_environment.set_compile_eiffel (compile_eiffel)
			shared_wizard_environment.set_compile_c (compile_c)
			shared_wizard_environment.set_stop_on_error (stop_on_error)
			shared_wizard_environment.set_new_project (new_project)
			shared_wizard_environment.set_spawn_ebench (not_spawn_ebench)
		end
			
	wizard_environment_set: BOOLEAN is
			-- Does wizard environment set correctly?
		local
			a_folder: DIRECTORY
			a_file: RAW_FILE
		do
			if 
				shared_wizard_environment.destination_folder /= Void and then
				shared_wizard_environment.destination_folder.substring_index (":\", 1) = 2
			then
				create a_folder.make (destination_folder)
				if not a_folder.exists then
					a_folder.create_dir
				end
				Result := a_folder.exists
			end
			
			Result := Result and (shared_wizard_environment.server xor 
						shared_wizard_environment.client) and
						
						(not shared_wizard_environment.idl implies
						(shared_wizard_environment.type_library_file_name /= Void)) and
						
						(not shared_wizard_environment.compile_c implies 
						not shared_wizard_environment.compile_eiffel)
						
			if shared_wizard_environment.new_eiffel_project and
				(shared_wizard_environment.new_eiffel_project implies
				((shared_wizard_environment.eiffel_class_name /= Void) and 
				(shared_wizard_environment.class_cluster_name /= Void) and
				(shared_wizard_environment.eiffel_project_name /= Void) and
				(shared_wizard_environment.ace_file_name /= Void))) 
			then
				create a_file.make (shared_wizard_environment.eiffel_project_name)
				Result := Result and a_file.exists
				
				create a_file.make (shared_wizard_environment.ace_file_name)
				Result := Result and a_file.exists
			end
						
		end
	
end -- class ROOT_CLASS

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
