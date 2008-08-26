indexing
	description: "[
		Application to resave ECFs using the configuration library.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	APPLICATION

inherit
	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Application entry point
		local
			l_parser: ARGUMENT_PARSER
			retried: BOOLEAN
		do
			if not retried then
				create l_parser.make
				l_parser.execute (agent start (l_parser))
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Execution

	start (a_options: ARGUMENT_PARSER) is
			-- Starts application once all arguments have been parsed
		require
			a_options_attached: a_options /= Void
			a_options_is_successful: a_options.is_successful
		local
			l_cursor: DS_BILINEAR_CURSOR [STRING]
			l_files: DS_ARRAYED_LIST [STRING]
			l_dirs: DS_ARRAYED_LIST [STRING]
			l_eh: like error_handler
			l_eprinter: ERROR_CUI_PRINTER
		do
				-- Add specified files
			create l_files.make_from_linear (a_options.files)

				-- Add scanned directories
			l_files.append_last (scan_for_ecf_files (a_options.directories, a_options.use_directory_recusion))
			if l_files.is_empty then
					-- No files or directories, use current directory
				create l_dirs.make (1)
				l_dirs.put_last (file_system.current_working_directory)
				l_files.append_last (scan_for_ecf_files (l_dirs, a_options.use_directory_recusion))
			end

				-- Resave files
			l_cursor := l_files.new_cursor
			from l_cursor.start until l_cursor.after loop
				resave_config (l_cursor.item)
				l_cursor.forth
			end

			l_eh := error_handler
			create l_eprinter
			if l_eh.has_warnings then
				print ("%N")
				l_eh.trace_warnings (l_eprinter)
			end
			if not l_eh.successful then
				print ("%N")
				l_eh.trace_errors (l_eprinter)
				(create {EXCEPTIONS}).die (1)
			end
		end

feature {NONE} -- Basic operations

	resave_config (a_file_name: STRING) is
			-- Loads and resaves `a_file_name' using the configuration system.
		local
			l_cfg: like load_config
		do
			if a_file_name /= Void and then not a_file_name.is_empty and then file_system.is_file_readable (a_file_name) then
				print ("Loading configuration file '")
				print (a_file_name)
				print ("'... ")
				l_cfg := load_config (a_file_name)

				if l_cfg /= Void then
					print ("Done%N")
					print ("Saving configuration file... ")
					if save_config (l_cfg, a_file_name) then
						print ("Done%N")
					else
						print ("Failed!%N")
					end
				else
					print ("Failed!%N")
				end
			else
				print ("Invalid file!%N")
			end
		end

	load_config (a_file_name: STRING): CONF_SYSTEM is
			-- Loads a configuration system from `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: file_system.is_file_readable (a_file_name)
		local
			l_reader: like ecf_reader
			retried: BOOLEAN
		do
			if not retried then
				l_reader := ecf_reader
				l_reader.retrieve_configuration (a_file_name)
				if not l_reader.is_error then
					Result := l_reader.last_system
				else
					if l_reader.is_invalid_xml then
						error_handler.add_error (create {SCIX}.make (a_file_name), False)
					else
						error_handler.add_error (create {SCLF}.make (a_file_name), False)
					end
				end
			else
				error_handler.add_error (create {SCFE}.make (a_file_name), False)
			end
		rescue
			retried := True
			retry
		end

	save_config (a_cfg: CONF_SYSTEM; a_file_name: STRING): BOOLEAN is
			-- Saves the configuration system `a_cfg' to `a_file_name'
		require
			a_cfg_attached: a_cfg /= Void
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: file_system.is_file_readable (a_file_name)
		local
			l_printer: like ecf_printer
			l_file: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				l_printer := ecf_printer
				a_cfg.process (l_printer)
				if not l_printer.is_error then
					create l_file.make (a_file_name)
					l_file.open_write
					l_file.put_string (l_printer.text)
					l_file.flush
					Result := True
				else
					error_handler.add_error (create {SCPR}.make (a_file_name), False)
				end
			else
				if l_file /= Void then
					error_handler.add_error (create {SCSF}.make (a_file_name), False)
				else
					error_handler.add_error (create {SCFE}.make (a_file_name), False)
				end
			end

			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		rescue
			retried := True
			retry
		end

	scan_for_ecf_files (a_directories: DS_LINEAR [STRING]; a_recursive: BOOLEAN): DS_ARRAYED_LIST [STRING] is
			-- Scans directories in `a_directories' for ECF files
		require
			a_directories_attached: a_directories /= Void
		local
			l_dir: KL_DIRECTORY
			l_items: ARRAY [STRING]
			l_file: STRING
			l_ext: STRING
			l_cursor: DS_LINEAR_CURSOR [STRING]
			l_pos: INTEGER
			l_seperator: STRING
			l_count, i: INTEGER
		do
			create Result.make (0)
			l_seperator := operating_environment.directory_separator.out

			l_cursor := a_directories.new_cursor
			from l_cursor.start until l_cursor.after loop
				create l_dir.make (l_cursor.item)
				if l_dir.exists then
					l_items := l_dir.filenames
					l_count := l_items.count
					from i := 1 until i > l_count loop
						l_file := l_items.item (i)
						l_pos := l_file.last_index_of ('.', l_file.count)
						if l_pos > 1 and l_pos < l_file.count then
							l_ext := l_file.substring (l_pos, l_file.count)
							l_ext.to_lower
							if l_ext.is_equal (once ".ecf") then
								Result.force_last (l_dir.name + l_seperator + l_file)
							end
						end
						i := i + 1
					end

					if a_recursive then
							-- Need full paths.
						l_items := l_dir.directory_names
						l_count := l_items.count
						from i := 1 until i > l_count loop
							l_items.item (i).prepend (l_dir.name + l_seperator)
							i := i + 1
						end
						Result.append_last (scan_for_ecf_files (create {DS_ARRAYED_LIST [STRING]}.make_from_array (l_items), a_recursive))
					end
				end
				l_cursor.forth
			end
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
		end

feature {NONE} -- Access

	ecf_reader: CONF_LOAD is
			-- Configuration loader
		once
			create Result.make (create {CONF_PARSE_FACTORY})
		ensure
			result_attached: Result /= Void
		end

	ecf_printer: CONF_PRINT_VISITOR is
			-- Configuration printer
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	error_handler: MULTI_ERROR_MANAGER is
			-- Error handler
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
