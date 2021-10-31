note
	date: "$Date$"
	revision: "$Revision$"

class
	FETCH_PACKAGE_API_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

	IRON_NODE_API_HANDLER
		rename
			set_iron as make
		end

create
	make

feature -- Execution	

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_get_request_method then
				handle_fetch_package (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_fetch_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			md: WSF_FORCE_DOWNLOAD_RESPONSE
			v: STRING_32
			u: FILE_UTILITIES
		do
			create v.make_empty
			if
				attached {WSF_TABLE} req.path_parameter ("vars") as l_vars
			then
				across
					l_vars as c
				loop
					if attached {WSF_STRING} c as v_string and then not v_string.is_empty then
						v.append_character ('/')
						v.append (v_string.value)
					end
				end
			end
			if attached iron.database.package_by_path (iron_version (req), v) as l_package then
				if
					attached l_package.archive_path as l_archive_path and then
					u.file_path_exists (l_archive_path)
				then
					create md.make (l_archive_path.utf_8_name)
					md.set_no_cache
					res.send (md)
						-- Increment download
					iron.database.increment_download_counter (l_package)
				else
					res.send (create {WSF_NOT_FOUND_RESPONSE}.make (req))
				end
			else
				res.send (create {WSF_NOT_FOUND_RESPONSE}.make (req))
			end
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("Download archive associated with package containing current request uri.")
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
