indexing
	description: "Root class of class merger utility, parses command line and execute merger accordingly"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EPC_APPLICATION

inherit
	EPC_SHARED_ROUNDTRIP_PARSER
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

create
	execute

feature {NONE} -- Initialization

	execute is
			-- Run the program.
		local
			l_syntax: COMMAND_LINE_SYNTAX
			l_parser: COMMAND_LINE_PARSER
			l_args: ARGUMENTS
			l_dir: KL_DIRECTORY
			l_dir_names: LIST [STRING]
			l_output_dir_name: STRING
		do
			create l_syntax.make (option_specifications)
			create l_parser.make (l_syntax)
			create l_args
			l_parser.parse (l_args.argument_array)
			exe_name := l_parser.executable_without_suffix
			if l_parser.valid_options.has ("-v") then
				print_version_info
			elseif l_parser.valid_options.has ("-h") then
				print (l_syntax.program_help (exe_name, Void, Void))
			elseif not l_parser.invalid_options_found then
				if l_parser.valid_options.has ("-i") then
					l_dir_names := l_parser.valid_options.item ("-i")
				else
					create {ARRAYED_LIST [STRING]} l_dir_names.make (1)
					l_dir_names.extend ((create {EXECUTION_ENVIRONMENT}).current_working_directory)
				end
				if l_parser.valid_options.has ("-o") then
					l_output_dir_name := l_parser.valid_options.item ("-o").first
					create l_dir.make (l_output_dir_name)
					if not l_dir.exists then
						l_dir.recursive_create_directory
					end
				else
					l_output_dir_name := (create {EXECUTION_ENVIRONMENT}).current_working_directory
				end
				if l_output_dir_name.item (l_output_dir_name.count) /= Directory_separator then
					l_output_dir_name.append_character (Directory_separator)
				end
				process_directories (l_dir_names, l_output_dir_name, l_parser.valid_options.has ("-r"))
			else
				print (l_parser.error_message)
				print (l_syntax.program_usage (exe_name) + "%N")
				print ("Use -h/--help for more help." + "%N")
			end
		end

