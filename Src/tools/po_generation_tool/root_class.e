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

	LOCALIZED_PRINTER

create
	make

feature {NONE} -- Initialization

	make
			-- Creation procedure.
		do
			create file_names.make (5)
			create search_directories.make (5)
			create po_file.make_empty
			analyze_options
			if option_error then
				has_error := True
				print_option_error
			elseif is_help_needed then
				print_usage
			elseif analyze_files_n_directories then
				generate
			else
				has_error := True
			end
			if has_error then
				io.error.put_string_32 ("Finished with errors.%N")
				{EXCEPTIONS}.die (1)
			end
		end

feature -- Access

	current_option: INTEGER
			-- Current option position

	file_names: ARRAYED_LIST [STRING_32]
			-- Files need to generate

	search_directories: ARRAYED_LIST [STRING_32]
			-- Directories need to search

	output_file_name: detachable STRING_32
			-- Name for output file

feature -- Status report

	option_error: BOOLEAN
			-- Did an option error occur?

	is_help_needed: BOOLEAN

	has_error: BOOLEAN
			-- Has an error been detected?

feature {NONE} -- Implementation

	file_suffix: STRING_32 = ".e"
			-- Suffix for files which are parsed
			-- This is the file suffix for Eiffel source files

	default_output_name: STRING = "po_file.pot"
			-- File name of output file if no specific name is given
			-- through commandline options

	output_name_for_standard: STRING_32 = "-"
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
			l_dir: STRING_32
			l_s: STRING_32
			l_short_name: STRING_32
		do
			create po_file.make_empty
			across
				file_names as f
			loop
				l_s := f.item
				l_s.replace_substring_all ("/", "\")
				l_short_name := l_s.substring (l_s.last_index_of ('\', l_s.count) + 1, l_s.count)
				generate_file (l_s, l_short_name)
			end
				-- Go through directories specified on command line
			across
				search_directories as d
			loop
				l_dir := d.item.twin
				l_dir.replace_substring_all ("/", "\")
				generate_directory (l_dir)
			end
			write_to_file
		end

	generate_directory (a_dir: READABLE_STRING_32)
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
			l_short_name: STRING_32
			l_u: FILE_UTILITIES
		do
			if attached l_u.directory_names (a_dir) as l_dirs then
				across
					l_dirs as d
				loop
					generate_directory (a_dir + operating_environment.directory_separator.out + d.item)
				end
			end

			if attached l_u.file_names (a_dir) as l_files then
				across
					l_files as f
				loop
					l_short_name := f.item
					if l_short_name.substring (l_short_name.count - 1, l_short_name.count).same_string (file_suffix) then
						generate_file (a_dir + operating_environment.directory_separator.out + l_short_name, l_short_name)
					end
				end
			end
		end

	generate_file (a_name, a_short_name: STRING_32)
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
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make_with_name (a_name)
				l_file.open_read
				if l_file.is_readable then
					l_file.read_stream (l_file.count)
					create l_generator.make (po_file, l_file.last_string, a_short_name)
					l_generator.generate
					if l_generator.has_error then
						has_error := True
						localized_print ({STRING_32} "Error: parsing failed: entries in %"" + a_name + "%" not generated.%N")
					else
						print_analyze_file (a_name)
					end
				end
				l_file.close
			else
				has_error := True
				localized_print ({STRING_32} "Error: File reading failed: entries in %"" + a_name + "%" not generated.%N")
			end
		rescue
			l_retried := True
			if attached l_file and then not l_file.is_closed then
				l_file.close
			end
			retry
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
			option: STRING
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
			l_name: STRING_32
			l_file: RAW_FILE
			l_u: FILE_UTILITIES
		do
			Result := True
				-- Check file names.
			across
				file_names as f
			loop
				l_name := f.item
				if l_name.count <= 2 or else not l_name.substring (l_name.count - 1, l_name.count).same_string (file_suffix) then
					print_file_name_invalid (l_name)
					Result := False
				elseif not l_u.file_exists (l_name) then
					print_file_not_exist (l_name)
					Result := False
				end
			end

				-- Check directories.
			if Result then
				across
					search_directories as d
				loop
					l_name := d.item
					if not l_u.directory_exists (l_name) then
						print_directory_not_exist (l_name)
						Result := False
					end
				end
			end
				-- Check output location
			if attached output_file_name as o then
				create l_file.make_with_name (o)
				if
					not
						((l_file.exists and then l_file.is_writable) or else
							(not l_file.exists and then l_file.is_creatable))
				then
					print_invalid_output_file (o)
					Result := False
				end
			end
		end

	write_to_file
			-- Writes the `po_file' to `output_file_name'.
		require
			po_file_not_void: po_file /= Void
		local
			l_file: PLAIN_TEXT_FILE
			u: UTF_CONVERTER
			o: like output_file_name
		do
			o := output_file_name
			if not attached o then
				o := default_output_name
			end
			if o.same_string (output_name_for_standard) then
				localized_print (po_file.to_string)
				localized_print ("%N")
			else
				create l_file.make_open_write (o)
				if l_file.is_writable then
					l_file.put_string (u.string_32_to_utf_8_string_8 (po_file.to_string))
					print_file_generated (o)
				else
					print_file_not_writable (o)
					has_error := True
				end
				l_file.close
			end
		end

feature {NONE} -- Output

	print_option_error
			-- Print the error and correct usage.
		do
			localized_print (argument (0))
			localized_print (": incorrect option%N")
			print_usage
		end

	print_file_not_exist (a_file: STRING_32)
			-- Print error that `a_file' does not exist.
		require
			a_file_not_void: a_file /= Void
		do
			localized_print (a_file + ": file does not exist%N")
		end

	print_directory_not_exist (a_directory: STRING_32)
			-- Print error that `a_directory' does not exist.
		require
			a_directory_not_void: a_directory /= Void
		do
			localized_print (a_directory + ": directory does not exist%N")
		end

	print_file_name_invalid (a_file: STRING_32)
			-- Print error that `a_file' is invalid.
		require
			a_file_not_void: a_file /= Void
		do
			localized_print (a_file + ": invalid%N")
		end

	print_invalid_output_file (n: READABLE_STRING_32)
			-- Print error that a file of name `n' is invalid.
		do
			localized_print ({STRING_32} "%"" + n + "%" is invalid.%N")
			localized_print ("File not generated.%N")
		end

	print_file_not_writable (n: READABLE_STRING_32)
			-- Print error that a file of name `n' is not writable.
		do
			localized_print ({STRING_32} "%"" + n + "%" is not writable.%N")
			localized_print ("File not generated.%N")
		end

	print_file_generated (n: READABLE_STRING_32)
			-- Print status message that a file of name `n' has been generated.
		do
			localized_print ({STRING_32} "%"" + n + "%" has been generated.%N")
		end

	print_analyze_file (a_file: STRING_32)
			-- Print status message that file `a_file' is currently being analyzed.
		require
			a_file_not_void: a_file /= Void
		do
			localized_print ("Analyzing: ")
			localized_print (a_file)
			localized_print ("%N")
		end

	print_usage
			-- Print usage.
		do
			localized_print ("Usage:%N%T")
			localized_print (argument (0))
			localized_print (" [OPTION] [INPUTFILE]...%N%N")
			localized_print ("Extract translatable strings from given input Eiffel class files (*.e).%N%N")
			localized_print ("[
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
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
