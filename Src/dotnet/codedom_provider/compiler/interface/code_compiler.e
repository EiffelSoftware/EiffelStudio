indexing 
	description: "Eiffel compiler CodeDom interface implementation"
	date: "$$"
	revision: "$$"

class
	CODE_COMPILER

inherit
	SYSTEM_DLL_ICODE_COMPILER
	CODE_DOM_PATH
	CODE_CONFIGURATION
	CODE_SHARED_CONTEXT
	CODE_FILE_HANDLER
	CODE_EXECUTION_ENVIRONMENT
	CODE_SHARED_TEMPORARY_FILES
	CODE_SHARED_EVENT_MANAGER
	CODE_SHARED_REFERENCED_ASSEMBLIES
	CODE_SHARED_GENERATION_HELPERS
	CODE_SHARED_ACCESS_MUTEX

create
	default_create

feature -- Access

	last_compilation_results: SYSTEM_DLL_COMPILER_RESULTS
			-- Last compilation results

	is_initialized: BOOLEAN
			-- Is compiler correctly initialized?

feature -- Basic Operations

	compile_assembly_from_source (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_source: SYSTEM_STRING): SYSTEM_DLL_COMPILER_RESULTS is
			-- Compile assembly from string `a_source' using compiler options `a_options'.
		require else
			non_void_options: a_options /= Void
			non_void_source: a_source /= Void
		local
			l_res: SYSTEM_OBJECT
		do
			if Access_mutex.wait_one then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromSource"])
				(create {SECURITY_PERMISSION}.make ({SECURITY_PERMISSION_FLAG}.unmanaged_code)).assert
				initialize (a_options)
				if is_initialized then
					source_generator.generate (a_source)
					compile
					Result := last_compilation_results
				else
					create Result.make (a_options.temp_files)
					l_res := Result.errors.add (create {SYSTEM_DLL_COMPILER_ERROR}.make_with_file_name ("", 0, 0, "0", "Compiler initialization failed (1)"))
				end
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromSource"])
				Access_mutex.release_mutex
			end
		ensure then
			non_void_results: Result /= Void
		rescue
			Access_mutex.release_mutex
			Event_manager.process_exception
		end

	compile_assembly_from_source_batch (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_sources: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_DLL_COMPILER_RESULTS is
			-- Compile assembly from strings in array `a_sources' using compiler options `a_options'.
		require else
			non_void_options: a_options /= Void
			non_void_sources: a_sources /= Void
		local
			i, l_count: INTEGER
			l_res: SYSTEM_OBJECT
		do
			if Access_mutex.wait_one then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromSourceBatch"])
				(create {SECURITY_PERMISSION}.make ({SECURITY_PERMISSION_FLAG}.unmanaged_code)).assert
				initialize (a_options)
				if is_initialized then
					from
						l_count := a_sources.count
					until
						i = l_count				
					loop
						source_generator.generate (a_sources.item (i))
						i := i + 1
					end
					compile
					Result := last_compilation_results
				else
					create Result.make (a_options.temp_files)
					l_res := Result.errors.add (create {SYSTEM_DLL_COMPILER_ERROR}.make_with_file_name ("", 0, 0, "0", "Compiler initialization failed (2)"))
				end
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromSourceBatch"])
				Access_mutex.release_mutex
			end
		ensure then
			non_void_results: Result /= Void
		rescue
			Access_mutex.release_mutex
			Event_manager.process_exception
		end

	compile_assembly_from_file (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_file_name: SYSTEM_STRING): SYSTEM_DLL_COMPILER_RESULTS is
			-- Compile assembly from file `a_file_name' using compiler options `a_options'.
		require else
			non_void_options: a_options /= Void
			non_void_file_name: a_file_name /= Void
		local
			l_file: PLAIN_TEXT_FILE
			l_res: SYSTEM_OBJECT
		do
			if Access_mutex.wait_one then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromFile"])
				(create {SECURITY_PERMISSION}.make ({SECURITY_PERMISSION_FLAG}.unmanaged_code)).assert
				create l_file.make (a_file_name)
				if l_file.exists then
					l_file.open_read
					l_file.read_stream (l_file.count)
					l_file.close
					Result := compile_assembly_from_source (a_options, l_file.last_string)
				else
					create Result.make (a_options.temp_files)
					l_res := Result.errors.add (create {SYSTEM_DLL_COMPILER_ERROR}.make_with_file_name ("", 0, 0, "0", "Source file is missing"))
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_source_file, [a_file_name])
				end
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromFile"])
				Access_mutex.release_mutex
			end
		ensure then
			non_void_results: Result /= Void
		rescue
			Access_mutex.release_mutex
			Event_manager.process_exception
		end

	compile_assembly_from_file_batch (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_file_names: NATIVE_ARRAY [SYSTEM_STRING]): SYSTEM_DLL_COMPILER_RESULTS is
			-- Compiles an assembly based on the specified `a_options' and `file_names'.
		require else
			non_void_options: a_options /= Void
			non_void_file_names: a_file_names /= Void
		local
			i, l_count: INTEGER
			l_file: PLAIN_TEXT_FILE
			l_res: SYSTEM_OBJECT
		do
			if Access_mutex.wait_one then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromFileBatch"])
				(create {SECURITY_PERMISSION}.make ({SECURITY_PERMISSION_FLAG}.unmanaged_code)).assert
				initialize (a_options)
				if is_initialized then
					from
						l_count := a_file_names.count
					until
						i = l_count
					loop
						create l_file.make (a_file_names.item (i))
						if l_file.exists then
							l_file.open_read
							l_file.read_stream (l_file.count)
							l_file.close
							source_generator.generate (l_file.last_string)
						else
							Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_source_file, [a_file_names.item (i)])
						end
						i := i + 1
					end
					compile
					Result := last_compilation_results;
				else
					create Result.make (a_options.temp_files)
					l_res := Result.errors.add (create {SYSTEM_DLL_COMPILER_ERROR}.make_with_file_name ("", 0, 0, "0", "Compiler initialization failed (3)"))
				end
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromFileBatch"])
				Access_mutex.release_mutex
			end
		ensure then
			non_void_results: Result /= Void
		rescue
			Access_mutex.release_mutex
			Event_manager.process_exception
		end

	compile_assembly_from_dom (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_compilation_unit: SYSTEM_DLL_CODE_COMPILE_UNIT): SYSTEM_DLL_COMPILER_RESULTS is
			-- Creates an assembly based on the specified `a_options' and `a_compilation_unit' (the text to compile).
		require else
			non_void_options: a_options /= Void
			non_void_compilation_unit: a_compilation_unit /= Void
		local
			l_stream: FILE_STREAM
			l_writer: STREAM_WRITER
			l_path: SYSTEM_STRING
		do
			if Access_mutex.wait_one then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromDom"])
				(create {SECURITY_PERMISSION}.make ({SECURITY_PERMISSION_FLAG}.unmanaged_code)).assert
				l_path := temp_files.add_extension ("es")
				create l_stream.make (l_path, {FILE_MODE}.Create_, {FILE_ACCESS}.Write, {FILE_SHARE}.Write)
				create l_writer.make (l_stream)
				(create {CODE_GENERATOR}).generate_code_from_compile_unit (a_compilation_unit, l_writer, Code_generator_options)
				l_writer.flush
				l_writer.close
				l_stream.close
				Result := compile_assembly_from_file (a_options, l_path)
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromDom"])
				Access_mutex.release_mutex
			end
		ensure then
			non_void_results: Result /= Void
		rescue
			Access_mutex.release_mutex
			Event_manager.process_exception
			if l_stream /= Void then
				l_stream.close
			end
		end

	compile_assembly_from_dom_batch (a_options: SYSTEM_DLL_COMPILER_PARAMETERS; a_compilation_units: NATIVE_ARRAY [SYSTEM_DLL_CODE_COMPILE_UNIT]): SYSTEM_DLL_COMPILER_RESULTS is
			-- Compiles an assembly based on the specified a_options.
		require else
			non_void_options: a_options /= Void
			non_void_compilation_units: a_compilation_units /= Void
		local
			l_stream: FILE_STREAM
			l_writer: STREAM_WRITER
			l_paths: NATIVE_ARRAY [SYSTEM_STRING]
			l_path: SYSTEM_STRING
			i, l_count: INTEGER
		do
			if Access_mutex.wait_one then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromDomBatch"])
				(create {SECURITY_PERMISSION}.make ({SECURITY_PERMISSION_FLAG}.unmanaged_code)).assert
				from
					l_count := a_compilation_units.length
					create l_paths.make (l_count)
				until
					i = l_count
				loop
					l_path := temp_files.add_extension (i.out + ".es")
					l_paths.put (i, l_path)
					create l_stream.make (l_path, {FILE_MODE}.Create_, {FILE_ACCESS}.Write, {FILE_SHARE}.Write)
					create l_writer.make (l_stream)
					(create {CODE_GENERATOR}).generate_code_from_compile_unit (a_compilation_units.item (i), l_writer, Code_generator_options)
					l_writer.flush
					l_writer.close
					l_stream.close
					i := i + 1
				end
				Result := compile_assembly_from_file_batch (a_options, l_paths)
				Event_manager.raise_event ({CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromDomBatch"])
				Access_mutex.release_mutex
			end
		ensure then
			non_void_results: Result /= Void
		rescue
			Access_mutex.release_mutex
			Event_manager.process_exception
			if l_stream /= Void then
				l_stream.close
			end
		end

feature {NONE} -- Implementation
		
	initialize (a_options: SYSTEM_DLL_COMPILER_PARAMETERS) is
			-- Initialize compilation settings from `a_options'.
		require
			non_void_options: a_options /= Void
		local
			l_temp_dir, l_root_class, l_system_name, l_resource_file,
				l_path, l_assembly_file_name, l_creation_routine, l_precompile_file: STRING
			l_res: DIRECTORY_INFO
			l_retried: BOOLEAN
			l_assemblies: SYSTEM_DLL_STRING_COLLECTION
			i, l_count: INTEGER
			l_assembly: CODE_REFERENCED_ASSEMBLY
			l_type: CODE_GENERATED_TYPE
			l_creation_routines: HASH_TABLE [CODE_CREATION_ROUTINE, STRING]
			l_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			l_found: BOOLEAN
			l_ace_file: CODE_ACE_FILE
			l_cluster: CODE_ACE_CLUSTER
			l_precompiler: CODE_PRECOMPILER
			l_precompile_assemblies: NATIVE_ARRAY [ASSEMBLY_NAME]
			l_references_list: CODE_REFERENCES_LIST
			l_assembly_name, l_name: ASSEMBLY_NAME
		do
			if not l_retried then
				-- First create temporary directory if needed
				if a_options.temp_files = Void or else a_options.temp_files.temp_dir = Void or else a_options.temp_files.temp_dir.length = 0 then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_temporary_files, [])
					set_temp_files (create {SYSTEM_DLL_TEMP_FILE_COLLECTION}.make_from_temp_dir ({PATH}.get_temp_path))
				else
					set_temp_files (a_options.temp_files)
				end
				
				l_temp_dir := temp_files.temp_dir
				if l_temp_dir.item (l_temp_dir.count) = Directory_separator then
					l_temp_dir.keep_head (l_temp_dir.count - 1)
				end
				if not {SYSTEM_DIRECTORY}.exists (l_temp_dir) then
					l_res := {SYSTEM_DIRECTORY}.create_directory (l_temp_dir)
				end
				
				-- Initialize `compilation_directory' and `source_generator'
				compilation_directory := l_temp_dir
				create source_generator.make (compilation_directory)
				
				-- Finally initialize compiler
				create l_ace_file.make
 				ace_file_path := temp_files.add_extension ("ace")
				
				if a_options.output_assembly /= Void then
					system_path := a_options.output_assembly
				end
				if system_path = Void or else system_path.is_empty then
					if a_options.generate_executable then
						system_path := temp_files.add_extension ("exe")
					else
						system_path := temp_files.add_extension ("dll")
					end
				end
				l_system_name := system_path.substring (system_path.last_index_of (Directory_separator, system_path.count) + 1, system_path.count)
				if l_system_name.substring_index (".dll", 1) = l_system_name.count - 3 or l_system_name.substring_index (".exe", 1) = l_system_name.count - 3 then
					l_system_name.keep_head (l_system_name.count - 4)
				end
				l_ace_file.set_system_name (l_system_name)
				
				create l_cluster.make ("root_cluster", compilation_directory)
					
				l_root_class := Compilation_context.root_class_name
				l_creation_routine := Compilation_context.root_creation_routine_name
				if l_root_class = Void or else l_root_class.is_empty then
					if a_options.main_class /= Void then
						l_root_class := a_options.main_class
					end
					if l_root_class = Void or else l_root_class.is_empty then
						if not Resolver.generated_types.is_empty then
							from
								Resolver.generated_types.start
								l_type := Resolver.generated_types.item_for_iteration
								l_root_class := l_type.eiffel_name
								from
									l_creation_routines := l_type.creation_routines
									l_creation_routines.start
								until
									l_creation_routines.after or l_found
								loop
									l_arguments := l_creation_routines.item_for_iteration.arguments
									l_found := l_arguments = Void or else l_arguments.is_empty 
									if l_found then
										l_creation_routine := l_creation_routines.item_for_iteration.eiffel_name
									end
									l_type.creation_routines.forth
								end
								Resolver.generated_types.forth
							until
								Resolver.generated_types.after
							loop
								l_cluster.add_visible_clause (Resolver.generated_types.item_for_iteration.eiffel_name)
								Resolver.generated_types.forth
							end
						else
							l_root_class := default_root_class
						end
					end
				end
				l_ace_file.set_root_class_name (l_root_class)
				l_ace_file.add_cluster (l_cluster)

				if not l_root_class.is_equal ("ANY") and not l_root_class.is_equal ("NONE") and l_creation_routine /= Void then
					l_ace_file.set_root_creation_routine_name (l_creation_routine)
				end
		
				l_ace_file.set_console_application (a_options.generate_executable)
		
				l_ace_file.set_target_clr_version (Clr_version)
				
				-- Setup Precompile
				l_precompile_file := Compilation_context.precompile_file
					-- Was there a snippet defined precompile file?
				if l_precompile_file = Void then
					l_precompile_file := precompile_ace_file
						-- Otherwise use configuration precompile file 
				end
				if l_precompile_file /= Void then
					create l_precompiler.make (l_precompile_file, precompile_cache)
					l_precompiler.precompile
					if l_precompiler.successful then
						l_ace_file.set_precompile (l_precompiler.precompile_path)
						precompile_files := l_precompiler.precompile_files
					else
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Precompile_failed, [l_precompile_file, precompile_cache])
					end
				end

				-- Setup referenced assemblies
				l_assemblies := a_options.referenced_assemblies
				if l_assemblies /= Void and then l_assemblies.count > 0 then
					from
						l_count := l_assemblies.count
						i := 0
					until
						i = l_count
					loop
						l_assembly_file_name := l_assemblies.item (i)
						if not Referenced_assemblies.has_file (l_assembly_file_name) then
							if {SYSTEM_FILE}.exists (l_assembly_file_name) then
								l_path := l_assembly_file_name
							else
								l_path := {RUNTIME_ENVIRONMENT}.get_runtime_directory
								l_path.append (l_assembly_file_name)
							end
							if {SYSTEM_FILE}.exists (l_path) then
								Referenced_assemblies.extend_file (l_path)
							else
								Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_assembly, [l_assembly_file_name])
							end
						end
						i := i + 1		
					end
				elseif l_precompiler = Void or else not l_precompiler.successful then
					add_default_assemblies
				end
				
				-- Complete list of referenced assemblies so all required assemblies are listed
				Referenced_assemblies.complete
				
					-- Remove precompile referenced assemblies
				if l_precompiler /= Void and then l_precompiler.successful then
						-- Only add references not already in precompile
					create l_references_list.make (10)
					from
						l_precompile_assemblies := l_precompiler.precompile_assembly.get_referenced_assemblies
						i := 0
						l_count := l_precompile_assemblies.count
					until
						i = l_count
					loop
						l_assembly_name := l_precompile_assemblies.item (i)
						if not l_references_list.has_name (l_assembly_name) then
							l_references_list.extend_name (l_assembly_name)
						end
						i := i + 1
					end
					l_references_list.complete
					from
						l_references_list.start
					until
						l_references_list.after
					loop
						l_name := l_references_list.item.assembly.get_name
						if Referenced_assemblies.has_name (l_name) then
							Referenced_assemblies.remove_name (l_name)
						end
						l_references_list.forth
					end
				end
				

				-- Only add base clusters if requires
				create l_cluster.make ("base", "$ISE_EIFFEL\library\base")
				l_cluster.set_namespace ("EiffelSoftware.Library.Base")
				l_cluster.add_exclude_clause ("table_eiffel3")
				l_cluster.add_exclude_clause ("desc")
				l_cluster.add_exclude_clause ("classic")
				l_cluster.set_is_library
				l_ace_file.add_cluster (l_cluster)
				
				create l_cluster.make ("base_net", "$ISE_EIFFEL\library.net\base")
				l_cluster.set_namespace ("EiffelSoftware.Library.BaseNet")
				l_cluster.set_is_library
				l_ace_file.add_cluster (l_cluster)
				
				create l_cluster.make ("codedom", "$ISE_EIFFEL\library.net\codedom")
				l_cluster.set_namespace ("EiffelSoftware.Library.CodeDom")
				l_cluster.set_is_library
				l_ace_file.add_cluster (l_cluster)

				-- Add referenced assemblies
				from
					Referenced_assemblies.start
				until
					Referenced_assemblies.after
				loop
					l_assembly := Referenced_assemblies.item
					l_ace_file.add_assembly (create {CODE_ACE_ASSEMBLY}.make (l_assembly.cluster_name, l_assembly.assembly.location, l_assembly.assembly_prefix))
					Referenced_assemblies.forth
				end
				
				-- Setup resource file
				if a_options.win_32_resource /= Void then
					l_resource_file := compilation_directory + Directory_separator.out + l_system_name + ".rc"
					copy_file (a_options.win_32_resource, l_resource_file)
					if last_copy_successful then
						temp_files.add_file (l_resource_file, False)
					end
				end
				
				-- Setup miscelleaneous settings
				if compiler_metadata_cache /= Void then
					l_ace_file.set_metadata_cache_path (compiler_metadata_cache)
				end
	
				l_ace_file.set_generate_debug_info (a_options.include_debug_information)
				
				l_ace_file.write (ace_file_path)
				load_result_in_memory := a_options.generate_in_memory
				cleanup -- to avoid error if a .epr file already exists in project folder
				is_initialized := True
			end
		ensure
			non_void_temp_files: is_initialized implies temp_files /= Void
			valid_compilation_directory: is_initialized implies compilation_directory /= Void and then (create {DIRECTORY}.make (compilation_directory)).exists
			non_void_source_generator: is_initialized implies source_generator /= Void
			non_void_system_path: is_initialized implies system_path /= Void
			valid_system_path: is_initialized implies not system_path.is_empty
		rescue
			l_retried := True
			retry
		end
	
	compile is
			-- Compile all `.e' files in directory `compilation_directory'.
			-- Put resulting dlls and pdb in `system_path' folder.
		require
			ace_file_set: ace_file_path /= Void
		local
			l_retried: BOOLEAN
			l_start_info: SYSTEM_DLL_PROCESS_START_INFO
			l_process: SYSTEM_DLL_PROCESS
			l_output_reader, l_error_reader: SYSTEM_THREAD
			l_res: SYSTEM_OBJECT
			l_compiler_path: STRING
		do
			if not l_retried then
				create last_compilation_results.make (temp_files)
				l_compiler_path := Compiler_path
				if l_compiler_path = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_compiler_path, [])
				else
					create l_start_info.make_from_file_name_and_arguments (l_compiler_path + Directory_separator.out + Compiler_file_name, "-batch -finalize -ace %"" + ace_file_name + "%"")
					l_start_info.set_working_directory (compilation_directory)
					l_start_info.set_create_no_window (True)
					l_start_info.set_redirect_standard_error (True)
					l_start_info.set_redirect_standard_output (True)
					l_start_info.set_use_shell_execute (False)
					create l_process.make
					l_process.set_start_info (l_start_info)
					if l_process.start then
						output_stream := l_process.standard_output
						error_stream := l_process.standard_error
						create l_output_reader.make (create {THREAD_START}.make (Current, $read_output))
						create l_error_reader.make (create {THREAD_START}.make (Current, $read_error))
						l_output_reader.start
						l_error_reader.start
						l_process.wait_for_exit
						l_output_reader.join
						l_error_reader.join
						if compiler_error /= Void then
	--						l_res := last_compilation_results.errors.add (create {SYSTEM_DLL_COMPILER_ERROR}.make ("", 0, 0, "", compiler_error))					
							l_res := last_compilation_results.output.add (compiler_error)
						end
						if compiler_output /= Void then
							l_res := last_compilation_results.output.add (compiler_output)
						end
						check_compilation_result
					end
					cleanup
					reset_temp_files
				end
				ace_file_path := Void
				source_generator := Void
				compilation_directory := Void
			end
		ensure
			non_void_results: last_compilation_results /= Void
		end
		
	check_compilation_result is
			-- Check that assembly was created.
			-- Set native compiler result and compiled assembly accordingly.
		local
			l_retried: BOOLEAN
			l_dir_name, l_system_dir, l_file: STRING
			l_dir: DIRECTORY
			l_files: LIST [STRING]
			l_file_stream: FILE_STREAM
			l_array: NATIVE_ARRAY [NATURAL_8]
			l_ass: RAW_FILE
			l_res: SYSTEM_OBJECT
		do
			if not l_retried then
				last_compilation_results.set_native_compiler_return_value (1)
				create l_dir_name.make (compilation_directory.count + 14)
				l_dir_name.append (compilation_directory)
				l_dir_name.append_character (Directory_separator)
				l_dir_name.append ("EIFGEN")
				l_dir_name.append_character (Directory_separator)
				l_dir_name.append ("F_Code")
				create l_dir.make (l_dir_name)
				if l_dir.exists then
					l_system_dir := system_path.substring (1, system_path.last_index_of (Directory_separator, system_path.count) - 1)
					if l_system_dir.is_empty then
						l_system_dir := (create {EXECUTION_ENVIRONMENT}).Current_working_directory
					end
					if not l_system_dir.is_equal (l_dir_name) then
						l_files := l_dir.linear_representation
						from
							l_files.start
						until
							l_files.after
						loop
							l_file := l_files.item
							if has_extension (l_file, "dll") or has_extension (l_file, "exe") or has_extension (l_file, "pdb") then
								copy_file (l_dir_name + Directory_separator.out + l_file, l_system_dir + Directory_separator.out + l_file)									
							end
							l_files.forth
						end
						if precompile_files /= Void then
							from
								precompile_files.start
							until
								precompile_files.after
							loop
								l_file := precompile_files.item
								copy_file (l_file, l_system_dir + Directory_separator.out + l_file.substring (l_file.last_index_of (Directory_separator, l_file.count) + 1, l_file.count))
								precompile_files.forth
							end
							precompile_files := Void -- for next compilation
						end
						create l_ass.make (system_path)
						if l_ass.exists then
							last_compilation_results.set_path_to_assembly (system_path)
							last_compilation_results.set_native_compiler_return_value (0)
							if load_result_in_memory then
								create l_file_stream.make (system_path, {FILE_MODE}.Open, {FILE_ACCESS}.Read, {FILE_SHARE}.Read)
								create l_array.make (l_file_stream.length.to_integer)
								last_compilation_results.set_compiled_assembly ({ASSEMBLY}.load (l_array, Void))
								l_file_stream.close
							end
						end
					end
				else
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_directory, [compilation_directory + Directory_separator.out + "EIFGEN" + Directory_separator.out + "F_Code"])
				end
			else
				create last_compilation_results.make (temp_files)
				l_res := last_compilation_results.errors.add (create {SYSTEM_DLL_COMPILER_ERROR}.make_with_file_name ("", 0, 0, "1", "Compiler threw an exception"))
			end
		rescue
			l_retried := True
			retry
		end
		
	cleanup is
			-- Cleanup compiler generated temporary files (EIFGEN directory and .epr file)
		local
			l_dir: DIRECTORY
			l_dir_name: STRING
			l_retried: BOOLEAN
			l_files: LIST [STRING]
		do
			if not l_retried then
				create l_dir_name.make (compilation_directory.count + 7)
				l_dir_name.append (compilation_directory)
				l_dir_name.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
				l_dir_name.append ("EIFGEN")
				create l_dir.make (l_dir_name)
				if l_dir.exists then
					l_dir.recursive_delete
				end
				create l_dir.make (compilation_directory)
				if l_dir.exists then
					l_files := l_dir.linear_representation
					from
						l_files.start
					until
						l_files.after
					loop
						if l_files.item.substring (l_files.count - 3, l_files.count).is_equal (".epr") then
							(create {RAW_FILE}.make (l_files.item)).delete
						end
						l_files.forth
					end
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.File_lock, ["compiler temporary files cleanup", l_dir_name])
			end
		rescue
			l_retried := True
			retry
		end
		
	read_output is
			-- Read output from `output_stream'.
			-- Set result in `compiler_output'.
		require
			non_void_output_stream: output_stream /= Void
		do
			compiler_output := output_stream.read_to_end
		end
		
	read_error is
			-- Read output from `error_stream'.
			-- Set result in `compiler_error'.
		require
			non_void_output_stream: error_stream /= Void
		do
			compiler_error := error_stream.read_to_end
		end
	
feature {NONE} -- Private access

	Code_generator_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS is
			-- Options used by code generator to generate
			-- code to be compiled from Codedom compile unit
		once
			create Result.make
			Result.set_blank_lines_between_members (True)
			Result.set_else_on_closing (False)
			Result.set_indent_string ("%T")
		end

	source_generator: CODE_EIFFEL_SOURCE_FILES_GENERATOR
			-- Eiffel source files generator

	compilation_directory: STRING
			-- Compilation directory path

	system_path: STRING
			-- Path to compiled assembly
	
	load_result_in_memory: BOOLEAN
			-- Should compiled assembly be loaded in memory?

	ace_file_path: STRING
			-- Path to generated ace file

	ace_file_name: STRING is
			-- Ace file name
		local
			l_index: INTEGER
		do
			if ace_file_path /= Void then
				l_index := ace_file_path.last_index_of (Directory_separator, ace_file_path.count)
				if l_index > 0 then
					Result := ace_file_path.substring (l_index + 1, ace_file_path.count)
				else
					Result := ace_file_path.twin
				end
			end
		ensure
			exists_iff_path_exists: (ace_file_path = Void) = (Result = Void)
		end

	output_stream, error_stream: STREAM_READER
			-- Compiler process output and error streams

	compiler_error, compiler_output: STRING
			-- Compiler output and error if any

	precompile_files: LIST [STRING]
			-- Filename of dlls generated by precompilation (including path)

end -- class CODE_COMPILER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------