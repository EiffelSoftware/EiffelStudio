indexing
	description: "Code generation manager."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_MANAGER

inherit
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

	WIZARD_MESSAGE_OUTPUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: like parent) is
			-- Initialize manager.
		require
			non_void_parent: a_parent /= Void
		do
			set_output_window (a_parent)
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

feature -- Access

	parent: MAIN_WINDOW
			-- Parent window used to parent.add_title messages

	Idl_compilation_title: STRING is "IDL Compilation"
			-- IDL compilation title
	
	Iid_compilation_title: STRING is "C Compilation Step 1"
			-- Iid generated C file compilation title
	
	Data_compilation_title: STRING is "C Compilation Step 2"
			-- Inprocess dll generated C file compilation title
	
	Ps_compilation_title: STRING is "C Compilation Step 3"
			-- Proxy/stub generated C file compilation title
	
	Link_title: STRING is "Creating Proxy Stub Dll"
			-- Link title

	Analysis_title: STRING is "Analysing Type Library"
			-- Analysis title

	Generation_title: STRING is "Generating Code"
			-- Generation title

feature -- Basic Operations

	run is
			-- Start generation.
		do
			initialize_log_file

			-- Compile IDL
			if shared_wizard_environment.abort then
				finish
			elseif shared_wizard_environment.idl then
				parent.add_title (Idl_compilation_title)
				Idl_compiler.compile_idl
				if shared_wizard_environment.abort then
					finish
				else
					-- Create Proxy/Stub
					if not shared_wizard_environment.use_universal_marshaller then
						-- Compile c iid file
						parent.add_title (Iid_compilation_title)
						Idl_compiler.compile_iid
						if shared_wizard_environment.abort then
							finish
						else
							-- Compile c dlldata file
							parent.add_title (Data_compilation_title)
							Idl_compiler.compile_data
							if shared_wizard_environment.abort then
								finish
							else
								-- Compile c proxy/stub file
								parent.add_title (Ps_compilation_title)
								Idl_compiler.compile_ps
								if shared_wizard_environment.abort then
									finish
								else
									-- Final link
									parent.add_title (Link_title)
									Idl_compiler.link
									if shared_wizard_environment.abort then
										finish
									else
										generate
									end
								end
							end
						end
					end
				end
			else
				generate
			end
			close_log_file
		rescue
			shared_wizard_environment.set_abort (10)
			close_log_file
			retry
		end

feature {NONE} -- Implementation

	generate is
			-- Generate Eiffel/C++ code.
		local
			i: INTEGER
		do
			parent.add_title (Analysis_title)
			set_system_descriptor (create {WIZARD_SYSTEM_DESCRIPTOR}.make)
			system_descriptor.generate (shared_wizard_environment.type_library_file_name)

			intialize_file_directories
			if directories_initialized then
				parent.add_title (Generation_title)
				from
					system_descriptor.start
				until
					system_descriptor.after
				loop
					from
						i := 1
					until
						i > system_descriptor.library_descriptor_for_iteration.descriptors.count
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
					end	
					system_descriptor.forth
				end
			end
		end
		
	finish is
			-- Abort code generation.
		local
			a_string: STRING
		do
			a_string := clone (Failed_message)
			a_string.append_integer (shared_wizard_environment.return_code)
			parent.add_error (a_string)
		end

	Idl_compiler: WIZARD_IDL_COMPILER is
			-- IDL compiler
		once
			create Result.make (parent)
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
			
			-- Initialize Server subdirectory
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
					a_string := clone (File_already_exists)
					a_string.append (Colon)
					a_string.append (Space)
					a_string.append (a_path)
					add_warning (Current, a_string)
					add_message (Current, File_backed_up)
					a_string := clone (Copy_command)
					a_string.append (Space)
					a_string.append (a_path)
					a_string.append (Space)
					a_string.append (a_path)
					a_string.append (Backup_file_extension)
					Shared_process_launcher.launch (a_string, Void)
					if not (Shared_process_launcher.last_launch_successful and Shared_process_launcher.last_process_result = 0) then
						a_string := clone (Could_not_copy_file)
						a_string.append (Colon)
						a_string.append (Space)
						a_string.append (a_path)
						directories_initialized := False
						add_error (Current, a_string)
					else
						a_string := clone (Delete_command)
						a_string.append (Space)
						a_string.append (a_path)
						Shared_process_launcher.launch (a_string, Void)
						if not (Shared_process_launcher.last_launch_successful and Shared_process_launcher.last_process_result = 0) then
							a_string := clone (Could_not_delete_file)
							a_string.append (Colon)
							a_string.append (Space)
							a_string.append (a_path)
							directories_initialized := False
							add_error (Current, a_string)
						else
							create a_directory.make (a_path)
							check
								not_exists: not a_directory.exists
							end
							a_directory.create_dir
						end
					end
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
			-- Failure message
			
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
