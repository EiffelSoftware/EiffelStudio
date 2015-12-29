note
	description: "Summary description for {ARCHIVE_PACKAGE_API_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARCHIVE_PACKAGE_API_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

	IRON_NODE_API_HANDLER
		rename
			set_iron as make
		end

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature -- Execution	

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if is_method_post (req) or is_method_put (req) then
				handle_post (req, res)
			elseif is_method_delete (req) then
				handle_delete (req, res)
			elseif is_method_get (req) then
				handle_get (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
--			html: like new_response_message
--			s: STRING
		do
--			if is_content_type_text_html_accepted (req) then
--				req.is_content_type_accepted ("text/html") then
--				html := new_response_message (req)
--				create s.make_empty

--				html.set_title ("Archive ..")
--				html.set_body (s)
--				res.send (html)
--			else
				handle_download_package (req, res)
--			end
		end

	handle_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			cl: CELL [detachable PATH]
			m: like new_response_message
		do
			if attached package_version_from_id_path_parameter (req, "id") as l_package then
				if has_permission_to_modify_package_version (req, l_package) then
					m := new_response_message (req)
					m.add_normal_message (req.absolute_script_url (iron.package_version_view_resource (l_package)))

					if attached {WSF_UPLOADED_FILE} req.form_parameter ("file") as l_uploaded_file then
						iron.database.save_uploaded_package_archive (l_package, l_uploaded_file)
						m.add_normal_message ("archive uploaded")
						res.send (m)
					elseif attached {WSF_STRING} req.form_parameter ("url") as l_url then
						create cl.put (Void)
						download (l_url.url_encoded_value, cl, req)
						if attached cl.item as p then
							iron.database.save_package_archive (l_package, p, False)
							m.add_normal_message ("archive uploaded")
							res.send (m)
						else
							res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
						end
					elseif req.content_length_value > 0 then
						if attached new_temporary_output_file ("tmp-uploaded-file") as f then
							debug ("ssd_file_delay")
								execution_environment.sleep (1_000_000_000)
							end
							req.read_input_data_into_file (f)
							f.close
							check all_data_fetched: f.count.to_natural_64 = req.content_length_value end

							iron.database.save_package_archive (l_package, f.path, False)
							m.add_normal_message ("archive uploaded")
							if l_package.has_archive then
								m.add_normal_message ("archive_size=" + l_package.archive_file_size.out)

									-- Save package data .. especially the new hash
								iron.database.update_version_package (l_package)
								if attached l_package.archive_hash as l_hash then
									m.add_normal_message ("archive_hash=" + l_hash.out)
								end
							else
								m.add_error_message ("archive is missing!!")
							end
							res.send (m)
						else
							res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
						end
					else
						res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
					end
				else
					res.send (new_not_permitted_response_message (req))
				end
			else
				res.send (new_not_found_response_message (req))
			end
		end

	handle_delete (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached package_version_from_id_path_parameter (req, "id") as l_package then
				if has_permission_to_modify_package_version (req, l_package) then
					if l_package.has_archive then
						iron.database.delete_package_archive (l_package)
					end
					redirect_to_package_version (req, res, l_package)
				else
					res.send (new_not_permitted_response_message (req))
				end
			else
				res.send (new_not_found_response_message (req))
			end
		end

	handle_download_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WSF_FORCE_DOWNLOAD_RESPONSE
		do
			if attached package_version_from_id_path_parameter (req, "id") as l_package then
				if attached l_package.archive_path as p then
					create m.make (p.name)
					m.set_base_name (l_package.id.as_lower + ".tar.bz2")
					m.set_no_cache
					res.send (m)
					iron.database.increment_download_counter (l_package)
				else
					res.send (new_not_found_response_message (req))
				end
			else
				res.send (new_not_found_response_message (req))
			end
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("Download archive for package {id}.")
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
