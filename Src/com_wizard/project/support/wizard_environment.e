indexing 
	description: "Information on data to be generated"

class 
	WIZARD_ENVIRONMENT

inherit
	WIZARD_OUTPUT_LEVEL

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	EXECUTION_ENVIRONMENT
		rename
			return_code as exec_return_code
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize environment
		do
			is_in_process := True
			is_client := True
			Compile_c := True
			Compile_eiffel := True
		end

feature -- Access

	is_eiffel_interface: BOOLEAN
			-- Is project COM interface to existing Eiffel project?
	
	is_new_component: BOOLEAN
			-- Is project for new COM component?
	
	is_client: BOOLEAN
			-- Is project for accessing existing COM component?

	marshaller_generated: BOOLEAN
			-- Should standard marshaller be generated?

	eiffel_class_name: STRING
			-- Eiffel class name to generate IDL.

	class_cluster_name: STRING
			-- Cluster to which Eiffel class belongs.

	eiffel_project_name: STRING
			-- Eiffel project name.

	ace_file_name: STRING
			-- Eiffel Ace file.

	idl_file_name: STRING
			-- Path to definition file.
	
	proxy_stub_file_name: STRING
			-- Path to Proxy/Stub dll.

	type_library_file_name: STRING
			-- Path to type library.

	is_in_process: BOOLEAN
			-- Should in process server code be generated?
			
	is_out_of_process: BOOLEAN
			-- Should out of process server code be generated?

	destination_folder: STRING
			-- Path to destination folder.
	
	project_name: STRING
			-- Project name.

	idl: BOOLEAN
			-- Is definition file an IDL file?

	abort: BOOLEAN
			-- Should code generation be aborted?

	return_code: INTEGER
			-- Last return code.

	compile_eiffel: BOOLEAN
			-- Should generated eiffel code be compiled?

	compile_c: BOOLEAN
			-- Should generated c code be compiled?

	clean_destination_folder: BOOLEAN
			-- Should wizard clean destination folder before
			-- starting code generation?
	
	backup: BOOLEAN
			-- Should wizard backup existing files?

feature -- Basic Operations

	save_values is
			-- Save profile values
		do
			
		end
		
