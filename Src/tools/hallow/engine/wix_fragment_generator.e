note
	description: "[
		A WiX generator used to generate XML content fragments adhearing to the WiX schema.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	WIX_FRAGMENT_GENERATOR

inherit
	SYSTEM_OBJECT

	I_WIX_FRAGMENT_GENERATOR

feature -- Basic operations

	generate (a_options: I_OPTIONS; a_stream: TEXT_WRITER)
			-- Generate fragment XML with options `a_options'
		local
			l_writer: XML_TEXT_WRITER
		do
			reset

			create l_writer.make (a_stream)
			l_writer.set_formatting ({FORMATTING}.indented)
			generate_root (a_options, l_writer)
			l_writer.flush
		end

	reset
			-- Resets internal for new generation
		do
			create name_table.make (512, {STRING_COMPARER}.invariant_culture_ignore_case)
			create component_names.make
			component_count := 1
			directory_count := 1
			file_count := 1
		ensure
			name_table_attached: name_table /= Void
		end

feature {NONE} -- Element generation

	generate_root (a_options: I_OPTIONS; a_writer: XML_TEXT_WRITER)
			-- Generates a WiX fragment.
			--
			-- `a_options': The options that determine how all elements are generated.
			-- `a_writer': The writer that all generated elements will be written to.
		require
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
			a_writer_attached: a_writer /= Void
		local
			l_dir_id: SYSTEM_STRING
			l_dir: DIRECTORY_INFO
			l_expressions: NATIVE_ARRAY [SYSTEM_STRING]
			l_expr: SYSTEM_STRING
			l_id_expression: REGEX
			l_count,i : INTEGER
		do
			create l_dir.make (a_options.directory)

				-- Start generation					
			if a_options.generate_include then
				a_writer.write_start_element ({WIX_CONSTANTS}.include_tag, {WIX_CONSTANTS}.wix_ns)
			else
				a_writer.write_start_element ({WIX_CONSTANTS}.wix_tag, {WIX_CONSTANTS}.wix_ns)
				a_writer.write_start_element ({WIX_CONSTANTS}.fragment_tag, {WIX_CONSTANTS}.wix_ns)
			end

			if a_options.generate_x64_preprocessors then
				a_writer.write_processing_instruction ({WIX_CONSTANTS}.pi_ifndef, "IsWin64")
				a_writer.write_processing_instruction ({WIX_CONSTANTS}.pi_ifdef, "x64")
				a_writer.write_processing_instruction ({WIX_CONSTANTS}.pi_define, "IsWin64 = %"yes%"")
				a_writer.write_processing_instruction ({WIX_CONSTANTS}.pi_else, Void)
				a_writer.write_processing_instruction ({WIX_CONSTANTS}.pi_define, "IsWin64 = %"no%"")
				a_writer.write_processing_instruction ({WIX_CONSTANTS}.pi_endif, Void)
				a_writer.write_processing_instruction ({WIX_CONSTANTS}.pi_endif, Void)
			end

			if a_options.use_conditional_expressions then
				create l_id_expression.make ("^[ \t]*[a-z_][a-z0-9_]*[ \t]*$", {REGEX_OPTIONS}.culture_invariant | {REGEX_OPTIONS}.ignore_case)
				l_expressions := a_options.conditional_expressions
				l_count := l_expressions.count
				from i := 0 until i = l_count loop
					l_expr := l_expressions.item (i)
					if l_id_expression.is_match (l_expr) then
						a_writer.write_processing_instruction ({WIX_CONSTANTS}.pi_ifdef, l_expr)
					else
						a_writer.write_processing_instruction ({WIX_CONSTANTS}.pi_if, l_expr)
					end
					i := i + 1
				end
			end

			if a_options.use_root_directory_ref then
				l_dir_id := a_options.root_directory_ref_id
				a_writer.write_start_element ({WIX_CONSTANTS}.directory_ref_tag)
				a_writer.write_attribute_string ({WIX_CONSTANTS}.id_attribute, l_dir_id)
			else
				l_dir_id := semantic_name (l_dir.full_name, a_options, {WIX_CONSTANTS}.directory_tag, directory_prefix, False)
				a_writer.write_start_element ({WIX_CONSTANTS}.directory_tag)
				a_writer.write_attribute_string ({WIX_CONSTANTS}.id_attribute, l_dir_id)
				if a_options.generate_include then
					a_writer.write_attribute_string ({WIX_CONSTANTS}.name_attribute, ".")
				else
					a_writer.write_attribute_string ({WIX_CONSTANTS}.name_attribute, l_dir.name)
				end
				a_writer.write_attribute_string ({WIX_CONSTANTS}.file_source_attribute, format_path (l_dir.full_name, a_options))
			end

			generate_directory_content (l_dir, l_dir_id, True, a_options, a_writer)

			a_writer.write_end_element

			if a_options.use_grouped_components then
				generate_component_group (a_options, a_writer)
			end

			if a_options.use_conditional_expressions then
				from i := 0 until i = l_count loop
					a_writer.write_processing_instruction ({WIX_CONSTANTS}.pi_endif, Void)
					i := i + 1
				end
			end

				-- End generation
			a_writer.write_end_element
			if not a_options.generate_include then
				a_writer.write_end_element
			end
		end

	generate_component_group (a_options: I_OPTIONS; a_writer: XML_TEXT_WRITER)
			-- Generates a ComponentGroup element
			--
			-- `a_options': The options that determine how the element is generated.
			-- `a_writer': The writer that the generated element will be written to.
		require
			a_options_attached: a_options /= Void
			use_grouped_components: a_options.use_grouped_components
			can_read_options_a_options: a_options.can_read_options
			a_writer_attached: a_writer /= Void
		local
			l_enum: STRING_ENUMERATOR
		do
			a_writer.write_start_element ({WIX_CONSTANTS}.component_group_tag)
			a_writer.write_attribute_string ({WIX_CONSTANTS}.id_attribute, a_options.component_group_name)
			l_enum := component_names.get_enumerator
			from l_enum.reset until not l_enum.move_next loop
				a_writer.write_start_element ({WIX_CONSTANTS}.component_ref_tag)
				a_writer.write_attribute_string ({WIX_CONSTANTS}.id_attribute, l_enum.current_)
				a_writer.write_end_element
			end
			a_writer.write_end_element
		end

	generate_directory (a_dir: DIRECTORY_INFO; a_options: I_OPTIONS; a_writer: XML_TEXT_WRITER)
			-- Generates a single WiX Directory element.
			--
			-- `a_dir': Directory to generate an element for.
			-- `a_options': The options that determine how the element is generated.
			-- `a_writer': The writer that the generated element will be written to.
		require
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
			a_writer_attached: a_writer /= Void
			a_dir_attached: a_dir /= Void
			a_dir_exists: a_dir.exists
		local
			l_dir_id: SYSTEM_STRING
		do
			l_dir_id := semantic_name (a_dir.full_name, a_options, {WIX_CONSTANTS}.directory_tag, directory_prefix, False)
			a_writer.write_start_element ({WIX_CONSTANTS}.directory_tag)
			a_writer.write_attribute_string ({WIX_CONSTANTS}.id_attribute, l_dir_id)

			a_writer.write_attribute_string ({WIX_CONSTANTS}.name_attribute, a_dir.name)
			a_writer.write_attribute_string ({WIX_CONSTANTS}.file_source_attribute, format_path (a_dir.full_name, a_options))

			generate_directory_content (a_dir, l_dir_id, False, a_options, a_writer)

			a_writer.write_end_element
		end

	generate_directory_content (a_dir: DIRECTORY_INFO; a_dir_id: SYSTEM_STRING; a_root: BOOLEAN; a_options: I_OPTIONS; a_writer: XML_TEXT_WRITER)
			-- Generates WiX Compent, File and Directory elements based on the content of a directory.
			--
			-- `a_dir': A directory to scan and generated XML elements base on content.
			-- `a_dir_id': The directory ID to generate content for.
			-- `a_root': Indicates if content is for the root directory
			-- `a_options': The options that determine how the element is generated.
			-- `a_writer': The writer that the generated element will be written to.
		require
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
			a_writer_attached: a_writer /= Void
			a_dir_attached: a_dir /= Void
			a_dir_exists: a_dir.exists
			not_a_dir_id_empty: not {SYSTEM_STRING}.is_null_or_empty (a_dir_id)
		local
			l_files: NATIVE_ARRAY [FILE_INFO]
			l_dirs: NATIVE_ARRAY [DIRECTORY_INFO]
			l_add_files: BOOLEAN
			l_count, i: INTEGER
		do
				-- Generate files
			l_add_files := a_options.use_directory_include_pattern implies a_options.directory_include_pattern.is_match (a_dir.full_name)
			if l_add_files then
					-- Reset l_add_files so we can determine if a CreateFolder tag needs to be generated.
				l_add_files := False
				l_files := a_dir.get_files

				if l_files.count > 0 then
					l_files := files_for_options (l_files, a_options)
					l_count := l_files.count
					if l_count > 0 then
							-- There are files so there is no need to generate a CreateFolder tag.
						l_add_files := True

						if a_options.generate_single_file_components then
							from i := 0 until i = l_count loop
								generate_component (l_files.item (i).full_name, agent generate_file (l_files.item (i), a_root, ?, ?), a_options, a_writer)
								i := i + 1
							end
						else
							generate_component (a_dir.full_name, agent generate_files (l_files, a_root, ?, ?), a_options, a_writer)
						end
					end
				end
			end

			if not a_root and then not l_add_files then
					-- The path is a directory, and no files have been added.
					-- We need to be sure that the directory is always created with the CreateFolder tag.
				generate_component (a_dir.full_name, agent (ia_dir_id: SYSTEM_STRING; ia_options: I_OPTIONS; ia_writer: XML_TEXT_WRITER)
					do
						ia_writer.write_element_string ({WIX_CONSTANTS}.create_folder_tag, Void)
						ia_writer.write_start_element ({WIX_CONSTANTS}.remove_folder_tag)
						ia_writer.write_attribute_string ({WIX_CONSTANTS}.id_attribute, ia_dir_id)
						ia_writer.write_attribute_string ({WIX_CONSTANTS}.on_attribute, {WIX_CONSTANTS}.uninstall_value)
						ia_writer.write_end_element
					end (a_dir_id, ?, ?), a_options, a_writer)
			end


				-- Generate directories
			if a_options.include_subdirectories then
				l_dirs := a_dir.get_directories
				if l_dirs.count > 0 then
					l_dirs := directories_for_options (l_dirs, a_options)
					if l_dirs.count > 0 then
						generate_directories (l_dirs, a_options, a_writer)
					end
				end
			end
		end

	generate_directories (a_dirs: NATIVE_ARRAY [DIRECTORY_INFO]; a_options: I_OPTIONS; a_writer: XML_TEXT_WRITER)
			-- Generates WiX Directory elements.
			--
			-- `a_dirs': An array of directories to generate Directory elements for
			-- `a_options': The options that determine how the element is generated.
			-- `a_writer': The writer that the generated element will be written to.
		require
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
			a_writer_attached: a_writer /= Void
			a_dirs_attached: a_dirs /= Void
			not_a_dirs_is_empty: a_dirs.count > 0
		local
			l_di: DIRECTORY_INFO
			l_count, i: INTEGER
		do
			l_count := a_dirs.count
			from i := 0 until i = l_count loop
				l_di := a_dirs.item (i)
				if l_di /= Void then
					generate_directory (l_di, a_options, a_writer)
				end
				i := i + 1
			end
		end

	generate_component (a_path: SYSTEM_STRING; a_content_gen: PROCEDURE [WIX_FRAGMENT_GENERATOR, TUPLE [I_OPTIONS, XML_TEXT_WRITER]]; a_options: I_OPTIONS; a_writer: XML_TEXT_WRITER)
			-- Generates a single WiX Component element and its content using a generator agent.
			--
			-- `a_path': Full path to a disk entity that the component is generated for.
			-- `a_content_gen': An agent used to generate the Component element's content.
			-- `a_options': The options that determine how the element is generated.
			-- `a_writer': The writer that the generated element will be written to.
		require
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
			a_writer_attached: a_writer /= Void
			a_content_gen_attached: a_content_gen /= Void
			--a_content_gen_has_attached_target: a_content_gen.target /= Void
		local
			l_name: SYSTEM_STRING
			i: INTEGER
		do
			l_name := semantic_name (a_path, a_options, {WIX_CONSTANTS}.component_tag, component_prefix, False)
			i := component_names.add (l_name)
			a_writer.write_start_element ({WIX_CONSTANTS}.component_tag)
			a_writer.write_attribute_string ({WIX_CONSTANTS}.id_attribute, l_name)
			a_writer.write_attribute_string ({WIX_CONSTANTS}.guid_attribute, guid (a_options))

			if a_options.generate_x64_preprocessors then
				a_writer.write_attribute_string ({WIX_CONSTANTS}.win64_attribute, "$(var.IsWin64)")
			end
			a_writer.write_attribute_string ({WIX_CONSTANTS}.key_path_attribute, {WIX_CONSTANTS}.yes_value)

			a_content_gen.call ([a_options, a_writer])

			a_writer.write_end_element
		end

	generate_files (a_files: NATIVE_ARRAY [FILE_INFO]; a_root: BOOLEAN; a_options: I_OPTIONS; a_writer: XML_TEXT_WRITER)
			-- Generates WiX File elements.
			--
			-- `a_files': An array of files to generate File elements for
			-- `a_root': Indicates if files belong to the root directory
			-- `a_options': The options that determine how the element is generated.
			-- `a_writer': The writer that the generated element will be written to.
		require
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
			a_writer_attached: a_writer /= Void
			a_files_attached: a_files /= Void
			not_a_files_is_empty: a_files.count > 0
		local
			l_fi: FILE_INFO
			l_count, i: INTEGER
		do
			l_count := a_files.count
			from i := 0 until i = l_count loop
				l_fi := a_files.item (i)
				if l_fi /= Void then
					generate_file (a_files.item (i), a_root, a_options, a_writer)
				end
				i := i + 1
			end
		end

	generate_file (a_file: FILE_INFO; a_root: BOOLEAN; a_options: I_OPTIONS; a_writer: XML_TEXT_WRITER)
			-- Generates a single WiX File element.
			--
			-- `a_file': File to generate an element for.
			-- `a_root': Indicates if file is part of the directory structure root
			-- `a_options': The options that determine how the element is generated.
			-- `a_writer': The writer that the generated element will be written to.
		require
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
			a_writer_attached: a_writer /= Void
			a_file_attached: a_file /= Void
			a_file_exists: a_file.exists
		local
			l_id: INTEGER
		do
			a_writer.write_start_element ({WIX_CONSTANTS}.file_tag)
			a_writer.write_attribute_string ({WIX_CONSTANTS}.id_attribute, semantic_name (a_file.full_name, a_options, {WIX_CONSTANTS}.file_tag, Void, False))

			a_writer.write_attribute_string ({WIX_CONSTANTS}.name_attribute, a_file.name)

			if not a_options.for_merge_modules then
				l_id := 1
				if a_options.use_disk_id then
					l_id := a_options.disk_id
				end
				a_writer.write_attribute_string ({WIX_CONSTANTS}.disk_id_attribute, {SYSTEM_CONVERT}.to_string (l_id))
			end

			if a_root and then a_options.use_root_directory_ref then
				a_writer.write_attribute_string ({WIX_CONSTANTS}.source_attribute, format_path (a_file.full_name, a_options))
			end

			a_writer.write_end_element
		end

