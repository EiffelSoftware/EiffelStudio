indexing
	description: "Code generation manager."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_MANAGER

inherit
	WIZARD_CLEANER	
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_SHARED_VISITOR_FACTORIES
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	WIZARD_RESCUABLE
		export
			{NONE} all
		end

	WIZARD_REJECTED_TYPE_LIBRARIES
		export
			{NONE} all
		end

	WIZARD_FILE_SYSTEM_MANAGEMENT
		export
			{NONE} all
		end

feature -- Access

	Idl_compilation_title: STRING is "IDL Compilation"
			-- IDL compilation title.
	
	Iid_compilation_title: STRING is "C Compilation step 1"
			-- Iid generated C file compilation title.
	
	Data_compilation_title: STRING is "C Compilation step 2"
			-- Inprocess dll generated C file compilation title.
	
	Ps_compilation_title: STRING is "C Compilation step 3"
			-- Proxy/stub generated C file compilation title.
	
	Link_title: STRING is "Creating Proxy Stub Dll"
			-- Link title.

	Analysis_title: STRING is "Analysing Type Library"
			-- Analysis title.

	Generation_title2: STRING is "Generating Code"
			-- Generation title.

feature -- Basic Operations

	run is
			-- Start generation.
		do		
			if shared_wizard_environment.abort then
				finish
			else
				message_output.initialize_log_file
				progress_report.set_title (Idl_compilation_title)
				progress_report.start
				-- Compile IDL
				if shared_wizard_environment.idl then
					if shared_wizard_environment.use_universal_marshaller then
						progress_report.set_range (1)
					else
						progress_report.set_range (5)
					end
					message_output.add_title (Current, Idl_compilation_title)
					compiler.compile_idl
					if not shared_wizard_environment.abort then
						progress_report.step
						-- Create Proxy/Stub
						if not shared_wizard_environment.use_universal_marshaller and Shared_wizard_environment.server then
							-- Compile c iid file
							message_output.add_title (Current, Iid_compilation_title)
							compiler.compile_iid
							if not shared_wizard_environment.abort then
								progress_report.step
								-- Compile c dlldata file
								message_output.add_title (Current, Data_compilation_title)
								compiler.compile_data
								if not shared_wizard_environment.abort then
									progress_report.step
									-- Compile c proxy/stub file
									message_output.add_title (Current, Ps_compilation_title)
									compiler.compile_ps
									if not shared_wizard_environment.abort then
										progress_report.step
										-- Final link
										message_output.add_title (Current, Link_title)
										compiler.link
										if not shared_wizard_environment.abort then
											progress_report.step
											generate
										end
									end
								end
							end
						else
							generate
						end
					end
				else
					generate
				end
				message_output.close_log_file
				if Shared_wizard_environment.abort then
					finish
				end
			end
		rescue
			if not failed_on_rescue then
				shared_wizard_environment.set_abort (Standard_abort_value)
				message_output.close_log_file
				retry
			end
		end

feature {NONE} -- Implementation

	generate is
			-- Generate Eiffel/C++ code.
		local
			i, a_range: INTEGER
			Clib_folder_name: STRING
			outproc_reg_gen: WIZARD_OUTPROC_EIFFEL_REGISTRATION_GENERATOR
			c_reg_gen: WIZARD_C_REGISTRATION_CODE_GENERATOR
		do
			-- Initialization
			message_output.add_title (Current, Analysis_title)
			set_system_descriptor (create {WIZARD_SYSTEM_DESCRIPTOR}.make)
			progress_report.set_range (0)
			progress_report.set_progress (0)
			intialize_file_directories

			-- Descriptors generation
			if directories_initialized then
				system_descriptor.generate (shared_wizard_environment.type_library_file_name)
			end
			
			-- Code generation
			if directories_initialized and not Shared_wizard_environment.abort then
				message_output.add_title (Current, Generation_title)
				from
					system_descriptor.start
				until
					system_descriptor.after or
					Shared_wizard_environment.abort
				loop
					if 
						not Non_generated_type_libraries.has (system_descriptor.library_descriptor_for_iteration.guid) 
					then
						a_range := a_range + system_descriptor.library_descriptor_for_iteration.descriptors.count
					end
					system_descriptor.forth
				end
				progress_report.set_range (a_range)
				from
					system_descriptor.start
					progress_report.start
					progress_report.set_title (Generation_title2)
				until
					system_descriptor.after or
					Shared_wizard_environment.abort
				loop
					if 
						not Non_generated_type_libraries.has (system_descriptor.library_descriptor_for_iteration.guid) 
					then
						from
							i := 1
						until
							i > system_descriptor.library_descriptor_for_iteration.descriptors.count or 
							Shared_wizard_environment.abort
						loop
							if system_descriptor.library_descriptor_for_iteration.descriptors.item (i) /= Void then
								if shared_wizard_environment.client then
									c_client_visitor.visit (system_descriptor.library_descriptor_for_iteration.descriptors.item (i))
									eiffel_client_visitor.visit (system_descriptor.library_descriptor_for_iteration.descriptors.item (i))
								end
								if shared_wizard_environment.server then
									c_server_visitor.visit (system_descriptor.library_descriptor_for_iteration.descriptors.item (i))
									eiffel_server_visitor.visit (system_descriptor.library_descriptor_for_iteration.descriptors.item (i))
								end
							end
							i := i + 1
							progress_report.step
						end	
					end
					system_descriptor.forth
				end

				-- Generating Implemented Interfaces
				if Shared_wizard_environment.abort then
					message_output.add_message (Current, Generation_Aborted)
				else
					from
						system_descriptor.interfaces.start
						a_range := 0
					until
						system_descriptor.interfaces.after or
						Shared_wizard_environment.abort
					loop
						a_range := a_range + 1
						system_descriptor.interfaces.forth
					end

					from
						system_descriptor.interfaces.start
						progress_report.start
						progress_report.set_title (Interface_generation_title)
						progress_report.set_range (a_range)
					until
						system_descriptor.interfaces.after
						or Shared_wizard_environment.abort
					loop
						if shared_wizard_environment.client then
							c_client_visitor.visit (system_descriptor.interfaces.item)
							eiffel_client_visitor.visit (system_descriptor.interfaces.item)
						end
						if shared_wizard_environment.server then
							c_server_visitor.visit (system_descriptor.interfaces.item)
							eiffel_server_visitor.visit (system_descriptor.interfaces.item)
						end

						system_descriptor.interfaces.forth
						progress_report.step
					end
				end

				-- Generating Registration code
				if Shared_wizard_environment.abort then
					message_output.add_message (Current, Generation_Aborted)
				elseif shared_wizard_environment.server then
					if shared_wizard_environment.out_of_process_server then
						create outproc_reg_gen
						outproc_reg_gen.generate
					end
					create c_reg_gen
					c_reg_gen.generate

