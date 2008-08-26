indexing
	description: "[
		Provides access to application specific options for use with initializing applications or processing data.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	APPLICATION_OPTIONS

inherit
	SHARED_STATUS_MESSAGES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_params: IAPPLICATION_PARAMETERS) is
			-- Initialize application options using application parameters `a_params'.
		require
			a_params_attached: a_params /= Void
			a_params_is_readable: a_params.is_readable
		local
			l_name: STRING
			l_stub: BOOLEAN
			l_interface: BOOLEAN
			l_both: BOOLEAN
		do
			l_stub := a_params.generate_stub
			l_interface := a_params.generate_interface
			l_both := l_stub and l_interface

				-- Set class name and output file name
			if a_params.has_class_name then
				l_name := a_params.class_name.as_upper
			else
				l_name := default_class_name
			end

			if l_stub then
				stub_class_name := l_name.as_upper
				stub_class_name.append (once "_IMPL")
				stub_output_file_name := stub_class_name.as_lower
				stub_output_file_name.append (eiffel_file_extension)
			end
			interface_class_name := l_name.as_upper
			interface_output_file_name := l_name.as_lower
			interface_output_file_name.append (eiffel_file_extension)

				-- Set generation options
			generate_stub := l_stub
			generate_interface := l_interface
			generate_process_routines := a_params.generate_process_routines

				-- Set class name
			if a_params.use_user_data then
				user_data_class_name := a_params.user_data_class_name
			end

				-- Calculate files
			calcuate_files (a_params)

			create universe.make (files)
		end

feature -- Access

	universe: APPLICATION_UNIVERSE

	files: LIST [STRING_8]
			-- Files to include in generation of factory

	interface_class_name: STRING
			-- Class name for interface class

	stub_class_name: STRING
			-- Class name for stub class

	stub_output_file_name: STRING
			-- Path to generate stub output file

	interface_output_file_name: STRING
			-- Path to generate interface output file

	user_data_class_name: STRING
			-- User data class name

	generate_stub: BOOLEAN
			-- Indicates if a stub class should be generated

	generate_interface: BOOLEAN
			-- Indicates if an interface class should be generated

	generate_process_routines: BOOLEAN
			-- Should we generate `process' routines for each class being added to the visitor?

feature -- Status report

	use_user_data: BOOLEAN is
			-- Indiciates if user data should be passed via a process feature call
		once
			Result := user_data_class_name /= Void
		end

