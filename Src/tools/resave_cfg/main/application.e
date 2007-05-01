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

create
	make

feature {NONE} -- Initialization

	make is
			-- Application entry point
		local
			l_parser: ARGUMENT_PARSER
		do
			create l_parser.make
			l_parser.execute (agent start (l_parser))
		end

feature {NONE} -- Execution

	start (a_options: ARGUMENT_PARSER) is
			-- Starts application once all arguments have been parsed
		require
			a_options_attached: a_options /= Void
			a_options_successful: a_options.successful
		local
			l_eh: like error_handler
			l_eprinter: ERROR_CUI_PRINTER
		do
			a_options.files.do_all (agent resave_config)
			print ("%N")

			l_eh := error_handler
			create l_eprinter
			if l_eh.has_warnings then
				l_eh.trace_warnings (l_eprinter)
			end
			if not l_eh.successful then
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
			if a_file_name /= Void and then not a_file_name.is_empty and then (create {RAW_FILE}.make (a_file_name)).exists then
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
			a_file_name_exists: (create {RAW_FILE}.make (a_file_name)).exists
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
			a_file_name_exists: (create {RAW_FILE}.make (a_file_name)).exists
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
