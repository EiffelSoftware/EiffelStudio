indexing 
	description: "Eiffel compiler CodeDom interface implementation"
	date: "$$"
	revision: "$$"

class
	CODE_COMPILER

inherit
	SYSTEM_DLL_ICODE_COMPILER
		redefine
			default_rescue
		end

	CODE_DOM_PATH
		redefine
			default_rescue
		end

	CODE_CONFIGURATION
		export
			{NONE} all
		redefine
			default_rescue
		end

	CODE_SHARED_CONTEXT
		export
			{NONE} all
		redefine
			default_rescue
		end

	CODE_FILE_HANDLER
		export
			{NONE} all
		redefine
			default_rescue
		end

	CODE_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		redefine
			default_rescue
		end

	CODE_SHARED_TEMPORARY_FILES
		export
			{NONE} all
		redefine
			default_rescue
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		redefine
			default_rescue
		end

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
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromSource"])
			(create {SECURITY_PERMISSION}.make (feature {SECURITY_PERMISSION_FLAG}.unmanaged_code)).assert
			initialize (a_options)
			if is_initialized then
				source_generator.generate (a_source)
				compile
				Result := last_compilation_results
			else
				create Result.make (a_options.temp_files)
				l_res := Result.errors.add (create {SYSTEM_DLL_COMPILER_ERROR}.make_with_file_name ("", 0, 0, "0", "Compiler initialization failed"))
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromSource"])
		ensure then
			non_void_results: Result /= Void
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
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromSourceBatch"])
			(create {SECURITY_PERMISSION}.make (feature {SECURITY_PERMISSION_FLAG}.unmanaged_code)).assert
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
				l_res := Result.errors.add (create {SYSTEM_DLL_COMPILER_ERROR}.make_with_file_name ("", 0, 0, "0", "Compiler initialization failed"))
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromSourceBatch"])
		ensure then
			non_void_results: Result /= Void
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
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromFile"])
			(create {SECURITY_PERMISSION}.make (feature {SECURITY_PERMISSION_FLAG}.unmanaged_code)).assert
			create l_file.make (a_file_name)
			if l_file.exists then
				l_file.open_read
				l_file.read_stream (l_file.count)
				l_file.close
				Result := compile_assembly_from_source (a_options, l_file.last_string)
			else
				create Result.make (a_options.temp_files)
				l_res := Result.errors.add (create {SYSTEM_DLL_COMPILER_ERROR}.make_with_file_name ("", 0, 0, "0", "Source file is missing"))
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_source_file, [a_file_name])
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromFile"])
		ensure then
			non_void_results: Result /= Void
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
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromFileBatch"])
			(create {SECURITY_PERMISSION}.make (feature {SECURITY_PERMISSION_FLAG}.unmanaged_code)).assert
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
						Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_source_file, [a_file_names.item (i)])
					end
					i := i + 1
				end
	 			compile
				Result := last_compilation_results;
			else
				create Result.make (a_options.temp_files)
				l_res := Result.errors.add (create {SYSTEM_DLL_COMPILER_ERROR}.make_with_file_name ("", 0, 0, "0", "Compiler initialization failed"))
			end
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromFileBatch"])
		ensure then
			non_void_results: Result /= Void
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
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromDom"])
			(create {SECURITY_PERMISSION}.make (feature {SECURITY_PERMISSION_FLAG}.unmanaged_code)).assert
			l_path := temp_files.add_extension (".es")
			create l_stream.make (l_path, feature {FILE_MODE}.Create_, feature {FILE_ACCESS}.Write, feature {FILE_SHARE}.Write)
			create l_writer.make (l_stream)
			(create {CODE_GENERATOR}).generate_code_from_compile_unit (a_compilation_unit, l_writer, Code_generator_options)
			l_writer.flush
			l_writer.close
			l_stream.close
			Result := compile_assembly_from_file (a_options, l_path)
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromDom"])
		ensure then
			non_void_results: Result /= Void
		rescue
			l_stream.close
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
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Starting CodeCompiler.CompileAssemblyFromDomBatch"])
			(create {SECURITY_PERMISSION}.make (feature {SECURITY_PERMISSION_FLAG}.unmanaged_code)).assert
			from
				l_count := a_compilation_units.length
				create l_paths.make (l_count)
			until
				i = l_count
			loop
				l_path := temp_files.add_extension (i.out + ".es")
				l_paths.put (i, l_path)
				create l_stream.make (l_path, feature {FILE_MODE}.Create_, feature {FILE_ACCESS}.Write, feature {FILE_SHARE}.Write)
				create l_writer.make (l_stream)
				(create {CODE_GENERATOR}).generate_code_from_compile_unit (a_compilation_units.item (i), l_writer, Code_generator_options)
				l_writer.flush
				l_writer.close
				l_stream.close
				i := i + 1
			end
			Result := compile_assembly_from_file_batch (a_options, l_paths)
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.log, ["Ending CodeCompiler.CompileAssemblyFromDomBatch"])
		ensure then
			non_void_results: Result /= Void
		rescue
			l_stream.close
		end