feature {NONE} -- Implementation

	process_directories (a_dir_names: LIST [STRING]; a_output_dir_name: STRING; a_recursive: BOOLEAN) is
			-- Process directories `a_dir_names' recursively if `a_recursive'.
		require
			attached_dir_names: a_dir_names /= Void
		local
			l_merger: EPC_MERGER
		do
			create partial_classes_files.make (10)
			parse (a_dir_names, Void, a_recursive)
			create l_merger
			if not partial_classes_files.is_empty then
				from
					partial_classes_files.start
				until
					partial_classes_files.after
				loop
					l_merger.merge (partial_classes_files.item_for_iteration)
					if l_merger.successful then
						save_class_text (l_merger.class_text, a_output_dir_name + partial_classes_files.key_for_iteration.as_lower + ".e")
					else
						display_warning ("Could not merge class " + partial_classes_files.key_for_iteration)
					end
					partial_classes_files.forth
				end
			end
		end

	parse (a_dir_names: LIST [STRING]; a_parent: STRING; a_recursive: BOOLEAN) is
			-- Parse Eiffel classes in directories `a_dir_names' and put file names of
			-- classes with identical names in `partial_classes_files'.
		require
			attached_dir_names: a_dir_names /= Void
			valid_parent: a_parent /= Void implies a_parent.item (a_parent.count) /= Directory_separator
		local
			l_dir: KL_DIRECTORY
			l_dir_name: STRING
		do
			from
				a_dir_names.start
			until
				a_dir_names.after
			loop
				if a_parent /= Void then
					l_dir_name := a_parent.twin
					l_dir_name.append_character (Directory_separator)
					l_dir_name.append (a_dir_names.item)
				else
					l_dir_name := a_dir_names.item
				end
				create l_dir.make (l_dir_name)
				if l_dir.exists then
					parse_directory (l_dir)
					if a_recursive then
						parse (create {ARRAYED_LIST [STRING]}.make_from_array (l_dir.directory_names), l_dir_name, True)
					end
				else
					display_warning ("Directory " + a_dir_names.item + " not found.")
				end
				a_dir_names.forth
			end
		ensure
			attached_partial_classes_files: partial_classes_files /= Void
		end

	parse_directory (a_dir: KL_DIRECTORY) is
			-- Parse files in `a_dir'.
			-- Build `partial_classes_files'.
		local
			l_files: ARRAY [STRING]
			i, l_count: INTEGER
			l_dir_name, l_file_name, l_abs_path, l_class_name: STRING
			l_new_list: ARRAYED_LIST [STRING]
		do
			l_files := a_dir.filenames
			l_count := l_files.count
			l_dir_name := a_dir.name
			from
				i := 1
			until
				i > l_count
			loop
				l_file_name := l_files.item (i)
				if l_file_name.count > 3 and then l_file_name.substring_index (".e", l_file_name.count - 1) = l_file_name.count - 1 then
					create l_abs_path.make (l_dir_name.count + 1 + l_file_name.count)
					l_abs_path.append (l_dir_name)
					l_abs_path.append_character (Directory_separator)
					l_abs_path.append (l_file_name)
					l_class_name := class_name (l_abs_path)
					if l_class_name /= Void then
						partial_classes_files.search (l_class_name)
						if partial_classes_files.found then
							partial_classes_files.found_item.extend (l_abs_path)
						else
							create l_new_list.make (10)
							l_new_list.extend (l_abs_path)
							partial_classes_files.put (l_new_list, l_class_name)
						end
					end
				end
				i := i + 1
			end
			from
				partial_classes_files.start
			until
				partial_classes_files.after
			loop
				if partial_classes_files.item_for_iteration.count < 2 then
					partial_classes_files.remove (partial_classes_files.key_for_iteration)
				end
				partial_classes_files.forth
			end
		end

	class_name (a_file: STRING): STRING is
			-- Class name of Eiffel class text stored in `a_file'
		require
			attached_file: a_file /= Void
		local
			l_file: KL_WINDOWS_INPUT_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make (a_file)
				if l_file.exists then
					l_file.open_read
					roundtrip_eiffel_parser.parse (l_file)
					l_file.close
					if roundtrip_eiffel_parser.root_node /= Void then
						Result := roundtrip_eiffel_parser.root_node.class_name
					else
						display_warning ("Could not parse " + a_file)
					end
				end
			end
		rescue
			l_retried := True
			display_warning ("Could not parse " + a_file)
			retry
		end

	save_class_text (a_text, a_path: STRING) is
			-- Save class text `a_text' in file `a_path'.
		require
			attached_text: a_text /= Void
			attached_path: a_path /= Void
		local
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make (a_path)
				if l_file.exists then
					display_warning ("File overwritten: " + a_path)
				end
				l_file.open_write
				l_file.put_string (a_text)
				l_file.close
			end
		rescue
			l_retried := True
			display_error ("Could not save class text into file " + a_path)
			retry
		end

	display_warning (a_warning: STRING) is
			-- Display warning `a_warning'.
		require
			attached_warning: a_warning /= Void
		do
			print ("!!WARNING: ")
			print (a_warning)
			print ("%N")
		end

	display_error (a_error: STRING) is
			-- Display error `a_error'.
		require
			attached_error: a_error /= Void
		do
			print ("!!ERROR: ")
			print (a_error)
			print ("%N")
		end

	print_version_info is
			-- Display version information
		do
			print ("Eiffel Partial Classes Merger v1.0.0328%N(c) 2006 Eiffel Software")
		end

	option_specifications: ARRAY [STRING] is
			-- The recognized options of this program
		once
			Result := << "-v,--version#Version information.",
						 "-h,--help#Help on using this program.",
						 "-i,--input=DIRECTORIES!#Input directories to be parsed.",
						 "-o,--output=OUTPUT!#Output directory.",
						 "-r,--recursive#Recurse in subdirectories of input directories."
						>>
		end

	exe_name: STRING
			-- Name of this executable

	partial_classes_files: HASH_TABLE [ARRAYED_LIST [STRING], STRING];
			-- List of file names making up Eiffel type from partial classes
			-- associated with corresponding class name.

indexing
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

end -- class EPC_APPLICATION