feature -- Element Change

	set_is_eiffel_interface is
			-- Set `is_eiffel_interface' with `True'.
			-- Set `is_new_component' with `False'.
			-- Set `is_client' with `False'.
		do
			is_eiffel_interface := True
			is_new_component := False
			is_client := False
		ensure
			is_eiffel_interface: is_eiffel_interface
			not_is_new_component: not is_new_component
			not_is_client: not is_client
		end
		
	set_is_new_component is
			-- Set `is_eiffel_interface' with `False'.
			-- Set `is_new_component' with `True'.
			-- Set `is_client' with `False'.
		do
			is_eiffel_interface := False
			is_new_component := True
			is_client := False
		ensure
			not_is_eiffel_interface: not is_eiffel_interface
			is_new_component: is_new_component
			not_is_client: not is_client
		end
		
	set_is_client is
			-- Set `is_eiffel_interface' with `False'.
			-- Set `is_new_component' with `False'.
			-- Set `is_client' with `True'.
		do
			is_eiffel_interface := False
			is_new_component := False
			is_client := True
		ensure
			not_is_eiffel_interface: not is_eiffel_interface
			not_is_new_component: not is_new_component
			is_client: is_client
		end
	
	set_marshaller_generated (a_value: BOOLEAN) is
			-- Set `marshaller_generated' with `a_value'.
		do
			marshaller_generated := a_value
		ensure
			marshaller_generated_set: marshaller_generated = a_value
		end
		
	set_ace_file_name (ace_file: STRING) is
			-- Set 'ace_file_name' to 'ace_file'.
		require
			non_void_file: ace_file /= Void
			valid_ace_file: not ace_file.is_empty
		do
			ace_file_name := ace_file
		ensure
			ace_file_name_set: ace_file_name = ace_file
		end

	set_is_in_process is
			-- Set `is_in_process' with `True'.
			-- Set `is_out_of_process' with `False'.
		do
			is_in_process := True
			is_out_of_process := False
		ensure
			is_in_process_set: is_in_process
			is_out_of_process_set: not is_out_of_process
		end

	set_is_out_of_process is
			-- Set `is_out_of_process' with `True'.
			-- Set `is_in_process' with `False'.
		do
			is_out_of_process := True
			is_in_process := False
		ensure
			is_out_of_process_set: is_out_of_process
			is_in_process_set: not is_in_process
		end

	set_eiffel_class_name (c_name: like eiffel_class_name) is
			-- Set 'eiffel_class_name' to 'c_name'.
		require
			non_void_name: c_name /= Void
			valid_name: not c_name.is_empty
		local
			l_idl_file_name: STRING
		do
			eiffel_class_name := c_name.as_upper
			if destination_folder /= Void then
				l_idl_file_name := destination_folder.twin
				l_idl_file_name.append ("idl\")
				l_idl_file_name.append (eiffel_class_name.as_lower)
				l_idl_file_name.append (".idl")
				set_idl_file_name (l_idl_file_name)
			end
		ensure
			name_set: eiffel_class_name /= Void and then not eiffel_class_name.is_empty
		end

	set_class_cluster_name (c_name: like class_cluster_name) is
			-- Set 'class_cluster_name' to 'c_name'.
		require
			non_void_name: c_name /= Void
			valid_name: not c_name.is_empty
		do
			class_cluster_name := c_name
		ensure
			name_set: class_cluster_name /= Void and then not class_cluster_name.is_empty
		end

	set_eiffel_project (p_name: like eiffel_project_name) is
			-- Set 'eiffel_project_name' to 'p_name'.
		require
			non_void_name: p_name /= Void
			valid_name: not p_name.is_empty
		do
			eiffel_project_name := p_name
		ensure
			name_set: eiffel_project_name.is_equal (p_name)
		end

	set_destination_folder (a_folder: like destination_folder) is
			-- Set `destination_folder' with `a_folder'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: not a_folder.is_empty
		local
			l_idl_file_name: STRING
		do
			destination_folder := expanded_path (a_folder)
			if destination_folder.item (destination_folder.count) /= Directory_separator then
				destination_folder.append_character (Directory_separator)
			end
			if is_eiffel_interface and eiffel_class_name /= Void then
				l_idl_file_name := destination_folder.twin
				l_idl_file_name.append ("idl\")
				l_idl_file_name.append (eiffel_class_name.as_lower)
				l_idl_file_name.append (".idl")
				set_idl_file_name (l_idl_file_name)
			end
		end

	set_project_name (a_name: like project_name) is
			-- Set `project_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_index: INTEGER
		do
			l_index := a_name.last_index_of ('.', a_name.count)
			if l_index > 0 then
				project_name := a_name.substring (1, l_index - 1)
			else
				project_name := a_name
			end
		ensure
			project_name_set: project_name = a_name or else project_name.is_equal (a_name.substring (1, a_name.last_index_of ('.', a_name.count) - 1))
		end

	set_idl_file_name (a_idl_file_name: like idl_file_name) is
			-- Set `idl_file_name' with `a_idl_file_name'.
		require
			non_void_idl_file_name: a_idl_file_name /= Void
			valid_idl_file_name: not a_idl_file_name.is_empty
		do
			idl_file_name := expanded_path (a_idl_file_name)
			idl := True
		ensure
			idl_file_name_set: idl_file_name.is_equal (expanded_path(a_idl_file_name))
			idl: idl
		end
	
	set_proxy_stub_file_name (a_proxy_stub: like proxy_stub_file_name) is
			-- Set `proxy_stub_file_name' with `a_proxy_stub'.
		require
			non_void_proxy_stub: a_proxy_stub /= Void
			valid_proxy_stub: not a_proxy_stub.is_empty
		do
			proxy_stub_file_name := expanded_path (a_proxy_stub)
		ensure
			proxy_stub_file_name_set: proxy_stub_file_name.is_equal (expanded_path (a_proxy_stub))
		end
	
	set_type_library_file_name (a_type_library_file_name: like type_library_file_name) is
			-- Set `type_library_file_name' with `a_type_library_file_name'.
		require
			non_void_type_library_file_name: a_type_library_file_name /= Void
			valid_type_library_file_name: not a_type_library_file_name.is_empty
		do
			type_library_file_name := expanded_path (a_type_library_file_name)
		ensure
			type_library_file_name_set: type_library_file_name.is_equal (expanded_path (a_type_library_file_name))
		end

	set_idl (a_boolean: BOOLEAN) is
			-- Set `idl' with `a_boolean'.
		do
			idl := a_boolean
		ensure
			idl_set: idl = a_boolean
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

	set_backup (a_boolean: BOOLEAN) is
			-- Set `backup' with `a_boolean'.
		do
			backup := a_boolean
		ensure
			backup_set: backup = a_boolean
		end

	set_clean_destination_folder (a_boolean: BOOLEAN) is
			-- Set `clean_destination_folder' with `a_boolean'.
		do
			clean_destination_folder := a_boolean
		ensure
			clean_destination_folder_set: clean_destination_folder = a_boolean
		end

feature {NONE} -- Implementation

	expanded_path (a_path: STRING): STRING is
			-- Expand all environment variables in `a_path'.
		require
			non_void_path: a_path /= Void
		local
			l_list: LIST [STRING]
			l_value: STRING
		do
			if not a_path.has ('$') then
				-- Optimization
				Result := a_path
			else
				create Result.make (a_path.count)
				l_list := a_path.split (Directory_separator)
				from
					l_list.start
					if not l_list.after then
						l_value := l_list.item
						if l_value.count > 0 and then l_value.item (1) = '$' then
							l_value.keep_tail (l_value.count - 1)
							l_value := get (l_value)
						end
						if l_value /= Void then
							Result.append (l_value)
						end
						l_list.forth
					end
				until
					l_list.after
				loop
					Result.append_character (Directory_separator)
					l_value := l_list.item
					if l_value.count > 0 and then l_value.item (1) = '$' then
						l_value.keep_tail (l_value.count - 1)
						l_value := get (l_value)
					end
					if l_value /= Void then
						Result.append (l_value)
					end
					l_list.forth
				end
			end
		ensure
			non_void_expanded_path: Result /= Void
			expanded_path: not Result.has ('$')
		end

invariant
	valid_type: is_new_component xor is_eiffel_interface xor is_client
	valid_destination_folder: destination_folder /= Void implies (destination_folder.item (destination_folder.count) = Directory_separator)
	valid_eiffel_compilation_choice: compile_eiffel implies compile_c

end -- class WIZARD_ENVIRONMENT