indexing
	description: "File loader for metric tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_FILE_LOADER

inherit
	SHARED_BENCH_NAMES

feature -- Basic operations

	parse_file (a_file: STRING; a_callback: EB_LOAD_METRIC_CALLBACKS): EB_METRIC_ERROR is
			-- Parse `a_file' using `a_callbacks'.			
			-- The result from parsing will be stored n `a_callback'.
			-- error during parsing will be returned. Return Void if no error occurred.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
			a_callback_not_void: a_callback /= Void
		local
			l_file: KL_TEXT_INPUT_FILE
			l_parser: XM_PARSER
			l_ns_cb: XM_NAMESPACE_RESOLVER
		do
			create {XM_EIFFEL_PARSER} l_parser.make
			create l_ns_cb.set_next (a_callback)
			l_parser.set_callbacks (l_ns_cb)

			create l_file.make (a_file)
			l_file.open_read
			if l_file.exists and then l_file.is_open_read then
				a_callback.set_xml_parser (l_parser)
				l_parser.parse_from_stream (l_file)
				a_callback.set_xml_parser (Void)
				l_file.close
				if a_callback.has_error then
					Result := a_callback.last_error
				end
			else
				if not l_file.is_closed then
					l_file.close
				end
				create Result.make (metric_names.err_file_not_readable (a_file))
			end
			if Result /= Void then
				Result.set_file_location (a_file)
			end
		end

	parse_from_string (a_xml: STRING; a_callback: EB_LOAD_METRIC_CALLBACKS): EB_METRIC_ERROR is
			-- Parse XML stored in `a_xml' using `a_callback'.
			-- error during parsing will be returned. Return Void if no error occurred.
		require
			a_xml_attached: a_xml /= Void
			a_callback_attached: a_callback /= Void
		local
			l_parser: XM_PARSER
			l_ns_cb: XM_NAMESPACE_RESOLVER
		do
			create {XM_EIFFEL_PARSER} l_parser.make
			create l_ns_cb.set_next (a_callback)
			l_parser.set_callbacks (l_ns_cb)
			l_parser.parse_from_string (a_xml)
			if a_callback.has_error then
				Result := a_callback.last_error
			end
		end

	backup_file (a_file: STRING) is
			-- Backup file `a_file'.
			-- `a_file' is not guaranteed to be backuped maybe because `a_file' doesn't exists or is not readable, or
			-- the chosen backup file name is not writable.
		require
			a_file_attached: a_file /= Void
		local
			l_file: RAW_FILE
			l_backup_file: RAW_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make (a_file)
				if l_file.exists and then l_file.is_readable then
					l_file.open_read
					create l_backup_file.make_open_write (backup_file_name (a_file))
					l_file.copy_to (l_backup_file)
					l_backup_file.close
					l_file.close
				end
			end
		rescue
			l_retried := True
			if l_file /= Void and then l_file.is_open_read then
				l_file.close
			end
			if l_backup_file /= Void and then l_backup_file.is_open_write then
				l_file.close
			end
			retry
		end

	backup_file_name (a_file: STRING): STRING is
			-- Backup file name for `a_file'.
		require
			a_file_attached: a_file /= Void
		do
			create Result.make_from_string (a_file)
			Result.append (".bak")
		ensure
			result_attached: Result /= Void
		end

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



end
