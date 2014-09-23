note
	description: "[
		Application to resave ECFs using the configuration library.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ECF_RESAVE

inherit
	ANY

	SHARED_EXECUTION_ENVIRONMENT

	LOCALIZED_PRINTER

create
	make

feature {NONE} -- Initialization

	make (args: ECF_RESAVE_ARGUMENT_PARSER)
			-- Application entry point
		do
			start (args)
		end

feature {NONE} -- Execution

	start (a_options: ECF_RESAVE_ARGUMENT_PARSER)
			-- Starts application once all arguments have been parsed
		require
			a_options_attached: a_options /= Void
			a_options_is_successful: a_options.is_successful
		local
			dv: ECF_DIRECTORY_CUSTOM_ITERATOR
			l_files: ARRAYED_LIST [READABLE_STRING_32]
			l_eh: like error_handler
			l_eprinter: ERROR_CUI_PRINTER
		do
				-- Add specified files
			create l_files.make (0)
			across
				a_options.files as ic
			loop
				l_files.force (ic.item)
			end

				-- Add scanned directories
			create dv.make (agent (ia_fn: PATH; ia_files: LIST [READABLE_STRING_32])
					do
						ia_files.force (ia_fn.name)
					end (?, l_files)
				)
			if not a_options.use_directory_recusion then
				dv.set_directory_excluded_function (agent (ia_fn: PATH): BOOLEAN
						do
							Result := True -- no recursion!
						end
					)
			end
			across
				a_options.directories as ic
			loop
				dv.process_directory (create {PATH}.make_from_string (ic.item))
			end

			if l_files.is_empty then
					-- No files or directories, use current directory
				dv.process_directory (execution_environment.current_working_path)
			end

				-- Resave files
			across
				l_files as ic
			loop
				resave_config (ic.item)
			end

			l_eh := error_handler
			create l_eprinter
			if l_eh.has_warnings then
				print ("%N")
				l_eh.trace_warnings (l_eprinter)
			end
			if not l_eh.is_successful then
				print ("%N")
				l_eh.trace_errors (l_eprinter)
				(create {EXCEPTIONS}).die (1)
			end
		end

feature {NONE} -- Basic operations

	resave_config (a_file_name: READABLE_STRING_32)
			-- Loads and resaves `a_file_name' using the configuration system.
		do
			if a_file_name /= Void and then not a_file_name.is_empty and then is_file_readable (a_file_name) then
				print ("Loading configuration file '")
				localized_print (a_file_name)
				print ("'... ")
				if attached load_config (a_file_name) as l_cfg then
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

	load_config (a_file_name: READABLE_STRING_32): detachable CONF_SYSTEM
			-- Loads a configuration system from `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: is_file_readable (a_file_name)
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
						error_handler.add_error (create {SCIX}.make (a_file_name, 0, Void), False)
					else
						error_handler.add_error (create {SCLF}.make (a_file_name, 0, Void), False)
					end
				end
			else
				error_handler.add_error (create {SCFE}.make (a_file_name, 0, Void), False)
			end
		rescue
			retried := True
			retry
		end

	save_config (a_cfg: CONF_SYSTEM; a_file_name: READABLE_STRING_32): BOOLEAN
			-- Saves the configuration system `a_cfg' to `a_file_name'
		require
			a_cfg_attached: a_cfg /= Void
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: is_file_readable (a_file_name)
		local
			l_printer: like ecf_printer
			l_file: detachable PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				l_printer := ecf_printer
				a_cfg.process (l_printer)
				if not l_printer.is_error then
					create l_file.make_with_name (a_file_name)
					l_file.open_write
					l_file.put_string (l_printer.text)
					l_file.flush
					Result := True
				else
					error_handler.add_error (create {SCPR}.make (a_file_name, 0, Void), False)
				end
			else
				if l_file /= Void then
					error_handler.add_error (create {SCSF}.make (a_file_name, 0, Void), False)
				else
					error_handler.add_error (create {SCFE}.make (a_file_name, 0, Void), False)
				end
			end

			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		rescue
			retried := True
			retry
		end

	is_file_readable (fn: READABLE_STRING_GENERAL): BOOLEAN
			-- Is file `fn' readable?
		local
			f: RAW_FILE
		do
			create f.make_with_name (fn)
			Result := f.exists and then f.is_access_readable and then not f.is_directory
		end

feature {NONE} -- Access

	ecf_reader: CONF_LOAD
			-- Configuration loader
		once
			create Result.make (create {CONF_PARSE_FACTORY})
		ensure
			result_attached: Result /= Void
		end

	ecf_printer: ECF_RESAVE_PRINT_VISITOR
			-- Configuration printer
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	error_handler: MULTI_ERROR_MANAGER
			-- Error handler
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

;note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
