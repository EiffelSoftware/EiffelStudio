note
	description	: "System's root class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_CLASS

inherit
	ARGUMENTS

	KL_SHARED_FILE_SYSTEM

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		do
			create file_names.make (5)
			create search_directories.make (5)
			analyze_options
			if option_error then
				print_option_error
			elseif is_help_needed then
				print_usage
			elseif analyze_files_n_directories then
				generate
			end
		end

feature -- Access

	current_option: INTEGER
			-- Current option position

	option: STRING
			-- Current option

	file_names: ARRAYED_LIST [STRING]
			-- Files need to generate

	search_directories: ARRAYED_LIST [STRING]
			-- Directories need to search

	output_file_name: STRING
			-- Name for output file

feature -- Status report

	option_error: BOOLEAN
			-- Did an option error occur?

	is_help_needed: BOOLEAN

feature {NONE} -- Implementation

	file_suffix: STRING = ".e"
			-- Suffix for files which are parsed
			-- This is the file suffix for Eiffel source files

	default_output_name: STRING = "po_file.pot"
			-- File name of output file if no specific name is given
			-- through commandline options

	output_name_for_standard: STRING = "-"
			-- If this file name is given as a command line option
			-- then the output is put on the standard output

	po_file: PO_FILE
			-- Po file generated

	generate
			-- Generate po files.
			--
			-- The input directories and input files will be parsed for localizable messages
			-- and they will be added to `po_file'.
		local
			l_dir: KL_DIRECTORY
			l_directorys: like search_directories
			l_file_names: like file_names
			l_s: STRING
			l_short_name: STRING_8
		do
			create po_file.make_empty
			l_file_names := file_names
			from
				l_file_names.start
			until
				l_file_names.after
			loop
				l_s := l_file_names.item
				l_s.replace_substring_all ("/", "\")
				l_short_name := l_s.substring (l_s.last_index_of ('\', l_s.count) + 1, l_s.count)
				debug
					print (l_s + "%N")
				end
				generate_file (l_s, l_short_name)
				l_file_names.forth
			end
				-- Go through directories specified on command line
			l_directorys := search_directories
			from
				l_directorys.start
			until
				l_directorys.after
			loop
				l_s := l_directorys.item.twin
				l_s.replace_substring_all ("/", "\")
				debug
					print (l_s + "%N")
				end
				create l_dir.make (file_system.pathname_from_file_system (l_s, windows_file_system))
				generate_directory (l_dir)
				l_directorys.forth
			end
			debug
				print (po_file.to_string.as_string_8)
			end
			write_to_file
		end

	generate_directory (a_dir: KL_DIRECTORY)
			-- Generate messages from `a_dir'.
			--
			-- Read all files (recursively) in `a_dir' which macht `file_suffix' and parse
			-- messages in the files which will be added to `po_file'.
			--
			-- `a_dir': Directory which is searched recursively for files matching `file_suffix'
		require
			po_file_not_void: po_file /= Void
			a_dir_not_void: a_dir /= Void
		local
			l_dirs: ARRAY [STRING]
			l_files: ARRAY [STRING]
			i: INTEGER
			l_dir: KL_DIRECTORY
			l_name, l_short_name: STRING
		do
			l_dirs := a_dir.directory_names
			if l_dirs /= Void then
				from
					i := l_dirs.lower
				until
					i > l_dirs.upper
				loop
					debug
						print (l_dirs.item (i) + "%N")
					end
					create l_dir.make (a_dir.name + operating_environment.directory_separator.out + l_dirs.item (i))
					generate_directory (l_dir)
					i := i + 1
				end
			end

			l_files := a_dir.filenames
			if l_files /= Void then
				from
					i := l_files.lower
				until
					i > l_files.upper
				loop
					l_short_name := l_files.item (i)
					if l_short_name.substring (l_short_name.count - 1, l_short_name.count).is_equal (file_suffix) then
						l_name := a_dir.name + operating_environment.directory_separator.out + l_short_name
						generate_file (l_name, l_short_name)
						debug
							print (l_name + "%N")
						end
					end
					i := i + 1
				end
			end
		end

	generate_file (a_name, a_short_name: STRING)
			-- Generate messages from `a_file'.
			--
			-- The file is parsed for messages which will be added to `po_file'.
			--
			-- `a_name': Full path of `a_file'
			-- `a_short_name': Filename of `a_file'
			-- `a_file': File which will be parsed
		require
			po_file_not_void: po_file /= Void
			a_name_not_void: a_name /= Void
			a_short_name_not_void: a_short_name /= Void
		local
			l_generator: PO_GENERATOR
			l_file: KL_TEXT_INPUT_FILE
		do
			create l_file.make (a_name)
			l_file.open_read
			if l_file.is_readable then
				l_file.read_string (l_file.count)
				create l_generator.make (po_file, l_file.last_string)
				l_generator.set_source_file_name (a_short_name)
				l_generator.generate
				if l_generator.has_error then
					print ("Error: parsing failed: entries in %"" + a_name + "%" not generated.%N")
				else
					print_analyze_file (a_name)
				end
			end
			check
				l_file_closable: l_file.is_closable
			end
			l_file.close
		end

	analyze_options
			-- Analyze options.
		do
			from
				current_option := 1
			until
				(current_option > argument_count) or else
				option_error
			loop
				analyze_one_option
			end
		end

	analyze_one_option
			-- Analyze one option.
		local
			l_name: STRING
		do
			option := argument (current_option)
			if option.is_equal ("-h") then
				is_help_needed := True
				current_option := current_option + 1
			elseif option.is_equal ("-f") then
				if current_option < argument_count then
					from
						current_option := current_option + 1
						l_name := argument (current_option)
						if l_name.item (1).is_equal ('-') or else (current_option > argument_count) then
							option_error := True
						end
					until
						l_name.item (1).is_equal ('-') or else (current_option > argument_count)
					loop
						file_names.extend (l_name)
						current_option := current_option + 1
						if current_option <= argument_count then
							l_name := argument (current_option)
						end
					end
				else
					option_error := True
				end
			elseif option.is_equal ("-D") then
				if current_option < argument_count then
					from
						current_option := current_option + 1
						l_name := argument (current_option)
						if l_name.item (1).is_equal ('-') or else (current_option > argument_count) then
							option_error := True
						end
					until
						l_name.item (1).is_equal ('-') or else (current_option > argument_count)
					loop
						search_directories.extend (l_name)
						current_option := current_option + 1
						if current_option <= argument_count then
							l_name := argument (current_option)
						end
					end
				else
					option_error := True
				end
			elseif option.is_equal ("-o") then
				if current_option < argument_count then
					current_option := current_option + 1
					output_file_name := argument (current_option)
					current_option := current_option + 1
				else
					option_error := True
				end
			else
				option_error := True
			end
		end

	analyze_files_n_directories: BOOLEAN
			-- Validate input files and directories.
		local
			l_file_names: like file_names
			l_search_directories: like search_directories
			l_name: STRING
			l_file: RAW_FILE
		do
			l_file_names := file_names
			l_search_directories := search_directories
			Result := True
				-- Check file names.
			from
				l_file_names.start
			until
				l_file_names.after
			loop
				l_name := l_file_names.item
				if l_name.count > 2 and then l_name.substring (l_name.count - 1, l_name.count).is_equal (file_suffix) then
					create l_file.make (l_name)
					if l_file.exists and then not l_file.is_directory then
					else
						print_file_not_exist (l_name)
						Result := False
					end
				else
					print_file_name_invalid (l_name)
					Result := False
				end
				l_file_names.forth
			end

				-- Check directories.
			if Result then
				from
					l_search_directories.start
				until
					l_search_directories.after
				loop
					l_name := l_search_directories.item
					create l_file.make (l_name)
					if l_file.exists and then l_file.is_directory then
					else
						print_directory_not_exist (l_name)
						Result := False
					end
					l_search_directories.forth
				end
			end
				-- Check output location
			create l_file.make (output_file_name)
			if
				not (
					(l_file.exists and then l_file.is_writable) or else
					(not l_file.exists and then l_file.is_creatable)
				)
			then
				print_invalid_output_file
				Result := False
			end
		end

	write_to_file
			-- Writes the `po_file' to `output_file_name'.
		require
			po_file_not_void: po_file /= Void
		local
			l_file_name: FILE_NAME
			l_file: PLAIN_TEXT_FILE
		do
			if output_file_name = Void then
				output_file_name := default_output_name
			end
			if output_file_name.is_equal (output_name_for_standard) then
				io.put_string (po_file.to_string.as_string_8)
				io.put_new_line
			else
				create l_file_name.make_from_string (output_file_name)
				if l_file_name.is_valid then
					create l_file.make (output_file_name)
					l_file.open_write
					if l_file.is_writable then
						l_file.put_string (po_file.to_string)
						print_file_generated
					else
						print_file_not_writable
					end
					l_file.close
				else
					print_invalid_output_file
				end
			end
		end

