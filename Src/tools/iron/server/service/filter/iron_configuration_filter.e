note
	description: "IRON Configuration filter."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_CONFIGURATION_FILTER

inherit
	WSF_FILTER

	WSF_REQUEST_EXPORTER
		export
			{NONE} all
		end

feature -- Access

	uploaded_file_path: detachable PATH assign set_uploaded_file_path

feature -- Change

	set_uploaded_file_path (p: like uploaded_file_path)
		do
			uploaded_file_path := p
		end

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			ut: FILE_UTILITIES
			s: STRING
			l_continue: BOOLEAN
		do
			l_continue := True
			if attached uploaded_file_path as p then
				if ut.directory_path_exists (p) then
					req.set_uploaded_file_path (p)
				else
					res.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
					s := "tmp folder is missing %"" + p.utf_8_name + "%""
					res.put_header_line ("Content-Length:" + s.count.out)
					res.put_header_line ("Content-Type:text/plain")
					res.add_header_line ("X-Iron-Debug: uploadpath=" + p.utf_8_name)

					res.put_string (s)
					l_continue := False
				end
			end
			if l_continue then
				execute_next (req, res)
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
