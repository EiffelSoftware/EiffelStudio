class
	WIZARD_COMPILER

inherit
	WIZARD_C_COMPILER

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

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

	WIZARD_RESCUABLE
		export
			{NONE} all
		end
	
	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	WIZARD_FILE_SYSTEM_MANAGEMENT
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
			a_local_folder := clone (Shared_wizard_environment.destination_folder)
			a_local_folder.append (a_folder)
			-- The ".epr" file is in the Eifgen folder for a precompiled system
			if a_folder.is_equal (Client) then
				a_local_folder.append_character (Directory_separator)
				a_local_folder.append (Eifgen)
			end
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

	ace_file_generated: BOOLEAN
			-- Was generated project ace file generated?

	resource_file_generated: BOOLEAN
			-- Was generated project resource file generated?

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
			shared_wizard_environment.set_proxy_stub_file_name (proxy_stub_file_name)
		end

	compile_eiffel (a_folder: STRING) is
			-- Compile Eiffel code in `a_folder'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.is_equal (Client) or a_folder.is_equal (Server)
			ace_file_generated: ace_file_generated
			resource_file_generated: resource_file_generated			
		local
			displayed: BOOLEAN
			a_directory: DIRECTORY
			a_local_folder: STRING
			a_project_file, a_dest_file: STRING
		do
			a_local_folder := clone (a_folder)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append (Eifgen)
			create a_directory.make (a_local_folder)
			if a_directory.exists then
				a_directory.recursive_delete
			end
			displayed := displayed_while_running
			set_displayed_while_running (True)
			if a_folder.is_equal (Client) then
				launch (precompile_command, a_folder)
			else
				launch (eiffel_compile_command, a_folder)
			end
			if eiffel_compilation_successful (a_folder) then
				a_local_folder := clone (a_folder)
				a_local_folder.append_character (Directory_separator)
				a_local_folder.append (Eifgen)
				a_local_folder.append_character (Directory_separator)
				a_local_folder.append (W_code)
				launch (finish_freezing_command, a_local_folder)
				check_finish_freezing_status (a_folder)
				if not Shared_wizard_environment.abort then
					if a_folder.is_equal (Client) then
						a_dest_file := clone (a_folder)
						a_dest_file.append_character (Directory_separator)
						a_project_file := clone (a_dest_file)
						a_dest_file.append (Precompile_name)
						a_project_file.append (Eifgen)
						a_project_file.append_character (Directory_separator)
						a_project_file.append (Precompile_name)
						file_copy (a_project_file, a_dest_file)
					end
					spawn (eiffel_bench_command (a_folder), a_local_folder)
				end
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
			a_file_list: LIST [STRING]
			found: BOOLEAN
		do
			a_local_folder := clone (a_folder)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append (Eifgen)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append (W_code)
			if a_folder.is_equal (Client) then
				a_local_folder.append_character (Directory_separator)
				a_local_folder.append (Msc)
			end
			create a_directory.make (a_local_folder)
			if a_directory.exists then
				from
					a_file_list := a_directory.linear_representation
					a_file_list.start
				until
					a_file_list.after or found
				loop
					found := (a_file_list.item.substring (a_file_list.item.count + 1 - Executable_extension.count, a_file_list.item.count)).is_equal (Executable_extension)
					a_file_list.forth
				end
			end
			if not found then
				Shared_wizard_environment.set_abort (Eiffel_compilation_error)
			end
		end

	generate_ace_file (a_folder: STRING) is
			-- Generate server ace file in `a_folder'.
			-- Delete EIFGEN is already existing.
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
			a_file.put_string (Double_quote)
			a_file.put_string (Shared_wizard_environment.destination_folder)
			a_file.put_string (a_folder)
			a_file.put_character (Directory_separator)
			a_file.put_string (Clib)
			a_file.put_character (Directory_separator)
			a_file.put_string (Clib_name)
			a_file.put_string (Lib_file_extension)
			a_file.put_string (Double_quote)
			a_file.put_string (Comma)
			a_file.put_string (New_line)
			a_file.put_string (Tab)
			a_file.put_string (Tab)
			a_file.put_string (Tab)
			a_file.put_string (Double_quote)
			a_file.put_string (Shared_wizard_environment.destination_folder)
			a_file.put_string (Common)
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
			ace_file_generated := True
		end

	generate_resource_file (a_folder: STRING) is
			-- Generate resource file in `a_folder'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.is_equal (Client) or a_folder.is_equal (Server)
		local
			a_string: STRING
			a_file: RAW_FILE
		do
			a_string := clone (a_folder)
			a_string.append_character (Directory_separator)
			a_string.append (Resource_file_name)
			create a_file.make_create_read_write (a_string)
			a_file.put_string (generated_resource_file)
			a_file.close
			resource_file_generated := True
		end

	register_ps is
			-- Register generated proxy stub.
		local
			a_string: STRING
		do
			a_string := "regsvr32 /s "
			a_string.append (Shared_wizard_environment.proxy_stub_file_name)
			launch (a_string, Shared_wizard_environment.destination_folder)
		end

feature {NONE} -- Implementation

	proxy_stub_file_name: STRING is
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

	server_generated_ace_file: STRING is
			-- Beginning of server generated Ace file
		local
			tmp_string: STRING
		do
			Result := client_generated_ace_file
			tmp_string := clone (Registration_class_name)
			tmp_string.append (Colon)
			tmp_string.append (Space)
			tmp_string.append (double_quote)
			tmp_string.append (Registration_class_creation_routine)
			tmp_string.append (Double_quote)

			Result.replace_substring_all (Any_type, tmp_string)
			if Shared_wizard_environment.in_process_server then
				Result.replace_substring_all (Default_keyword, Shared_library_option)
			end
			Result.replace_substring_all (Client, Server)
		end

	client_generated_ace_file: STRING is
			-- Common part in Ace file for both server and client.
		do
			Result := clone (System_keyword)
			Result.append (New_line_tab)
			Result.append (Shared_wizard_environment.project_name)
			if Shared_wizard_environment.client then
				Result.append ("_client")
			end
			Result.append (New_line)
			Result.append (Partial_ace_file)
			Result.append (Shared_wizard_environment.destination_folder)
			Result.append (Client)
			Result.append (Double_quote)
			Result.append (New_line_tab_tab)
			Result.append (Visible)
			Result.append (New_line_tab_tab_tab)

			if Shared_wizard_environment.server then
				Result.append (Registration_class_name)
				Result.append (Semicolon)
				Result.append (New_line)
			end
			from
				system_descriptor.visible_classes.start
			until
				system_descriptor.visible_classes.after
			loop
				Result.append (system_descriptor.visible_classes.item.generated_code)
				system_descriptor.visible_classes.forth
			end
			Result.append (New_line_tab_tab)
			Result.append (End_keyword)
			Result.append (New_line)
			Result.append (New_line_tab)
			Result.append (Common_cluster)
			Result.append (Colon)
			Result.append (Tab)
			Result.append (Tab)
			Result.append (Tab)
			Result.append (Tab)
			Result.append (Tab)
			Result.append (Tab)
			Result.append (Double_quote)
			Result.append (Shared_wizard_environment.destination_folder)
			Result.append (Common)
			Result.append (Double_quote)
			Result.append (New_line)
			Result.append (New_line)
			Result.append (Partial_ace_file_part_two)
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
			Result.append (New_line_tab_tab)
			Result.append (Tab)
			Result.append (Double_quote)
			Result.append (clone (Shared_wizard_environment.destination_folder))
			Result.append (Common)
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
			Result := "es4 -batch -ace "
			Result.append (Ace_file_name)
		end

	eiffel_bench_command (a_folder: STRING): STRING is
			-- Launch EiffelBench with first project in `a_folder'
		require
			non_void_folder: a_folder /= Void
			valid_folder: not a_folder.empty
			--contains_eiffel_project: a_folder has one and only one '.epr' file.
		local
			a_directory: DIRECTORY
			a_file_list: LIST [STRING]
			found: BOOLEAN
		do
			Result := "ebench "
			Result.append (Shared_wizard_environment.destination_folder)
			Result.append (a_folder)
			Result.append_character (Directory_separator)
			create a_directory.make (a_folder)
			if a_directory.exists then
				from
					a_file_list := a_directory.linear_representation
					a_file_list.start
				until
					a_file_list.after or found
				loop
					found := a_file_list.item.substring (a_file_list.item.count + 1 - Eiffel_project_extension.count, a_file_list.item.count).is_equal (Eiffel_project_extension)
					if found then
						Result.append (a_file_list.item)
					end
					a_file_list.forth
				end
			end
		end
			
	user_def_file_name: STRING is
			-- ".def" file name used for DLL compilation
		do
			Result := clone (Shared_wizard_environment.project_name)
			Result.append (Def_file_extension)
		end
	
	Def_file_extension: STRING is ".def"
			-- DLL definition file extension

	Executable_extension: STRING is ".exe"
			-- Executable file extension

	Ace_file_name: STRING is "Ace.ace"
			-- Ace file name

	Eiffel_project_extension: STRING is ".epr"
			-- Eiffel project extension

	Precompile_name: STRING is "precomp.epr"
			-- Precompilation project name

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
		%	all component: %""
	
	Common_cluster: STRING is "all common"
			-- Common cluster

	Partial_ace_file_part_two: STRING is
			-- Ace file used to precompile generated Eiffel system
		"	-- BASE%N%
		%	all base:						%"$EIFFEL4\library\base%"%N%
		%		exclude%N%
		%			%"table_eiffel3%";%N%
		%			%"desc%"%N%
		%		visible%N%
		%			INTEGER_REF;%N%
		%			CHARACTER_REF;%N%
		%			BOOLEAN_REF;%N%
		%			REAL_REF;%N%
		%			DOUBLE_REF;%N%
		%			CELL;%N%
		%			STRING;%N%
		%			ARRAY;%N%
		%		end;%N%N%
		%	-- WEL%N%
		%	all wel:						%"$EIFFEL4\library\wel%"%N%N%
		%	-- TIME%N%
		%	all time: 						%"$EIFFEL4\library\time%"%N%
		%		exclude%N%
		%			%"french%";%N%
		%			%"german%"%N%
		%		visible%N%
		%			DATE_TIME;%N%
		%		end;%N%N%
		%	-- COM%N%
		%	all ecom:						%"$EIFFEL4\library\com%"%N%
		%		visible%N%
		%			ECOM_CURRENCY;%N%
		%			ECOM_ARRAY;%N%
		%			ECOM_VARIANT;%N%
		%			ECOM_GUID;%N%
		%			ECOM_EXCEP_INFO;%N%
		%			ECOM_DISP_PARAMS;%N%
		%			ECOM_STATSTG;%N%
		%			ECOM_STREAM;%N%
		%			ECOM_STORAGE;%N%
		%			ECOM_ROOT_STORAGE;%N%
		%			ECOM_ENUM_STATSTG;%N%
		%			ECOM_HRESULT;%N%
		%			ECOM_WIDE_STRING;%N%
		%			ECOM_LARGE_INTEGER;%N%
		%			ECOM_ULARGE_INTEGER;%N%
		%			ECOM_UNKNOWN_INTERFACE;%N%
		%			ECOM_AUTOMATION_INTERFACE;%N%
		%		end;%N%N%
		%external%N%
		%	include_path:	%"$EIFFEL4\library\wel\spec\windows\include%",%N%
		%			%"$EIFFEL4\library\com\spec\windows\include%",%N"

	End_ace_file: STRING is
			-- End of ace file used to precompile generated Eiffel system
		"	object: 	%"$(EIFFEL4)\library\wel\spec\$(COMPILER)\lib\wel.lib%",%N%
		%			%"$(EIFFEL4)\library\time\spec\msc\lib\datetime.lib%",%N%
		%			%"$(EIFFEL4)\library\com\spec\msc\lib\com.lib%",%N%
		%			%"$(EIFFEL4)\library\com\spec\msc\lib\com_runtime.lib%",%N"

	Eifgen: STRING is "EIFGEN"
			-- Eifgen folder name

	W_code: STRING is "W_code"
			-- W_code folder name

	Msc: STRING is "msc"
			-- precompilation driver.exe folder name

	Driver_executable: STRING is "driver.exe"
			-- Precompilation driver executable

	Default_keyword: STRING is "default"
			-- Lace `default' keyword
	
	Shared_library_option: STRING is
			-- Dll definition file for Ace file
		do
			Result := "default%N%Tshared_library_definition (%""
			Result.append (User_def_file_name)
			Result.append ("%")")
		end

	Stdcall: STRING is "__stdcall"
			-- Dll function calling convention

	Call_type: STRING is "call_type"
			-- DLL Defintion type call_type option

	Visible: STRING is "visible"
			-- Lace `visible' keyword

	Generated_resource_file: STRING is 
			-- Resource file content
		local
			str_buffer: STRING
		do
			Result := "1 typelib "
			Result.append (Double_quote)
			str_buffer := clone (Shared_wizard_environment.type_library_file_name)
			str_buffer.replace_substring_all ("%H", "%H%H")

			Result.append (str_buffer)
			Result.append (Double_quote)
		end

	Resource_file_name: STRING is
			-- Resource file name
		do
			Result := clone (Shared_wizard_environment.project_name)
			Result.append (Resource_file_extension)
		end

	Resource_file_extension: STRING is ".rc"
			-- Resource file extension

end -- class WIZARD_IDL_COMPILER
