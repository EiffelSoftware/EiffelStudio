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
	SHARED_NAMES

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
				l_parser.parse_from_stream (l_file)
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
		end

	parse_from_string (a_xml: STRING; a_callback: XM_CALLBACKS) is
			-- Parse XML stored in `a_xml' using `a_callback'.
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