feature {NONE} -- Query

	has_eiffel_extension (a_file_name: !STRING): BOOLEAN is
			-- Determines if `a_file_name' has an Eiffel source file extension
		require
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_count: INTEGER
		do
			l_count := a_file_name.count
			Result := l_count > 2 and then a_file_name.substring (l_count - 1, l_count).is_case_insensitive_equal (eiffel_file_extension)
		end

feature {NONE} -- Implementation

	calcuate_files (a_params: IAPPLICATION_PARAMETERS) is
			-- Calculates requested for generation by `a_params'
		require
			a_params_attached: a_params /= Void
			a_params_successful: a_params.is_readable
		local
			l_exclude_rx: ?RX_PCRE_MATCHER
			l_list: !LIST [!STRING]
			l_excludes: !LIST [!STRING]
			l_array_list: !ARRAYED_LIST [!STRING]
			l_files: !ARRAYED_LIST [!STRING]
			l_cursor: CURSOR
			l_recurse: BOOLEAN
		do
			l_list := a_params.included_files
			if l_list.is_empty then
				if {l_wd: STRING} (create {EXECUTION_ENVIRONMENT}).current_working_directory then
					create l_array_list.make (1)
					l_array_list.extend (l_wd)
					l_list := l_array_list
				else
					check this_is_bug: False end
				end
			end

			l_excludes := a_params.exclude_expressions
			if not l_excludes.is_empty then
				l_exclude_rx := create_pattern_for_file_list (l_excludes)
			end
			l_recurse := a_params.recurse_directories

				-- Retrieve all files
			create l_files.make (10)
			files := l_files
			l_cursor := l_list.cursor
			from l_list.start until l_list.after loop
				append_file_list (l_list.item, l_files, l_recurse, l_exclude_rx)
				l_list.forth
			end
			l_list.go_to (l_cursor)
		ensure
			files_attached: files /= Void
		end

	append_file_list (a_path: !STRING; a_list: !ARRAYED_LIST [!STRING]; a_recurse: BOOLEAN; a_expression: ?RX_PCRE_MATCHER) is
			-- Appends Eiffel source files located at or in `a_path' to `a_list'. If `a_path' happens to
			-- be a directory and `a_recurse' is True then any subdirectories will also be scanned.
			-- `a_expression' represents an excluded expression
		require
			not_a_path_is_empty: not a_path.is_empty
		local
			l_file: RAW_FILE
			l_directory: KL_DIRECTORY
		do
			create l_file.make (a_path)
			if l_file.exists then
				if l_file.is_directory or l_file.is_device then
					create l_directory.make (a_path)
					l_directory.filenames.do_all (agent (ia_item: !STRING; ia_inner_list: !ARRAYED_LIST [!STRING]; ia_dir: !STRING; ia_in_expr: ?RX_PCRE_MATCHER)
						require
							not_ia_item_is_empty: not ia_item.is_empty
						local
							l_file_name: FILE_NAME
						do
							if has_eiffel_extension (ia_item) then
								if not ia_dir.is_empty then
									create l_file_name.make_from_string (ia_dir)
								else
									create l_file_name.make
								end
								l_file_name.set_file_name (ia_item)
								if ia_in_expr = Void or else not ia_in_expr.matches (l_file_name) then
									ia_inner_list.extend (l_file_name)
								end
							end
						end (?, a_list, a_path, a_expression))

					if a_recurse then
						l_directory.directory_names.do_all (agent (ia_item: !STRING; ia_files: !ARRAYED_LIST [!STRING]; ia_dir: !STRING; ia_in_expr: ?RX_PCRE_MATCHER)
							require
								not_ia_item_is_empty: not ia_item.is_empty
							local
								l_path_name: FILE_NAME
							do
								if not ia_dir.is_empty then
									create l_path_name.make_from_string (ia_dir)
								else
									create l_path_name.make
								end
								l_path_name.set_file_name (ia_item)
								if ia_in_expr = Void or else not ia_in_expr.matches (l_path_name) then
									append_file_list (l_path_name, ia_files, True, ia_in_expr)
								end
							end (?, a_list, a_path, a_expression))
					end
				else
					if has_eiffel_extension (a_path) then
						a_list.extend (a_path)
					end
				end
			end
		end

	create_pattern_for_file_list (a_list: LIST [STRING]): RX_PCRE_MATCHER is
			-- Creates an regular expression pattern for list `a_list' and returns the result
		require
			a_list_attached: a_list /= Void
			not_a_list_is_empty: not a_list.is_empty
		local
			l_pattern: STRING
			l_cursor: CURSOR
		do
			l_cursor := a_list.cursor
			create l_pattern.make (1024)
			from a_list.start until a_list.after loop
				if not a_list.isfirst then
					l_pattern.append_character ('|')
				end
				l_pattern.append_character ('(')
				l_pattern.append (a_list.item)
				l_pattern.append_character (')')
				a_list.forth
			end
			a_list.go_to (l_cursor)
			create Result.make
			Result.compile (l_pattern)
		ensure
			result_attached: Result /= Void
			result_is_compiled: Result.is_compiled
			a_list_unmoved: a_list.cursor.is_equal (old a_list.cursor)
		end

feature {NONE} -- Contants

	eiffel_file_extension: STRING = ".e"
			-- Eiffel source file extension

	default_output_file_name: STRING = "generated_visitor.e"
			-- Default file name for output file

	default_class_name: STRING = "GENERATED_VISITOR"
			-- Default class name for output file

invariant
	files_attached: files /= Void
	generate_stub_and_or_interface: generate_stub or generate_interface

	stub_class_name_name_attached: generate_stub implies stub_class_name /= Void
	not_stub_class_name_is_empty: stub_class_name /= Void implies not stub_class_name.is_empty

	interface_class_name_name_attached: interface_class_name /= Void
	not_interface_class_name_is_empty: not interface_class_name.is_empty

	stub_output_file_name_attached: generate_stub implies stub_output_file_name /= Void
	not_stub_output_file_name_is_empty: stub_output_file_name /= Void implies not stub_output_file_name.is_empty

	interface_output_file_name_attached: generate_interface implies interface_output_file_name /= Void
	not_interface_output_file_name_is_empty: interface_output_file_name /= Void implies not interface_output_file_name.is_empty

	user_data_class_name_attached: use_user_data implies user_data_class_name /= Void
	not_user_data_class_name_is_empty: user_data_class_name /= Void implies not user_data_class_name.is_empty


;indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class {APPLICATION_OPTIONS}