feature {NONE} -- Attribute generation

	guid (a_options: I_OPTIONS): SYSTEM_STRING
			-- Create a GUID based on `a_options'
			--
			-- `a_options': Options that determine how the resulting GUID string is generated
			-- `Result': A string representation of a GUID.
			--           Note: This may not be a valid GUID string.
		require
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
		do
			Result := {GUID}.new_guid.to_string ("D").to_upper
		ensure
			not_result_is_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
		end

	semantic_name (a_path: SYSTEM_STRING; a_options: I_OPTIONS; a_tag_name: SYSTEM_STRING; a_prefix: SYSTEM_STRING; a_use_short_name: BOOLEAN): SYSTEM_STRING
			-- Create a name based on specified user options `a_options'
			--
			-- `a_path': Full path to disk item to create a semantic name for.
			-- `a_options': Options that determine how the resulting name should be generated.
			-- `a_tag_name': A XML element tag name representing the name of the element the name is generated for.
			-- `a_prefix': An optional prefix to prepend a semantic generated name.
			-- `a_use_short_name': Uses a short name for size constraints.
			-- `Result': A generated name
		require
			not_a_path_is_empty: not {SYSTEM_STRING}.is_null_or_empty (a_path)
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
			not_a_tag_name_is_empty: not {SYSTEM_STRING}.is_null_or_empty (a_tag_name)
		local
			l_name: SYSTEM_STRING
			l_prefix: SYSTEM_STRING
			l_base_name: SYSTEM_STRING
			l_sb: STRING_BUILDER
			l_cd: SYSTEM_STRING
			l_path: SYSTEM_STRING
			l_len: INTEGER
			l_index: SYSTEM_STRING
			i: NATURAL_64
		do
			if a_options.use_semantic_names then

					-- Removed root directory and separator/device character from path
				if a_options.directory.length < a_path.length then
					l_path := a_path.substring (a_options.directory.length + 1)
					if a_use_short_name then
						l_cd := {ENVIRONMENT}.current_directory
						{ENVIRONMENT}.current_directory := a_options.directory
						l_path := get_short_path (l_path, a_options)
						{ENVIRONMENT}.current_directory := l_cd
					end

					create l_sb.make (l_path)
					l_sb := l_sb.replace ({PATH}.directory_separator_char, '.')
					l_sb := l_sb.replace ({PATH}.alt_directory_separator_char, '.')
					l_sb := l_sb.replace ({PATH}.volume_separator_char, '.')
					l_name := l_sb.to_string
				else
					l_name := {PATH}.get_file_name (a_path)
				end

					-- Ensure we have a default prefix
				l_prefix := a_prefix
				if l_prefix = Void then
					l_prefix := {SYSTEM_STRING}.empty
				end

					-- Create name
				if a_options.has_semantic_name_prefix then
					Result := {SYSTEM_STRING}.concat (l_prefix, a_options.semantic_name_prefix, l_name)
				else
					Result := {SYSTEM_STRING}.concat (l_prefix, l_name)
				end

				if a_options.for_merge_modules then
					l_len := max_wix_module_id_length
				else
					l_len := max_wix_id_length
				end

					-- Ensure path uniqueness
				Result := format_identifier (Result)
				if a_use_short_name and Result.length > l_len then
					Result := Result.substring (0, l_len - 1)
				end
				l_base_name := Result
				from i := 2 until not name_table.contains (Result) loop
					l_index := {SYSTEM_CONVERT}.to_string (i)
					if a_use_short_name and l_base_name.length + l_index.length > l_len then
						l_base_name := l_base_name.substring (0, (l_len - 1) - l_index.length)
					end
					Result := {SYSTEM_STRING}.concat (l_base_name, l_index)
					i := i + 1
				end

				if not a_use_short_name and then Result.length > l_len then
						-- Name is too long so try using a shorter name
					Result := semantic_name (a_path, a_options, a_tag_name, a_prefix, True)
				else
					name_table.add (Result, True)
				end
			else
				Result := {SYSTEM_STRING}.concat (a_tag_name.to_lower ({CULTURE_INFO}.invariant_culture), underscore, get_count (a_tag_name))
				increase_count (a_tag_name)
			end
		ensure
			not_result_is_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
		end

	format_identifier (a_id: SYSTEM_STRING): SYSTEM_STRING
			-- Formats identifier `a_id' to to ensure a valid WiX identifier
			--
			-- `a_id': An identifier
			-- `Result': A valid WiX identifier
		require
			not_a_id_is_empty: not {SYSTEM_STRING}.is_null_or_empty (a_id)
		local
			l_sb: STRING_BUILDER
			l_count, i: INTEGER
			c: CHARACTER
		do
			create l_sb.make (a_id)
			l_count := a_id.length

				-- Must begin with a letter or underscore
			c := a_id.chars (0)
			if not ({DOTNET_CHARACTER}.is_letter (c) or c = '_') then
				l_sb.set_chars (0, '_')
			end

				-- Check all other character
			from i := 1 until i = l_count loop
				c := a_id.chars (i)
				if not ({DOTNET_CHARACTER}.is_letter_or_digit (c) or c = '_' or c = '.') then
					l_sb.set_chars (i, '_')
				end
				i := i + 1
			end
			Result := l_sb.to_string
		ensure
			not_result_is_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
		end

	format_path (a_path: SYSTEM_STRING; a_options: I_OPTIONS): SYSTEM_STRING
			-- Retrieves directory path for `a_path' given user options `a_options'
			--
			-- `a_path': Full path to an entity on disk to format.
			-- `a_options': The options to used to determine how the resulting path is formatted.
			-- `Result': A formatted path.
		require
			not_a_path_is_empty: not {SYSTEM_STRING}.is_null_or_empty (a_path)
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
		local
			l_end_path: SYSTEM_STRING
		do
			if a_options.use_directory_alias then
				l_end_path := a_path.substring (a_options.directory.length)
				Result := {SYSTEM_STRING}.concat (a_options.directory_alias, l_end_path)
			else
				Result := a_path
			end
		ensure
			not_result_is_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
		end

feature {NONE} --

	files_for_options (a_files: NATIVE_ARRAY [FILE_INFO]; a_options: I_OPTIONS): NATIVE_ARRAY [FILE_INFO]
			-- Processes files based on expression in the passed options to remove an invalid files.
			--
			-- `a_files': Files to process
			-- `a_options': Options to use to determin what files are added or removed
		require
			a_files_attached: a_files /= Void
			not_a_files_is_empty: a_files.count > 0
			a_options_attached: a_options /= Void
		local
			l_inc, l_ex: BOOLEAN
			l_ep_priority: BOOLEAN
			l_iexp, l_eexp: REGEX
			l_fi: FILE_INFO
			l_name: SYSTEM_STRING
			l_result: ARRAYED_LIST [FILE_INFO]
			l_add: BOOLEAN
			l_count, i: INTEGER
		do
			l_inc := a_options.use_file_include_pattern
			l_ex := a_options.use_file_exclude_pattern
			if l_inc or l_ex then
				if l_inc and l_ex then
					l_ep_priority := a_options.use_exclude_pattern_priority
				end
				if l_inc then
					l_iexp := a_options.file_include_pattern
				end
				if l_ex then
					l_eexp := a_options.file_excluded_pattern
				end

				l_count := a_files.count
				create l_result.make (l_count)
				from i := 0 until i = l_count loop
					l_add := True

					l_fi := a_files.item (i)
					l_name := l_fi.full_name
					if l_ex then
						l_add := not l_eexp.is_match (l_name)
					end
					if l_inc and then (l_ex implies not l_add) then
						if l_ep_priority implies l_add then
							l_add := l_iexp.is_match (l_name)
						end
					end

					if l_add then
						l_result.extend (l_fi)
					end

					i := i + 1
				end
				create Result.make (l_result.count)
				{SYSTEM_ARRAY}.copy_array_array_integer_32 (({NATIVE_ARRAY [FILE_INFO]}) [({ARRAY [FILE_INFO]}) #? l_result], Result, l_result.count)
			else
				Result := a_files
			end
		end

	directories_for_options (a_dirs: NATIVE_ARRAY [DIRECTORY_INFO]; a_options: I_OPTIONS): NATIVE_ARRAY [DIRECTORY_INFO]
			-- Processes directories based on expression in the passed options to remove an invalid directory.
			--
			-- `a_dirs': Directories to process
			-- `a_options': Options to use to determin what files are added or removed
		require
			a_dirs_attached: a_dirs /= Void
			not_a_dirs_is_empty: a_dirs.count > 0
			a_options_attached: a_options /= Void
		local
			l_inc, l_ex: BOOLEAN
			l_ep_priority: BOOLEAN
			l_iexp, l_eexp: REGEX
			l_di: DIRECTORY_INFO
			l_name: SYSTEM_STRING
			l_result: ARRAYED_LIST [DIRECTORY_INFO]
			l_add: BOOLEAN
			l_count, i: INTEGER
		do
			l_inc := a_options.use_directory_include_pattern
			l_ex := a_options.use_directory_exclude_pattern
			if l_inc or l_ex then
				if l_inc and l_ex then
					l_ep_priority := a_options.use_exclude_pattern_priority
				end

				if l_inc then
					l_iexp := a_options.directory_include_pattern
				end
				if l_ex then
					l_eexp := a_options.directory_excluded_pattern
				end

				l_count := a_dirs.count
				create l_result.make (l_count)
				from i := 0 until i = l_count loop
					l_add := True

					l_di := a_dirs.item (i)
					l_name := l_di.full_name
					if l_ex then
						l_add := not l_eexp.is_match (l_name)
					end
				-- Now handled when adding files.
--					if l_inc and then (l_ex implies not l_add) then
--						if l_ep_priority implies l_add then
--							l_add := l_iexp.is_match (l_name)
--						end
--					end

					if l_add then
						l_result.extend (l_di)
					end

					i := i + 1
				end
				create Result.make (l_result.count)
				{SYSTEM_ARRAY}.copy_array_array_integer_32 (({NATIVE_ARRAY [DIRECTORY_INFO]}) [({ARRAY [DIRECTORY_INFO]}) #? l_result.to_array], Result, l_result.count)
			else
				Result := a_dirs
			end
		end

feature {NONE} -- Tables

	name_table: HASHTABLE
			-- Table used to prevent name clashes.
			-- Key: Name
			-- Value: Boolean, always True if table contain a name

	directory_table: HASHTABLE
			-- Table of directories to include
			-- Key: Directory path
			-- Value: Boolean

	component_names: STRING_COLLECTION
			-- Collection of generated components

feature {NONE} -- Counters

	get_count (a_name: SYSTEM_STRING): NATURAL_32
			-- Retrieve counter for `a_name'
			--
			-- `a_name': A XML tag name to retrieve the count for.
			-- `Result': A count based on `a_name'.
		require
			not_a_name_is_empty: not {SYSTEM_STRING}.is_null_or_empty (a_name)
		do
			if a_name = {WIX_CONSTANTS}.file_tag then
				Result := file_count
			elseif a_name = {WIX_CONSTANTS}.directory_tag then
				Result := directory_count
			elseif a_name = {WIX_CONSTANTS}.component_tag then
				Result := component_count
			else
				check False end
			end
		end

	increase_count (a_name: SYSTEM_STRING)
			-- Increase counter, for `a_name', by one.
			--
			-- `a_name': A XML tag name to increment the count for.
		require
			not_a_name_is_empty: not {SYSTEM_STRING}.is_null_or_empty (a_name)
		do
			if a_name = {WIX_CONSTANTS}.file_tag then
				file_count := file_count + 1
			elseif a_name = {WIX_CONSTANTS}.directory_tag then
				directory_count := directory_count + 1
			elseif a_name = {WIX_CONSTANTS}.component_tag then
				component_count := component_count + 1
			else
				check False end
			end
		ensure
			count_increased: get_count (a_name) = old get_count (a_name) + 1
		end

	component_count: NATURAL_32
			-- Component name counter

	directory_count: NATURAL_32
			-- Directory name counter

	file_count: NATURAL_32
			-- File name counter

