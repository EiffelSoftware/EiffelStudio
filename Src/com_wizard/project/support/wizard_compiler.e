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
			valid_folder: not a_folder.empty
		local
			displayed: BOOLEAN
		do
			generate_ace_file (a_folder)
			displayed := displayed_while_running
			set_displayed_while_running (True)
			launch (eiffel_command, a_folder)
			set_displayed_while_running (displayed)
			check_return_code
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
		local
			a_file: RAW_FILE
			a_file_name: STRING
		do
			a_file_name := clone (a_folder)
			a_file_name.append_character (Directory_separator)
			a_file_name.append (Ace_file_name)
			create a_file.make_create_read_write (a_file_name)
			a_file.put_string (System_keyword)
			a_file.put_string (New_line_tab)
			a_file.put_string (Shared_wizard_environment.project_name)
			a_file.put_string (New_line)
			a_file.put_string (Partial_ace_file)
			a_file.close
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

	eiffel_command: STRING is
			-- Eiffel compiler command line
		do
			Result := clone (Common_eiffel_command)
			Result.append (Ace_file_name)
		end

	Common_eiffel_command: STRING is "es4 -precompile -ace "
			-- Common Eiffel command line

	Ace_file_name: STRING is "Ace.ace"
			-- Ace file name

	Partial_ace_file: STRING is
			-- Ace file used to precompile generated Eiffel system
"root%N%T															%
%ANY%N%N															%
%default%N%T														%
%assertion (all)%N%T												%
%multithreaded (no)%N%T												%
%console_application (no)%N%T										%
%dynamic_runtime (no)%N%T											%
%dead_code_removal (yes)%N%T										%
%profile (no)%N%T													%
%line_generation (no)%N%T											%
%debug  (no)%N%T													%
%array_optimization (no)%N%T										%
%inlining (no)%N%T													%
%inlining_size (%"4%")%N%N											%
%cluster%N%T														%
%root_cluster: %".%";%N%T											%
%server (root_cluster):				%"$\component%"%N%T%T			%
%-- EiffelBase%N%T													%
%all base:						%"$EIFFEL4\library\base%"%N%T%T		%
%exclude%N%T%T%T													%
%%"table_eiffel3%"%N%T%T											%
%end%N%T															%
%-- WEL%N%T															%
%all wel:						%"$EIFFEL4\library\wel%"%N%N%T		%
%all time: 						%"$EIFFEL4\library\time%"%N%T%T		%
%exclude%N%T%T%T													%
%%"french%";%N%T%T													%
%%"german%"%N%T%T													%
%end;%N%T															%
%-- EiffelCOM%N%T													%
%all ecom:						%"$EIFFEL4\library\com%"%N%T		%
%all common:						%"..\common%"%N					%
%external%N%T														%
%include_path:	%"$EIFFEL4\library\wel\spec\windows\include%",%N%T%T%T%T%
%%"$EIFFEL4\library\com\library\include%",%N%T%T%T%T				%
%%"$EIFFEL4\library\com\runtime\include%",%N%T%T%T%T				%
%%"..\common\include%",%N%T%T%T%T									%
%%"include%";%N%N%T													%
%object: 		%"$(EIFFEL4)\library\wel\spec\$(COMPILER)\lib\wel.lib%",%N%T%T%T%T%
%%"$(EIFFEL4)\library\time\spec\msc\lib\datetime.lib%",%N%T%T%T%T	%
%%"$(EIFFEL4)\library\com\spec\msc\lib\com.lib%",%N%T%T%T%T			%
%%"$(EIFFEL4)\library\com\spec\msc\lib\com_runtime.lib%",%N%T%T%T%T	%
%%"..\common\spec\msc\lib\ecom.lib%",%N%T%T%T%T						%
%%"spec\msc\lib\ecom.lib%";%N										%
%end"
		
end -- class WIZARD_IDL_COMPILER