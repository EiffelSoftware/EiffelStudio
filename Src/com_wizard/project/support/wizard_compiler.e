class
	WIZARD_COMPILER

inherit
	WIZARD_C_COMPILER

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_PROCESS_LAUNCHER
		rename
			message_output as process_launcher_message_output
		export
			{NONE} all
		end

	WIZARD_ROUTINES
		export
			{NONE} all
		end

create
	make

feature -- Access

	eiffel_compilation_successful (a_folder: STRING): BOOLEAN is
			-- Was Eiffel precompilation in `a_folder' successful?
		require
			non_void_folder: a_folder /= Void
			valid_folder: not a_folder.empty
		local
			a_directory: DIRECTORY
			a_local_folder: STRING
			a_file_list: LIST [STRING]
		do
			a_local_folder := clone (a_folder)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append (Eifgen)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append (W_code)
			create a_directory.make (a_local_folder)
			if a_directory.exists then
				from
					a_file_list := a_directory.linear_representation
					a_file_list.start
				until
					a_file_list.after or Result
				loop
					Result := (a_file_list.item.substring (a_file_list.item.count + 1 - Eiffel_project_extension.count, a_file_list.item.count)).is_equal (Eiffel_project_extension)
					a_file_list.forth
				end
			end
		end

feature -- Basic Operations

	compile_idl is
			-- Compile idl file pointed by `idl_file_name'.
			-- Set `shared_wizard_environment.type_library_file_name' with
			-- resulting type library file name.
		local
			a_string: STRING
			intt: INTEGER
		do
			a_string := clone (Idl_compiler)
			a_string.append (Space)
			a_string.append (Idl_compiler_command_line)
			message_output.add_message (Current, a_string)
			a_string := clone (Shared_wizard_environment.destination_folder)
			a_string.append (clone (shared_wizard_environment.project_name))
			a_string.append (".tlb")
			shared_wizard_environment.set_type_library_file_name (a_string)
			change_working_directory (Shared_wizard_environment.destination_folder)
			generate_make_file (Idl_compiler_command_line, Temporary_input_file_name)
			a_string := clone (Idl_compiler)
			a_string.append (clone (Space))
			a_string.append (last_make_command)
			launch (a_string, Shared_wizard_environment.destination_folder)
			check_return_code
		end

	compile_iid is
			-- Compile iid C file.
		do
			compile_file (Generated_iid_file_name)
		end
	
	compile_ps is
			-- Compile proxy/stub C file.
		do
			compile_file (Generated_ps_file_name)
		end

	compile_data is
			-- Compile dlldata C file.
		do
			compile_file (Generated_dlldata_file_name)
		end
	
	link is
			-- Create proxy/stub dll.
		local
			a_string: STRING
		do
			generate_def_file
			a_string := clone (linker)
			a_string.append (Space)
			a_string.append (Linker_command_line)
			message_output.add_message (Current, a_string)
			generate_make_file (Linker_command_line, Temporary_input_file_name)
			a_string := clone (Linker)
			a_string.append (Space)
			a_string.append (last_make_command)
			launch (a_string, shared_wizard_environment.destination_folder)
			check_return_code
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append (clone (shared_wizard_environment.project_name))
			a_string.append (Dll_file_extension)
			shared_wizard_environment.set_proxy_stub_file_name (a_string)
		end

	compile_eiffel (a_folder: STRING) is
			-- Compile Eiffel code in `a_folder'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.is_equal (Client) or a_folder.is_equal (Server)
		local
			displayed: BOOLEAN
			a_directory: DIRECTORY
			a_local_folder: STRING
		do
			a_local_folder := clone (a_folder)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append (Eifgen)
			create a_directory.make (a_local_folder)
			if a_directory.exists then
				a_directory.recursive_delete
			end
			generate_ace_file (a_folder)
			displayed := displayed_while_running
			set_displayed_while_running (True)
			if a_folder.is_equal (Client) then
				launch (precompile_command, a_folder)
			else
				launch (eiffel_compile_command, a_folder)
			end
			if eiffel_compilation_successful (a_folder) then
				launch (finish_freezing_command, a_folder)
				check_finish_freezing_status (a_folder)
			else
				shared_wizard_environment.set_abort (Eiffel_compilation_error)
			end		
			set_displayed_while_running (displayed)				
		end

	check_finish_freezing_status (a_folder: STRING) is
			-- Check whether finish_freezing was successful in `a_folder\EIFGEN\W_code'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: not a_folder.empty
		local
			a_directory: DIRECTORY
			a_local_folder: STRING
		do
			a_local_folder := clone (a_folder)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append (Eifgen)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append (W_code)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append (Msc)
			a_directory.make (a_local_folder)
			if a_directory.exists and then a_directory.has_entry (Driver_executable) and then Shared_wizard_environment.stop_on_error then
				shared_wizard_environment.set_abort (Eiffel_compilation_error)
			end
		end

feature {NONE} -- Implementation

	Proxy_stub_file_name: STRING is
			-- Proxy/Stub fil name
		once
			Result := clone (shared_wizard_environment.destination_folder)
			Result.append_character (Directory_separator)
			Result.append (shared_wizard_environment.project_name)
			Result.append ("_ps.dll")
		end

	generate_def_file is
			-- Generate standard COM def file in current folder.
		local
			a_file: RAW_FILE
		do
			change_working_directory (shared_wizard_environment.destination_folder)
			create a_file.make (Def_file_name)
			if not a_file.exists then
				a_file.make_create_read_write (Def_file_name)
				a_file.put_string ("DESCRIPTION %"EiffelCOM Generated Component%"%N")
				a_file.put_string ("EXPORTS%N")
				a_file.put_string ("%TDllGetClassObject%T%T@1 PRIVATE%N")
				a_file.put_string ("%TDllCanUnloadNow%T%T%T@2 PRIVATE%N")
				a_file.put_string ("%TDllRegisterServer%T%T@3 PRIVATE%N")
				a_file.put_string ("%TDllUnregisterServer%T@4 PRIVATE%N")
				a_file.close
			end
		end

	generate_ace_file (a_folder: STRING) is
			-- Generate server ace file in `a_folder'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.is_equal (Client) or a_folder.is_equal (Server)
		local
			a_string: STRING
			a_file: RAW_FILE
		do
			a_string := clone (a_folder)
			a_string.append_character (Directory_separator)
			a_string.append (Ace_file_name)
			create a_file.make_create_read_write (a_string)
			if a_folder.is_equal (Server) then
				a_file.put_string (server_generated_ace_file)
			else
				a_file.put_string (client_generated_ace_file)
			end
			a_file.put_string (Tab)
			a_file.put_string (Tab)
			a_file.put_string (Tab)
			a_file.put_string (Tab)
			a_file.put_string (Double_quote)
			a_file.put_string (Shared_wizard_environment.destination_folder)
			a_file.put_character (Directory_separator)
			a_file.put_string (a_folder)
			a_file.put_character (Directory_separator)
			a_file.put_string (Clib)
			a_file.put_character (Directory_separator)
			a_file.put_string (Clib_name)
			a_file.put_string (Lib_file_extension)
			a_file.put_string (Double_quote)
			a_file.put_string (Semicolon)
			a_file.put_string (New_line)
			a_file.put_string (End_keyword)
			a_file.close
		end

	server_generated_ace_file: STRING is
			-- Beginning of server generated Ace file
		do
			Result := client_generated_ace_file
			Result.replace_substring_all (Any_type, Shared_wizard_environment.project_name)
		end

	client_generated_ace_file: STRING is
			-- Common part in Ace file for both server and client.
		do
			Result := clone (System_keyword)
			Result.append (New_line_tab)
			Result.append (Shared_wizard_environment.project_name)
			Result.append (New_line)
			Result.append (Partial_ace_file)
			Result.append (Tab)
			Result.append (Tab)
			Result.append (Tab)
			Result.append (Tab)
			Result.append (Double_quote)
			Result.append (clone (Shared_wizard_environment.destination_folder))
			Result.append (Client)
			Result.append_character (Directory_separator)
			Result.append (Include)
			Result.append (Double_quote)
			Result.append (Comma)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)
			Result.append (Double_quote)
			Result.append (clone (Shared_wizard_environment.destination_folder))
			Result.append (Common)
			Result.append_character (Directory_separator)
			Result.append (Include)
			Result.append (Double_quote)
			Result.append (Comma)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)
			Result.append (Double_quote)
			Result.append (clone (Shared_wizard_environment.destination_folder))
			Result.append (Server)
			Result.append_character (Directory_separator)
			Result.append (Include)
			Result.append (Double_quote)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line)
			Result.append (End_ace_file)
		end
			
	Idl_compiler_command_line: STRING is
			-- MIDL command line
		do
			Result := clone (Common_idl_compiler_options)
			Result.append ("  /out %"")
			Result.append (clone (shared_wizard_environment.destination_folder))
			Result.append_character (Directory_separator)
			Result.append ("%" /h %"")
			Result.append (Generated_header_file_name)
			Result.append ("%" /dlldata %"")
			Result.append (Generated_dlldata_file_name)
			Result.append ("%" /iid %"")
			Result.append (Generated_iid_file_name)
			Result.append ("%" /proxy %"")
			Result.append (Generated_ps_file_name)
			Result.append ("%" /tlb %"")
			Result.append (clone (shared_wizard_environment.project_name))
			Result.append (".tlb%" ")
			if Shared_wizard_environment.output_level = message_output.Output_none then
				Result.append (" /nologo ")
			end
			Result.append (shared_wizard_environment.idl_file_name)
		end

	Linker_command_line: STRING is
			-- Link command line
		local
			a_string: STRING
		do
			Result := clone (Common_linker_options)
			if Shared_wizard_environment.output_level = message_output.Output_none then
				Result.append (" /nologo ")
			end
			Result.append (" /out:")
			Result.append ("%"")
			Result.append (Proxy_stub_file_name)
			Result.append ("%"")
			Result.append (" /def:")
			Result.append ("%"")
			Result.append (clone (Def_file_name))
			Result.append ("%"")
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append (c_to_obj (Generated_iid_file_name))
			Result.append (" ")
			Result.append ("%"")
			Result.append (a_string)
			Result.append ("%"")
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append_character (Directory_separator)
			a_string.append (c_to_obj (Generated_ps_file_name))
			Result.append (" ")
			Result.append ("%"")
			Result.append (a_string)
			Result.append ("%"")
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append (c_to_obj (Generated_dlldata_file_name))
			Result.append (" ")
			Result.append ("%"")
			Result.append (a_string)
			Result.append ("%" ")
			Result.append (Rpc_library)
		end

	precompile_command: STRING is
			-- Eiffel compiler command line to precompile
		do
			Result := "es4 -precompile -batch -ace "
			Result.append (Ace_file_name)
		end

	eiffel_compile_command: STRING is
			-- Eiffel compiler command line to freeze
		do
			Result := "es4 -freeze -batch -ace "
			Result.append (Ace_file_name)
		end
			
	Ace_file_name: STRING is "Ace.ace"
			-- Ace file name

	Eiffel_project_extension: STRING is ".epr"
			-- Eiffel project extension

	Finish_freezing_command: STRING is "finish_freezing -silent"
			-- Finish freezing command line

	Partial_ace_file: STRING is
			-- Ace file used to precompile generated Eiffel system
		"root%N%
		%	ANY%N%N%
		%default%N%
		%	assertion (all)%N%
		%	multithreaded (no)%N%
		%	console_application (no)%N%
		%	dynamic_runtime (no)%N%
		%	dead_code_removal (yes)%N%
		%	profile (no)%N%
		%	line_generation (no)%N%
		%	debug  (no)%N%
		%	array_optimization (no)%N%
		%	inlining (no)%N%
		%	inlining_size (%"4%")%N%N%
		%cluster%N%
		%	root_cluster: %".%";%N%T%
		%	server (root_cluster):				%"$\component%"%N%T%T%
		%		-- EiffelBase%N%T%
		%	all base:						%"$EIFFEL4\library\base%"%N%T%T%
		%		exclude%N%T%T%T%
		%			%"table_eiffel3%"%N%T%T%
		%		end%N%N%T%
		%		visible%N%
		%			INTEGER_REF;%N%
		%			CHARACTER_REF;%N%
		%			BOOLEAN_REF;%N%
		%			REAL_REF;%N%
		%			DOUBLE_REF;%N%
		%			CELL;%N%
		%			STRING;%N%
		%		end%N%N%
		%	-- WEL%N%T%
		%	all wel:						%"$EIFFEL4\library\wel%"%N%N%T%
		%	all time: 						%"$EIFFEL4\library\time%"%N%T%T%
		%		exclude%N%T%T%T%
		%			%"french%";%N%T%T%
		%			%"german%"%N%T%T%
		%		end;%N%N%T%
		%	-- EiffelCOM%N%T%
		%	all ecom:						%"$EIFFEL4\library\com%"%N%T%
		%	all common:						%"..\common%"%N%N%
		%external%N%
		%	include_path:	%"$EIFFEL4\library\wel\spec\windows\include%",%N%
		%					%"$EIFFEL4\library\com\library\include%",%N%
		%					%"$EIFFEL4\library\com\runtime\include%",%N"

	End_ace_file: STRING is
			-- End of ace file used to precompile generated Eiffel system
		"	object: 	%"$(EIFFEL4)\library\wel\spec\$(COMPILER)\lib\wel.lib%",%N%
		%				%"$(EIFFEL4)\library\time\spec\msc\lib\datetime.lib%",%N%
		%				%"$(EIFFEL4)\library\com\spec\msc\lib\com.lib%",%N%
		%				%"$(EIFFEL4)\library\com\spec\msc\lib\com_runtime.lib%",%N"

	Eifgen: STRING is "EIFGEN"
			-- Eifgen folder name

	W_code: STRING is "W_code"
			-- W_code folder name

	Msc: STRING is "msc"
			-- precompilation driver.exe folder name

	Driver_executable: STRING is "driver.exe"
			-- Precompilation driver executable

end -- class WIZARD_IDL_COMPILER