feature {NONE} -- Implementation

	project_class: CEIFFEL_PROJECT_CLASS is
			-- Eiffel compiler interface
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				create Result.make
			else
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_compiler, [])
			end
		rescue
			l_retried := True
			retry
		end
		
	initialize (a_options: SYSTEM_DLL_COMPILER_PARAMETERS) is
			-- Initialize compilation settings from `a_options'.
		require
			non_void_options: a_options /= Void
		local
			l_temp_dir: SYSTEM_STRING
			l_root_class, l_system_name, l_resource_file: STRING
			l_res: DIRECTORY_INFO
			l_project: CEIFFEL_PROJECT_CLASS
			l_properties: IEIFFEL_PROJECT_PROPERTIES
			l_sep_char: CHARACTER
		do
			-- First create temporary directory if needed
			if a_options.temp_files = Void or else a_options.temp_files.temp_dir = Void or else a_options.temp_files.temp_dir.length = 0 then
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_temporary_files, [])
				set_temp_files (create {SYSTEM_DLL_TEMP_FILE_COLLECTION}.make_from_temp_dir (feature {PATH}.get_temp_path))
			else
				set_temp_files (a_options.temp_files)
			end
			l_temp_dir := temp_files.temp_dir
			if not feature {SYSTEM_DIRECTORY}.exists (l_temp_dir) then
				l_res := feature {SYSTEM_DIRECTORY}.create_directory (l_temp_dir)
			end
			
			-- Initialize `compilation_directory' and `source_generator'
			compilation_directory := l_temp_dir
			create source_generator.make (compilation_directory)
			
			-- Finally initialize compiler
			l_project := project_class
			if l_project /= Void then
				l_project.create_in_memory_eiffel_project (compilation_directory)
				l_properties := l_project.project_properties
				
				system_path := a_options.output_assembly
				if system_path = Void or else system_path.is_empty then
					if a_options.generate_executable then
						system_path := temp_files.add_extension (".exe")
					else
						system_path := temp_files.add_extension (".dll")
					end
				end
				l_sep_char := (create {OPERATING_ENVIRONMENT}).Directory_separator
				l_system_name := system_path.substring (system_path.last_index_of (l_sep_char, system_path.count) + 1, system_path.count)
				if l_system_name.substring_index (".dll", 1) = l_system_name.count - 3 or l_system_name.substring_index (".exe", 1) = l_system_name.count - 3 then
					l_system_name.keep_head (l_system_name.count - 4)
				end
				l_properties.set_system_name (l_system_name)
				
				l_root_class := Compilation_context.root_class_name
				if l_root_class = Void or else l_root_class.is_empty then
					l_root_class := a_options.main_class
					if l_root_class = Void or else l_root_class.is_empty then
						l_root_class := default_root_class
					end
				end
				l_properties.set_root_class_name (l_root_class)
	
				if not l_root_class.is_equal ("ANY") and not l_root_class.is_equal ("NONE") then
					if Compilation_context.root_creation_routine_name /= Void then
						l_properties.set_creation_routine (Compilation_context.root_creation_routine_name)
					else
						l_properties.set_creation_routine ("make")
					end
				end
	
				if a_options.generate_executable then
					l_properties.set_project_type (feature {EIF_PROJECT_TYPES}.eif_project_types_console_application)
				else			
					l_properties.set_project_type (feature {EIF_PROJECT_TYPES}.eif_project_types_class_library)
				end
	
				l_properties.set_target_clr_version (Clr_version)
				l_properties.clusters.add_cluster ("root_cluster", "", compilation_directory)
				
				if a_options.win_32_resource /= Void then
					l_resource_file := compilation_directory + l_sep_char.out + l_system_name + ".rc"
					copy_file (a_options.win_32_resource, l_resource_file)
					if last_copy_successful then
						temp_files.add_file (l_resource_file, False)
					end
				end
				
				if precompile /= Void then
					l_properties.set_precompiled_library (precompile)
				end
	
				if metadata_cache /= Void then
					l_properties.set_metadata_cache_path (metadata_cache)
				end
	
				l_properties.set_generate_debug_info (a_options.include_debug_information)
				load_result_in_memory := a_options.generate_in_memory
				evidence := a_options.evidence
				compiler := l_project.compiler
				is_initialized := True
			end
		ensure
			non_void_temp_files: is_initialized implies temp_files /= Void
			valid_compilation_directory: is_initialized implies compilation_directory /= Void and then (create {DIRECTORY}.make (compilation_directory)).exists
			non_void_source_generator: is_initialized implies source_generator /= Void
			non_void_compiler: is_initialized implies compiler /= Void
			non_void_system_path: is_initialized implies system_path /= Void
			valid_system_path: is_initialized implies not system_path.is_empty
		end
	
	compile is
			-- Compile all `.e' files in directory `compilation_directory'.
			-- Put resulting dlls and pdb in `system_path' folder.
		local
			l_dir: DIRECTORY
			l_dir_name, l_system_dir, l_file: STRING
			l_sep_char: CHARACTER
			l_files: LIST [STRING]
			l_ass: RAW_FILE
			l_array: NATIVE_ARRAY [INTEGER_8]
			l_file_stream: FILE_STREAM
		do
--			compiler.add_output_error ((create {IEIFFEL_COMPILER_EVENTS_OUTPUT_ERROR_EVENT_HANDLER}.make (Current, $on_error)))
--			compiler.add_output_string ((create {IEIFFEL_COMPILER_EVENTS_OUTPUT_STRING_EVENT_HANDLER}.make (Current, $on_output)))
			compiler.compile (feature {EIF_COMPILATION_MODE}.eif_compilation_mode_finalize)
			create last_compilation_results.make (temp_files)
			(create {SECURITY_PERMISSION}.make_from_flag (feature {SECURITY_PERMISSION_FLAG}.Control_evidence)).assert
			last_compilation_results.set_evidence (evidence)
			last_compilation_results.set_native_compiler_return_value (1)
			if compiler.was_compilation_successful then
				l_sep_char := (create {OPERATING_ENVIRONMENT}).Directory_separator
				create l_dir_name.make (compilation_directory.count + 14)
				l_dir_name.append (compilation_directory)
				l_dir_name.append_character (l_sep_char)
				l_dir_name.append ("EIFGEN")
				l_dir_name.append_character (l_sep_char)
				l_dir_name.append ("F_Code")
				create l_dir.make (l_dir_name)
				if l_dir.exists then
					l_system_dir := system_path.substring (1, system_path.last_index_of (l_sep_char, system_path.count) - 1)
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
								copy_file (l_dir_name + l_sep_char.out + l_file, l_system_dir + l_sep_char.out + l_file)									
							end
							l_files.forth
						end
						create l_ass.make (system_path)
						if l_ass.exists then
							last_compilation_results.set_path_to_assembly (system_path)
							last_compilation_results.set_native_compiler_return_value (0)
							if load_result_in_memory then
								create l_file_stream.make (system_path, feature {FILE_MODE}.Open, feature {FILE_ACCESS}.Read, feature {FILE_SHARE}.Read)
								create l_array.make (l_file_stream.length.to_integer)
								(create {SECURITY_PERMISSION}.make_from_flag (feature {SECURITY_PERMISSION_FLAG}.Control_evidence)).assert
								last_compilation_results.set_compiled_assembly (feature {ASSEMBLY}.load (l_array, Void, evidence))
								l_file_stream.close
							end
						end
					end
				else
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_directory, [compilation_directory + l_sep_char.out + "EIFGEN" + l_sep_char.out + "F_Code"])
				end
			end
			cleanup
			reset_temp_files
			compiler := Void
			source_generator := Void
			compilation_directory := Void
		ensure
			non_void_results: last_compilation_results /= Void
		end
		
	cleanup is
			-- Cleanup compiler generated temporary files (EIFGEN directory)
		local
			l_dir: DIRECTORY
			l_dir_name: STRING
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_dir_name.make (compilation_directory.count + 7)
				l_dir_name.append (compilation_directory)
				l_dir_name.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
				l_dir_name.append ("EIFGEN")
				create l_dir.make (l_dir_name)
				l_dir.recursive_delete
			else
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.File_lock, [l_dir_name, "compiler temporary files cleanup"])
			end
		rescue
			l_retried := True
			retry
		end
		
	default_rescue is
			-- Handle exceptions
		do
			Event_manager.process_exception
		end

feature {NONE} -- Compiler callbacks

	on_error (bstr_full_error, bstr_short_error, bstr_code, bstr_file_name: SYSTEM_STRING; ul_line, ul_col: INTEGER) is
			-- Record error in `last_error'.
		require
			non_void_compilation_results: last_compilation_results /= Void
		local
			l_res: INTEGER
		do	
			l_res := last_compilation_results.errors.add (create {SYSTEM_DLL_COMPILER_ERROR}.make (bstr_file_name, ul_line, ul_col, bstr_code, bstr_full_error))
		end

	on_output (a_output: SYSTEM_STRING) is
			-- Append `a_output' to `output'.
		require
			non_void_compilation_results: last_compilation_results /= Void
		local
			l_res: INTEGER
		do
			l_res := last_compilation_results.output.add (a_output)
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

	compiler: CEIFFEL_COMPILER
			-- COM compiler proxy object

	system_path: STRING
			-- Path to compiled assembly
	
	load_result_in_memory: BOOLEAN
			-- Should compiled assembly be loaded in memory?

	evidence: EVIDENCE
			-- Evidence associated with compilation process

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