note
	description: "Convert ace file into ecf file"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ACE_TO_ECF_TOOL

inherit
	LOCALIZED_PRINTER

	SHARED_ACE_TO_ECF_NAMES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create arguments.make
			arguments.execute (agent process)
		end

feature -- Access	

	config_file_name: detachable PATH

feature {NONE} -- Operation

	arguments: ARGUMENT_PARSER
			-- Command line argument parser.

	process
		local
			l_ace, l_ecf: PATH
		do
			create l_ace.make_from_string (arguments.value)
			if is_file_readable (l_ace) then
				l_ecf := arguments.output_file_name
				if l_ecf = Void or else is_file_writable (l_ecf) then
					convert_ace_to_ecf (l_ace, l_ecf)
				else
					localized_print_error ({STRING_32} "ERROR: " + l_ecf.name + " is not writable.%N")
				end
			else
				localized_print_error ({STRING_32} "ERROR: " + l_ace.name + " is not readable.%N")
			end
		end

	convert_ace_to_ecf (a_ace_filename: PATH; a_ecf_filename: detachable PATH)
		require
			a_ace_filename_valid: a_ace_filename /= Void and then not a_ace_filename.is_empty
			a_ecf_filename_valid: a_ecf_filename /= Void implies not a_ecf_filename.is_empty
			a_ace_filename_readable: is_file_readable (a_ace_filename)
			a_ace_filename_writable: a_ecf_filename /= Void implies is_file_writable (a_ecf_filename)
		local
			l_load: CONF_LOAD_LACE
			l_factory: CONF_PARSE_FACTORY
			l_ecf: READABLE_STRING_32
		do
				-- load config from ace
			create l_factory
			create l_load.make (l_factory, {EIFFEL_CONSTANTS}.config_extension)
			if not arguments.has_library_conversion then
				l_load.disable_library_conversions
			end
			l_load.retrieve_configuration (a_ace_filename)
			if l_load.is_error then
				report_cannot_read_ace_file (a_ace_filename, l_load.last_error)
			elseif attached l_load.last_system as l_last_system then
					-- Ask user for a new name for the converted config file.
					-- If user does not specify one, then the processing will stop right there.
				if a_ecf_filename /= Void then
					l_ecf := a_ecf_filename.name
				else
					l_ecf := l_last_system.name + "." + {EIFFEL_CONSTANTS}.config_extension
				end
				ask_for_config_name (a_ace_filename.parent, l_ecf, agent store_converted ( l_last_system, ?))
			end
		ensure
			config_file_name_set: not has_error implies is_config_file_name_valid
		end

	report_cannot_read_ace_file (a_filename: PATH; err: detachable CONF_ERROR)
		do
			localized_print_error ("ERROR: can not read ace file%N")
			if err /= Void then
				localized_print_error (err.text)
			end
		end

	report_cannot_save_converted_file (a_filename: PATH)
		do
			localized_print_error ("ERROR: can not save converted file%N")
		end

	ask_for_config_name (a_dir_name: PATH; a_file_name: READABLE_STRING_GENERAL; a_action: PROCEDURE [PATH])
			-- Given `a_dir_name' and a proposed `a_file_name' name for the new format, ask the
			-- user if he wants to create `a_file_name' or a different name. If he said yes, then
			-- execute `a_action' with chosen file_name, otherwise do nothing.
		require
			a_dir_name_not_void: a_dir_name /= Void
			a_dir_name_not_empty: not a_dir_name.is_empty
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			a_action_not_void: a_action /= Void
		local
			l_answered: BOOLEAN
			l_path: PATH
		do
			l_path := a_dir_name
			if arguments.is_batch then
				localized_print (ace2ecf_names.batch_mode (a_file_name))
				io.put_new_line
				a_action.call ([l_path.extended (a_file_name)])
			else
				from
				until
					l_answered
				loop
					localized_print (ace2ecf_names.save_new_configuration_as (a_file_name) + ace2ecf_names.yes_or_no)
					io.read_line
					if io.last_string.item (1).as_lower = 'y' then
						a_action.call ([l_path.extended (a_file_name)])
						l_answered := True
					elseif io.last_string.item (1).as_lower = 'n' then
						from
							io.put_new_line
						until
							l_answered
						loop
							localized_print (ace2ecf_names.enter_name_for_configuration_file)
							io.read_line
							if not io.last_string.is_empty then
								a_action.call ([l_path.extended (io.last_string)])
								l_answered := True
							end
						end
					end
				end
			end
		end

	store_converted  (a_conf_system: CONF_SYSTEM; a_file_name: PATH)
			-- Store updated configuration into `file_name'.
		require
			a_conf_system_not_void: a_conf_system /= Void
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		local
			l_print: CONF_PRINT_VISITOR
			l_file: PLAIN_TEXT_FILE
		do
			create l_print.make
			a_conf_system.process (l_print)
			check
				no_error: not l_print.is_error
			end
			if is_file_writable (a_file_name) then
				create l_file.make_with_path (a_file_name)
				l_file.open_write
				l_file.put_string (l_print.text)
				l_file.close
				config_file_name := a_file_name
			else
				report_cannot_save_converted_file (a_file_name)
			end
		ensure
			config_file_name_set: not has_error implies config_file_name = a_file_name
			config_file_name_valid: not has_error implies is_config_file_name_valid
		end

feature -- Status report

	has_error: BOOLEAN


	is_config_file_name_valid: BOOLEAN
			-- Is `config_file_name' valid? That is to say exist, and is readable?
		do
			Result := attached config_file_name as fn and then not fn.is_empty and then
				is_file_readable (fn)
		end

	is_file_readable (a_file_name: PATH): BOOLEAN
			-- Does file of path `a_file_name' exist and is readable?
		require
			a_file_name_not_void: a_file_name /= Void
		local
			l_file: RAW_FILE
		do
			create l_file.make_with_path (a_file_name)
			Result := l_file.exists and then l_file.is_readable
		end

	is_file_writable (a_file_name: PATH): BOOLEAN
			-- Does file of path `a_file_name' exist and can be written/created?
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		local
			l_file: RAW_FILE
		do
			create l_file.make_with_path (a_file_name)
			Result := (l_file.exists and then l_file.is_writable) or else l_file.is_creatable
		end

invariant

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