feature {NONE} -- Output

	print_option_error
			-- Print the error and correct usage.
		do
			io.put_string (argument (0))
			io.put_string (": incorrect option%N")
			print_usage
		end

	print_file_not_exist (a_file: STRING)
			-- Print error that `a_file' does not exist.
		require
			a_file_not_void: a_file /= Void
		do
			io.put_string (a_file + ": file does not exist%N")
		end

	print_directory_not_exist (a_directory: STRING)
			-- Print error that `a_directory' does not exist.
		require
			a_directory_not_void: a_directory /= Void
		do
			io.put_string (a_directory + ": directory does not exist%N")
		end

	print_file_name_invalid (a_file: STRING)
			-- Print error that `a_file' is invalid.
		require
			a_file_not_void: a_file /= Void
		do
			io.put_string (a_file + ": invalid%N")
		end

	print_invalid_output_file
			-- Print error that `output_file_name' is invalid.
		do
			io.put_string ("%"" + output_file_name + "%" is invalid.%N")
			io.put_string ("File not generated.%N")
		end

	print_file_not_writable
			-- Print error that `output_file_name' is not writable.
		do
			io.put_string ("%"" + output_file_name + "%" is not writable.%N")
			io.put_string ("File not generated.%N")
		end

	print_file_generated
			-- Print status message that `output_file_name' has been generated.
		do
			io.put_string ("%"" + output_file_name + "%" has been generated.%N")
		end

	print_analyze_file (a_file: STRING)
			-- Print status message that file `a_file' is currently being analyzed.
		require
			a_file_not_void: a_file /= Void
		do
			io.put_string ("Analyzing: ")
			io.put_string (a_file)
			io.put_new_line
		end

	print_usage
			-- Print usage.
		do
			io.put_string ("Usage:%N%T")
			io.put_string (argument (0))
			io.put_string (" [OPTION] [INPUTFILE]...%N%N")
			io.put_string ("Extract translatable strings from given input Eiffel class files (*.e).%N%N")
			io.put_string ("[
					INPUTFILE ...	input files
					-f		add list of input files
					-D		add list of directories to list for input files search
					-o		write output to specified file
							If output file is -, output is written to standard output.
							If output file is not specified, 'po_file.pot' will be generated as default name.
					-h		display this help and exit
				]"
			)
		end

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
