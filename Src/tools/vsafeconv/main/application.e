note
	description: "[
		Aplication class for the Void-Safe conversion tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Start the application.
		local
			l_parser: ARGUMENT_PARSER
		do
			create l_parser.make
			l_parser.execute (agent start (l_parser))
			if not l_parser.is_successful then
				exit_code := -1
			end
			if exit_code /= 0 then
				(create {EXCEPTIONS}).die (exit_code)
			end
		end

feature {NONE} -- Helpers

	file_helpers: FILE_HELPERS
			-- Access to file helper utilities.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	exit_code: INTEGER
			-- Application exit code.

feature {NONE} -- Basic operations

	start (a_parser: ARGUMENT_PARSER)
			-- Starts the application once all of the passed arguments have been supplied.
			--
			-- `a_parser': Argument parser used to determine the mode of operation.
		require
			a_parser_attached: a_parser /= Void
			a_parser_is_successful: a_parser.is_successful
		local
			l_vs_modifier: CONFIGURATION_VOID_SAFE_MODIFIER
			l_modifier: CONFIGURATION_MODIFIER
			l_add_safe_suffix: BOOLEAN
			l_replaced: BOOLEAN
			l_dest_file_name: STRING
		do
			if a_parser.is_void_safe then
				l_add_safe_suffix := a_parser.is_safe_suffix_added
				if l_add_safe_suffix then
					l_replaced := a_parser.is_allow_overwrite
				end

				create l_vs_modifier
				l_modifier := l_vs_modifier
				l_vs_modifier.is_safe_suffix_used := l_add_safe_suffix
			elseif a_parser.is_non_void_safe then
				create {CONFIGURATION_NON_VOID_SAFE_MODIFIER} l_modifier
			else
				check False end
			end

			if attached a_parser.configuration_files as l_files then
				io.put_string ("Beginning conversion of ")
				io.put_integer (l_files.count)
				io.put_string (" file")
				if l_files.count > 1 then
					io.put_string ("(s)")
				end
				io.put_string (".%N")

				if a_parser.is_compatibile then
					io.put_string ("Using 6.3 compatibility mode%N")
				end
					-- Set the compatibility mode.
				(create {CONF_DEFAULT_OPTION_SETTING}).set_is_63_compatible (a_parser.is_compatibile)

				io.new_line

				from l_files.start until l_files.after loop
					if attached l_files.item as l_file_name then
						io.put_string ("Processing: ")
						io.put_string (l_file_name)
						io.put_string ("...%N")
						if l_add_safe_suffix then
							l_dest_file_name := file_helpers.safe_file_name (l_file_name)
						else
							l_dest_file_name := l_file_name
						end
						if modify_configuration (l_file_name, l_dest_file_name, l_modifier, l_replaced) then
							io.put_string ("File saved to: ")
							io.put_string (l_dest_file_name)
							io.new_line
						end
						io.new_line
					end
					l_files.forth
				end
			end
		end

	modify_configuration (a_file_name: STRING; a_dest_file_name: STRING; a_modifier: CONFIGURATION_MODIFIER; a_replace: BOOLEAN): BOOLEAN
			-- Modifies a configuration file.
			--
			-- `a_file_name': The source file name to take as the base for the conversion process.
			-- `a_dest_file': A destination source file, which may be the same as the source file name.
			-- `a_modifier': A modifier to perform the conversion.
			-- `a_replace': True to replace the destination file if it exists; False otherwise.
			-- `Result': True if a modification was made; False otherwise.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_dest_file_name_attached: a_dest_file_name /= Void
			not_a_dest_file_name_is_empty: not a_dest_file_name.is_empty
			a_modifier_attached: a_modifier /= Void
		local
			l_dest_exists: BOOLEAN
			l_file: PLAIN_TEXT_FILE
			l_content: STRING
			l_new_content: STRING
			retried: BOOLEAN
		do
			if not retried then
				l_dest_exists := (create {RAW_FILE}.make (a_dest_file_name)).exists
				if a_replace or else not l_dest_exists or else a_file_name ~ a_dest_file_name then
						-- Only replace unless requested, or the destination file does not exist.

					if l_dest_exists and not a_replace then
							-- Files are different so use the destination file to make the modifications.
						create l_file.make (a_dest_file_name)
					else
							-- There is no existing dest file name or the dest file name should be replaced.
						create l_file.make (a_file_name)
					end

					if l_file.exists and then l_file.is_readable then
						l_file.open_read
						l_file.read_stream (l_file.count)
						l_content := l_file.last_string
						l_file.close

						l_new_content := a_modifier.convert_from_stream (l_content)
						if a_modifier.has_error then
							io.error.put_string ("Error: ")
							io.error.put_string (a_modifier.last_error)
							io.error.new_line
							exit_code := -1
						else
							if l_new_content /= Void and then l_new_content /~ l_content then
								if a_file_name /~ a_dest_file_name then
									create l_file.make (a_dest_file_name)
								end
								if not l_file.exists or else l_file.is_writable then
									l_file.open_write
									l_file.put_string (l_new_content)
									l_file.flush
									l_file.close
									Result := True
								else
									io.error.put_string ("Error: Unable to write to the file, please check the permissions!%N")
									exit_code := 5
								end
							else
								io.put_string ("No changes were made in the configuration file.%N")
							end
						end
					else
						io.error.put_string ("Error: Unable to read file!%N")
						exit_code := 4
					end
				else
					io.error.put_string ("Warning: Destination file already exists, no changes have been made!%N")
				end
			else
				io.error.put_string ("Error: Unexpected error!%N")
				exit_code := -1
			end
		rescue
			if attached l_file and then not l_file.is_closed then
				l_file.close
			end
			retried := True
			retry
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