--					from
--						system_descriptor.coclasses.start
--						progress_report.start
--						progress_report.set_title (Registration_code_generation_title)
--						progress_report.set_range (a_range)
--					until
--						system_descriptor.coclasses.after
--						or Shared_wizard_environment.abort
--					loop
--						
--						c_server_visitor.visit (system_descriptor.coclasses.item)
--						eiffel_server_visitor.visit (system_descriptor.coclasses.item)
--
--						system_descriptor.coclasses.forth
--						progress_report.step
--					end
				end

				if Shared_wizard_environment.abort then
					message_output.add_message (Current, Generation_Aborted)
				else

					-- Generating extra files
					if not shared_wizard_environment.abort then
						progress_report.start
						progress_report.set_title (Runtime_functions_generation)
						progress_report.set_range (8)
						Shared_file_name_factory.create_generated_mapper_file_name (Generated_ce_mapper_writer)
						progress_report.step
						Generated_ce_mapper_writer.save_file (Shared_file_name_factory.last_created_file_name)
						progress_report.step
						Generated_ce_mapper_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)	
						progress_report.step
						Shared_file_name_factory.create_generated_mapper_file_name (Generated_ec_mapper_writer)
						progress_report.step
						Generated_ec_mapper_writer.save_file (Shared_file_name_factory.last_created_file_name)
						progress_report.step
						Generated_ec_mapper_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
						progress_report.step
						Shared_file_name_factory.create_c_alias_file_name (Alias_c_writer)
						progress_report.step
						Alias_c_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
						progress_report.step
						message_output.add_warning (Current, Generation_Successful)
					end

					-- Compiling generated C code
					if Shared_wizard_environment.compile_c then
						message_output.add_title (Current, Compilation_title)
						change_working_directory (shared_wizard_environment.destination_folder)
						if shared_wizard_environment.client and not shared_wizard_environment.abort then
							Clib_folder_name := clone (Client)
							Clib_folder_name.append_character (Directory_separator)
							Clib_folder_name.append (Clib)
							progress_report.set_title (C_client_compilation_title)
							compiler.compile_folder (Clib_folder_name)
							compiler.link_all (Clib_folder_name, CLib_name)
						end
						if shared_wizard_environment.server and not shared_wizard_environment.abort then
							Clib_folder_name := clone (Server)
							Clib_folder_name.append_character (Directory_separator)
							Clib_folder_name.append (Clib)
							progress_report.set_title (C_server_compilation_title)
							compiler.compile_folder (Clib_folder_name)
							compiler.link_all (Clib_folder_name, CLib_name)
						end
						if not shared_wizard_environment.abort then
							Clib_folder_name := clone (Common)
							Clib_folder_name.append_character (Directory_separator)
							Clib_folder_name.append (Clib)
							progress_report.set_title (C_common_compilation_title)
							compiler.compile_folder (Clib_folder_name)
							compiler.link_all (Clib_folder_name, CLib_name)
						end
						if not Shared_wizard_environment.abort and Shared_wizard_environment.compile_eiffel then
							if Shared_wizard_environment.client then
								progress_report.set_title (Eiffel_compilation_title)
								compiler.compile_eiffel (Client)
							end
							if not Shared_wizard_environment.abort and Shared_wizard_environment.server then
								progress_report.set_title (Eiffel_compilation_title)
								compiler.compile_eiffel (Server)
							end
						end
						if not shared_wizard_environment.abort then		
							message_output.add_message (Current, Compilation_Successful)
						end
					end
				end
				clean_all
				progress_report.finish
			end
		end
	
	finish is
			-- Abort code generation.
		local
			a_string: STRING
		do
			inspect
				Shared_wizard_environment.return_code
			when Standard_abort_value then
				a_string := clone (Standard_failure_error_message)
			else
				a_string := clone (Failed_message)
				a_string.append_integer (Shared_wizard_environment.return_code)
			end
			message_output.add_error (Current, a_string)
			if progress_report.running then
				progress_report.finish
			end
		end

	compiler: WIZARD_COMPILER is
			-- IDL/C compiler.
		once
			create Result.make (message_output)
		end

	intialize_file_directories is
			-- Create generated files directories.
		local
			a_file: RAW_FILE
			a_path, a_path2: STRING
		do
			-- Initialize Common subdirectory
			a_path := clone (shared_wizard_environment.destination_folder)
			a_path.append (Common)
			initialize_directory (a_path)
			a_path.append_character (Directory_separator)
			a_path2 := clone (a_path)
			a_path2.append (Clib)
			initialize_directory (a_path2)
			a_path2 := clone (a_path)
			a_path2.append (Include)
			initialize_directory (a_path2)
			a_path2 := clone (a_path)
			a_path2.append (Interfaces)
			initialize_directory (a_path2)
			a_path2 := clone (a_path)
			a_path2.append (Structures)
			initialize_directory (a_path2)

			-- Initialize Client subdirectory
			if Shared_wizard_environment.client then
				a_path := clone (Shared_wizard_environment.destination_folder)
				a_path.append (Client)
				initialize_directory (a_path)
				a_path.append_character (Directory_separator)
				a_path2 := clone (a_path)
				a_path2.append (Clib)
				initialize_directory (a_path2)
				a_path2 := clone (a_path)
				a_path2.append (Include)
				initialize_directory (a_path2)
				a_path2 := clone (a_path)
				a_path2.append (Component)
				initialize_directory (a_path2)
			end
	
			-- Initialize Server subdirectory
			if Shared_wizard_environment.server then
				a_path := clone (Shared_wizard_environment.destination_folder)
				a_path.append (Server)
				initialize_directory (a_path)
				a_path.append_character (Directory_separator)
				a_path2 := clone (a_path)
				a_path2.append (Clib)
				initialize_directory (a_path2)
				a_path2 := clone (a_path)
				a_path2.append (Include)
				initialize_directory (a_path2)
				a_path2 := clone (a_path)
				a_path2.append (Component)
				initialize_directory (a_path2)
			end
		end

	initialize_directory (a_path: STRING) is
			-- Create directory `a_path' if does not exist.
		require
			-- is_directory (a_path)
			-- only last directory in path is not created
		local
			a_file: RAW_FILE
			a_string: STRING
			a_directory: DIRECTORY
		do
			directories_initialized := True
			create a_file.make (a_path)
			if a_file.exists then
				if not a_file.is_directory then
					a_string := clone (message_output.File_already_exists)
					a_string.append (Colon)
					a_string.append (Space)
					a_string.append (a_path)
					message_output.add_warning (Current, a_string)
					message_output.add_message (Current, message_output.File_backed_up)
					a_string := clone (a_path)
					a_string.append (Backup_file_extension)
					file_copy (a_path, a_string)
					file_delete (a_path)
					create a_directory.make (a_path)
					check
						not_exists: not a_directory.exists
					end
					a_directory.create_dir
				end
			else
				create a_directory.make (a_path)
				check
					not_exists: not a_directory.exists
				end
				a_directory.create_dir
			end
		end
					
	directories_initialized: BOOLEAN
			-- Were directories correctly initialized?

	Failed_message: STRING is "Failed with return code "
			-- Failure message.
	
	Standard_failure_error_message: STRING is "Failed"
			-- Generic failure message.

	Generation_title: STRING is "Generating code"
			-- Generation message.
	
	Compilation_title: STRING is "Compiling generated code"
			-- Compilation message.

	C_client_compilation_title: STRING is "Compiling generated C client code"
			-- C compilation message.

	C_common_compilation_title: STRING is "Compiling generated C common code"
			-- C compilation message.

	C_server_compilation_title: STRING is "Compiling generated C server code"
			-- C compilation message.

	Interface_generation_title: STRING is "Generating implemented interfaces"
			-- Interface generation message.

	Registration_code_generation_title: STRING is "Generating registration code"
			-- Registration code generation message.

	Runtime_functions_generation: STRING is "Generating Runtime functions"
			-- Runtime functions generation.

	Compilation_successful: STRING is "Compilation completed."
			-- Compilation successful message.

	Eiffel_compilation_title: STRING is "Compiling Eiffel code"
			-- Eiffel compilation message.

end -- class WIZARD_MANAGER

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
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
