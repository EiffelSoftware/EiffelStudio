indexing 
	description: "Information on data to be generated"

class 
	WIZARD_ENVIRONMENT

inherit
	STORABLE

	WIZARD_OUTPUT_LEVEL

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize environment
		do
			in_process_server := True
			use_universal_marshaller := True
			automation := True
			client := True
			output_level := Output_warnings
			Compile_c := True
			Compile_eiffel := True
		end

feature -- Access

	in_process_server: BOOLEAN
			-- Should in process server code be generated?
			
	out_of_process_server: BOOLEAN
			-- Should out of process server code be generated?

	idl_file_name: STRING
			-- Path to definition file
	
	type_library_file_name: STRING
			-- Path to type library

	destination_folder: STRING
			-- Path to destination folder
	
	project_name: STRING
			-- Project name

	idl: BOOLEAN
			-- Is definition file an IDL file?

	proxy_stub_file_name: STRING
			-- Path to Proxy/Stub dll
			
	use_universal_marshaller: BOOLEAN
			-- Should component use universal marshaller?

	server: BOOLEAN
			-- Should code for server be generated?

	client: BOOLEAN
			-- Should code for client be generated?

	automation: BOOLEAN
			-- Should server use automation?

	abort: BOOLEAN
			-- Should code generation be aborted?

	return_code: INTEGER
			-- Last return code

	output_level: INTEGER
			-- Output level

	compile_eiffel: BOOLEAN
			-- Should generated eiffel code be compiled?

	compile_c: BOOLEAN
			-- Should generated c code be compiled?

	stop_on_error: BOOLEAN
			-- Should wizard stop on compilation error?

feature -- Element Change

	set_in_process_server (a_boolean: BOOLEAN) is
			-- Set `in_process_server' with `a_boolean'.
		do
			in_process_server := a_boolean
		ensure
			in_process_server_set: in_process_server = a_boolean
		end
	
	set_warning_output is
			-- Set `output_level' with `Output_warnings'.
		do
			output_level := Output_warnings
		ensure
			output_level_set: output_level = Output_warnings
		end

	set_all_output is
			-- Set `output_level' with `Output_all'.
		do
			output_level := Output_all
		ensure
			output_level_set: output_level = Output_all
		end

	set_no_output is
			-- Set `output_level' with `Output_none
		do
			output_level := Output_none
		ensure
			output_level_set: output_level = Output_none
		end

	set_out_of_process_server (a_boolean: BOOLEAN) is
			-- Set `out_of_process_server' with `a_boolean'.
		do
			out_of_process_server := a_boolean
		ensure
			out_of_process_server_set: out_of_process_server = a_boolean
		end

	set_destination_folder (a_folder: like destination_folder) is
			-- Set `destination_folder' with `a_folder'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: not a_folder.empty
		do
			destination_folder := clone (a_folder)
			if not (destination_folder.item (destination_folder.count) = Directory_separator) then
				destination_folder.append_character (Directory_separator)
			end
		end

	set_project_name (a_name: like project_name) is
			-- Set `project_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			if a_name.index_of ('.', 1) /= 0 then
				project_name := a_name.substring (1, a_name.index_of ('.', 1) - 1)
			else
				project_name := clone (a_name)
			end
		ensure
			project_name_set: (a_name.has ('.') implies project_name.is_equal (a_name.substring (1, a_name.index_of ('.', 1) - 1))) and (not a_name.has ('.') implies project_name.is_equal (a_name))
			valid_project_name: not project_name.has ('.')
		end

	set_proxy_stub_file_name (a_proxy_stub: like proxy_stub_file_name) is
			-- Set `proxy_stub' with `a_proxy_stub'.
		require
			non_void_proxy_stub: a_proxy_stub /= Void
			valid_proxy_stub: not a_proxy_stub.empty
		do
			proxy_stub_file_name := clone (a_proxy_stub)
		ensure
			proxy_stub_file_name_set: proxy_stub_file_name.is_equal (a_proxy_stub)
		end
	
	set_idl_file_name (a_idl_file_name: like idl_file_name) is
			-- Set `idl_file_name' with `a_idl_file_name'.
		require
			non_void_idl_file_name: a_idl_file_name /= Void
			valid_idl_file_name: not a_idl_file_name.empty
		do
			idl_file_name := clone (a_idl_file_name)
		ensure
			idl_file_name_set: idl_file_name.is_equal (a_idl_file_name)
		end
	
	set_type_library_file_name (a_type_library_file_name: like type_library_file_name) is
			-- Set `type_library_file_name' with `a_type_library_file_name'.
		require
			non_void_type_library_file_name: a_type_library_file_name /= Void
			valid_type_library_file_name: not a_type_library_file_name.empty
		do
			type_library_file_name := clone (a_type_library_file_name)
		ensure
			type_library_file_name_set: type_library_file_name.is_equal (a_type_library_file_name)
		end
	
	set_idl (a_boolean: BOOLEAN) is
			-- Set `idl' with `a_boolean'.
		do
			idl := a_boolean
		ensure
			idl_set: idl = a_boolean
		end
	
	set_server (a_boolean: BOOLEAN) is
			-- Set `server' with `a_boolean'.
		do
			server := a_boolean
		ensure
			server_set: server = a_boolean
		end

	set_client (a_boolean: BOOLEAN) is
			-- Set `client' with `a_boolean'.
		do
			client := a_boolean
		ensure
			client_set: client = a_boolean
		end

	set_use_universal_marshaller (a_boolean: BOOLEAN) is
			-- Set `use_universal_marshaller' with `a_boolean'.
		do
			use_universal_marshaller := a_boolean
		ensure
			use_universal_marshaller_set: use_universal_marshaller = a_boolean
		end
	
	set_automation (a_boolean: BOOLEAN) is
			-- Set `automation' with `a_boolean'.
		do
			automation := a_boolean
		ensure
			automation_set: automation = a_boolean
		end
	
	set_abort (a_return_code: like return_code) is
			-- Set `abort' to `True'.
			-- Set `return_code' with `a_return_code'.
		do
			abort := True
			return_code := a_return_code
		ensure
			abort: abort
			return_code_set: return_code = a_return_code
		end

	set_no_abort is
			-- Set `abort' to `False'.
		do
			abort := False
		ensure
			no_abort: not abort
		end

	set_compile_eiffel (a_boolean: like compile_eiffel) is
			-- Set `compile_eiffel' to `a_boolean'.
		do
			compile_eiffel := a_boolean
		ensure
			compile_eiffel_set: compile_eiffel = a_boolean
		end

	set_compile_c (a_boolean: like compile_c) is
			-- Set `compile_c' to `a_boolean'.
		do
			compile_c := a_boolean
		ensure
			compile_c_set: compile_c = a_boolean
		end

	set_stop_on_error (a_boolean: like stop_on_error) is
			-- Set `stop_on_error' to `a_boolean'.
		do
			stop_on_error := a_boolean
		ensure
			stop_on_error_set: stop_on_error = a_boolean
		end

invariant

	valid_output_level: output_level = Output_warnings or output_level = Output_all or output_level = Output_none
	valid_destination_folder: destination_folder /= Void implies (destination_folder.item (destination_folder.count) = Directory_separator)
	valid_eiffel_compilation_choice: compile_eiffel implies compile_c

end -- class WIZARD_ENVIRONMENT