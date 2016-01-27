note
	description: "Helpers to load and save Eiffel Configuration Files."
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_CONF_HELPERS

inherit
	CONF_ACCESS
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create error_handler.make
			create ecf_reader.make (create {CONF_PARSE_FACTORY})
			create ecf_printer.make
		end

feature -- Access

	config_system_from (a_file_name: READABLE_STRING_GENERAL): detachable CONF_SYSTEM
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
				l_reader.retrieve_configuration (a_file_name.as_string_32)
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

	print_conf_file (a_cfg: CONF_FILE)
			-- Print the configuration file `a_cfg' to standard output.
		require
			a_cfg_attached: a_cfg /= Void
		local
			l_printer: like ecf_printer
			retried: BOOLEAN
		do
			if not retried then
				l_printer := ecf_printer
				a_cfg.process (l_printer)
				if not l_printer.is_error then
					print (l_printer.text)
				end
			end
		rescue
			retried := True
			retry
		end

	save_conf_file (a_cfg: CONF_FILE; a_file_name: READABLE_STRING_32): BOOLEAN
			-- Saves the configuration system `a_cfg' to `a_file_name'
		require
			a_cfg_attached: a_cfg /= Void
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
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

feature -- Access: erros

	error_handler: MULTI_ERROR_MANAGER
			-- Error handler

feature {NONE} -- Access

	ecf_reader: CONF_LOAD
			-- Configuration loader

	ecf_printer: ECF_CONF_SAVE_PRINT_VISITOR
			-- Configuration printer

invariant
	ecf_reader /= Void
	ecf_printer /= Void
	error_handler /= Void
note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