feature {NONE} -- Path utilities

	frozen get_short_path_name (a_path: SYSTEM_STRING; a_options: I_OPTIONS): SYSTEM_STRING
			-- Retrieves the short path file or directory name of `a_path' using the options `a_options' to indicate
			-- how the path is returned.
		require
			not_a_path_is_empty: not {SYSTEM_STRING}.is_null_or_empty (a_path)
			a_path_exists: {SYSTEM_FILE}.exists (a_path) or {SYSTEM_DIRECTORY}.exists (a_path)
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
		do
			Result := {PATH}.get_file_name (internal_get_short_path (a_path, a_options))
		ensure
			not_result_is_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
		end

	frozen get_short_path (a_path: SYSTEM_STRING; a_options: I_OPTIONS): SYSTEM_STRING
			-- Retrieves the short path to a file or a directory of `a_path' using the options `a_options' to indicate
			-- how the path is returned.
		require
			not_a_path_is_empty: not {SYSTEM_STRING}.is_null_or_empty (a_path)
			a_path_exists: {SYSTEM_FILE}.exists (a_path) or {SYSTEM_DIRECTORY}.exists (a_path)
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
		do
			Result := internal_get_short_path (a_path, a_options)
		ensure
			not_result_is_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
		end

	frozen internal_get_short_path (a_path: SYSTEM_STRING; a_options: I_OPTIONS): SYSTEM_STRING
			-- Retrieves the short path to a file or a directory of `a_path' using the options `a_options' to indicate
			-- how the path is returned.
		require
			not_a_path_is_empty: not {SYSTEM_STRING}.is_null_or_empty (a_path)
			a_path_exists: {SYSTEM_FILE}.exists (a_path) or {SYSTEM_DIRECTORY}.exists (a_path)
			a_options_attached: a_options /= Void
			can_read_options_a_options: a_options.can_read_options
		local
			l_long: POINTER
			l_short: POINTER
			l_len: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				l_len := {NATIVE_METHODS}.max_path

					-- Allocate resources
				l_long := {MARSHAL}.string_to_co_task_mem_uni (a_path)
				l_short := {MARSHAL}.alloc_co_task_mem ({NATIVE_METHODS}.sizeof_tchar * (l_len + 1))

				l_len := {NATIVE_METHODS}.get_short_path_name (l_long, l_short, l_len)
				check l_len_positive: l_len > 0 end
				if l_len > 0 then
					Result := {MARSHAL}.ptr_to_string_uni (l_short, l_len)
				end
			end

				-- Clean up allocated resources
			if l_long /= default_pointer then
				{MARSHAL}.free_co_task_mem (l_long)
			end
			if l_long /= default_pointer then
				{MARSHAL}.free_co_task_mem (l_short)
			end
		ensure
			not_result_is_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
		rescue
			retried := True
			retry
		end

feature {NONE} -- Constants

	directory_prefix: SYSTEM_STRING = "Dir."
	component_prefix: SYSTEM_STRING = "Comp."
	underscore: SYSTEM_STRING = "_"

	max_wix_id_length: INTEGER = 72
	max_wix_module_id_length: INTEGER = 35
			-- Maximum length allowed for WiX identifiers

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
