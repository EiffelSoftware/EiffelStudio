note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_NODE_API_HANDLER

inherit
	WSF_HANDLER

	WSF_SELF_DOCUMENTED_HANDLER

feature -- Change

	set_iron (i: like iron)
		do
			iron := i
		end

feature -- Access

	iron: IRON_NODE

	database: IRON_NODE_DATABASE
		do
			Result := iron.database
		end

feature -- Access

	is_authenticated (req: WSF_REQUEST): BOOLEAN
		do
			Result := current_user (req) /= Void
		end

	current_user (req: WSF_REQUEST): detachable IRON_NODE_USER
		local
			l_auth: HTTP_AUTHORIZATION
		do
			if req.has_execution_variable ("{IRON_REPO}.user") then
				if attached {like current_user} req.execution_variable ("{IRON_REPO}.user") as u then
					Result := u
				end
			elseif attached req.http_authorization as l_http_authorization then
				create l_auth.make (l_http_authorization)
				if
					attached l_auth.is_basic and then
					attached l_auth.login as u and then
					attached l_auth.password as p and then
					iron.database.is_valid_credential (u, p) and then
					attached iron.database.user (u) as l_user
				then
					req.set_execution_variable ("{IRON_REPO}.user", l_user)
					Result := l_user
				end
			end
		end

	has_iron_version (req: WSF_REQUEST): BOOLEAN
		do
			Result := attached {WSF_STRING} req.path_parameter ("version") as p_version and then not p_version.is_empty
		end

	iron_version (req: WSF_REQUEST): IRON_NODE_VERSION
		do
			if
				attached {WSF_STRING} req.path_parameter ("version") as p_version and then
				attached p_version.value as v and then v.is_valid_as_string_8
			then
				create Result.make (v.to_string_8)
			else
				create Result.make_default
			end
		end

	has_permission_to_modify_package (req: WSF_REQUEST; a_package: IRON_NODE_PACKAGE): BOOLEAN
		do
			if attached current_user (req) as u then
				Result := user_has_permission_to_modify_package (u, a_package)
			end
		end

	has_permission_to_modify_package_version (req: WSF_REQUEST; a_package: IRON_NODE_VERSION_PACKAGE): BOOLEAN
		do
			if attached current_user (req) as u then
				Result := user_has_permission_to_modify_package_version (u, a_package)
			end
		end

	user_has_permission_to_modify_package (a_user: IRON_NODE_USER; a_package: IRON_NODE_PACKAGE): BOOLEAN
		do
			if attached a_package.owner as o then
				Result := a_user.same_user (o) or else a_user.is_administrator
			else
				Result := a_user.is_administrator
			end
		end

	user_has_permission_to_modify_package_version (a_user: IRON_NODE_USER; a_package: IRON_NODE_VERSION_PACKAGE): BOOLEAN
		do
			if attached a_package.owner as o then
				Result := a_user.same_user (o) or else a_user.is_administrator
			else
				Result := a_user.is_administrator
			end
		end

feature -- Request: methods

	method_query_parameter: STRING = "_method"

	is_method_get (req: WSF_REQUEST): BOOLEAN
		do
			Result := req.is_get_request_method
		end

	is_method_delete (req: WSF_REQUEST): BOOLEAN
		do
			Result := req.is_request_method ({HTTP_REQUEST_METHODS}.method_delete)
				or else (
					req.is_get_request_method and then
					attached req.query_parameter (method_query_parameter) as m and then m.is_case_insensitive_equal ("delete")
				)
		end

	is_method_post (req: WSF_REQUEST): BOOLEAN
		do
			Result := req.is_post_request_method
		end

	is_method_put (req: WSF_REQUEST): BOOLEAN
		do
			Result := req.is_request_method ({HTTP_REQUEST_METHODS}.method_put)
				or else (
					req.is_post_request_method and then
					attached req.query_parameter (method_query_parameter) as m and then m.is_case_insensitive_equal ("put")
				)
		end

feature -- Request: accepted content type		

	accepted_content_type_parameter: STRING = "_type"

	is_content_type_text_html_accepted (req: WSF_REQUEST): BOOLEAN
		do
			Result := req.is_content_type_accepted ("text/html")
				or else (
					attached req.query_parameter (accepted_content_type_parameter) as m and then m.is_case_insensitive_equal ("html")
				)
		end

	is_content_type_application_json_accepted (req: WSF_REQUEST): BOOLEAN
		do
			Result := req.is_content_type_accepted ("application/json")
				or else (
					attached req.query_parameter (accepted_content_type_parameter) as m and then m.is_case_insensitive_equal ("json")
				)
		end

feature -- Redirection		

	redirect_to_package_version (req: WSF_REQUEST; res: WSF_RESPONSE; a_package: IRON_NODE_VERSION_PACKAGE)
		local
			m: IRON_NODE_API_RESPONSE
		do
			create m.make (req, iron)
			m.set_location (req.absolute_script_url (iron.package_version_view_resource (a_package)))
			res.send (m)
		end

feature -- Download

	download (a_url: READABLE_STRING_8; cl_path: CELL [detachable PATH]; req: WSF_REQUEST)
		local
			cl: LIBCURL_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			f: detachable FILE
		do
			if attached current_user (req) as l_user then
				create cl.make
				if attached cl.new_session (a_url) as l_sess and then l_sess.is_available then
					create ctx.make
					l_sess.set_max_redirects (-1)
					l_sess.set_is_insecure (True)
					f := new_temporary_output_file ("tmp-download-" + l_user.name)
					if f /= Void and then f.is_open_write then
						ctx.set_output_content_file (f)
						if attached l_sess.get ("", ctx) as resp then
							cl_path.replace (f.path)
						end
						f.close
					end
				end
			end
		end

	new_temporary_output_file (n: detachable READABLE_STRING_8): detachable FILE
		local
			bp: detachable PATH
			d: DIRECTORY
			i: INTEGER
		do
			bp := iron.layout.tmp_path
			create d.make_with_path (bp)
			if not d.exists then
				d.recursive_create_dir
			end
			if n /= Void then
				bp := bp.extended ("tmp-download-" + n)
			else
				bp := bp.extended ("tmp")
			end
			from
				i := 0
			until
				Result /= Void or i > 100
			loop
				i := i + 1
				create {RAW_FILE} Result.make_with_path (bp.appended ("__" + i.out))
				if Result.exists then
					Result := Void
				else
					Result.open_write
				end
			end
		ensure
			Result /= Void implies Result.is_open_write
		end

feature -- Package

	package_version_from_id_path_parameter (req: WSF_REQUEST; a_id_name: READABLE_STRING_GENERAL): detachable IRON_NODE_VERSION_PACKAGE
		require
--			request_has_id_name_path_param: req.path_parameter (a_id_name) /= Void
			request_has_version_path_param: req.path_parameter ("version") /= Void
		do
			if
				attached {WSF_STRING} req.path_parameter (a_id_name) as s_id and then
				attached iron.database.version_package (iron_version (req), s_id.value) as l_version_package
			then
				Result := l_version_package
			end
		end

	package_from_id_path_parameter (req: WSF_REQUEST; a_id_name: READABLE_STRING_GENERAL): detachable IRON_NODE_PACKAGE
		require
			request_has_id_name_path_param: req.path_parameter (a_id_name) /= Void
		do
			if
				attached {WSF_STRING} req.path_parameter (a_id_name) as s_id and then
				attached iron.database.package (s_id.value) as l_package
			then
				Result := l_package
			end
		end

feature -- Package form		

	new_package_edit_form (p: detachable IRON_NODE_VERSION_PACKAGE; req: WSF_REQUEST; validating: BOOLEAN): WSF_FORM
		local
			f: WSF_FORM
			f_id: WSF_FORM_HIDDEN_INPUT
			f_name: WSF_FORM_TEXT_INPUT
			f_title: WSF_FORM_TEXT_INPUT
			f_desc: WSF_FORM_TEXTAREA
			f_package_file: WSF_FORM_TEXTAREA
			f_archive: WSF_FORM_FILE_INPUT
			f_archive_url: WSF_FORM_TEXT_INPUT
			f_submit: WSF_FORM_SUBMIT_INPUT
			f_fieldset: WSF_FORM_FIELD_SET
		do
			if p /= Void then
				create f.make (req.script_url (iron.package_version_update_resource (p)), "edit_package")
				if validating then
					create f_id.make ("id")
				else
					create f_id.make_with_text ("id", p.id.to_string_32)
				end
				f.extend (f_id)
			else
				create f.make (req.script_url (iron.package_version_create_resource (iron_version (req))), "create_package")
			end
			f.set_multipart_form_data_encoding_type
			create f_name.make ("name")
			f_name.set_label ("Name")
			f.extend (f_name)

			create f_title.make ("title")
			f_title.set_label ("Title")
			f_title.set_description ("Optional title, if unset, use `name' in user interfaces")
			f.extend (f_title)

			create f_desc.make ("description")
			f_desc.set_label ("Description")
			f.extend (f_desc)

			create f_package_file.make ("package_info")
			f_package_file.set_label ("Package Info")
			f.extend (f_package_file)

			create f_fieldset.make
			f_fieldset.set_legend ("Associated Archive")

			create f_archive.make ("archive")
			f_archive.set_label ("Upload archive file")
			f_fieldset.extend (f_archive)

			create f_archive_url.make ("archive-url")
			f_archive_url.set_label ("Get archive from url")
			f_archive_url.set_description ("If you have trouble uploading the archive file, the server can download from a public URL.")
			f_fieldset.extend (f_archive_url)

--			if p /= Void and then p.has_archive then
----				f_fieldset.insert_after (create {WSF_FORM_RAW_TEXT}.make ("Has already an archive (" + p.archive_file_size.out + " octets)"), f_archive)
--				f_fieldset.extend_text ("Has already an archive (" + p.archive_file_size.out + " octets)")
--			end
			f.extend (f_fieldset)

--			f.extend (f_file)
			if p /= Void then
				create f_submit.make_with_text ("op", "Update")
			else
				create f_submit.make_with_text ("op", "Create")
			end
			f.extend (f_submit)

			if validating then
				f_name.set_validation_action (agent (fd: WSF_FORM_DATA)
						do
							if attached {WSF_STRING} fd.item ("name") as if_name and then if_name.value.count >= 1 then
									-- Non empty string is ok
							else
								fd.report_invalid_field ("name", "Package name should contain at least 1 characters!")
							end
						end
					)
			elseif p /= Void then
				if attached p.name as l_name then
					f_name.set_text_value (l_name)
				end
				if attached p.title as l_title then
					f_title.set_text_value (l_title)
				end
				if attached p.description as l_description then
					f_desc.set_text_value (l_description)
				end
			end
--			if p /= Void and then p.has_archive then
--				f.insert_after (create {WSF_FORM_RAW_TEXT}.make ("Has already an archive (" + p.archive_file_size.out + " octets)"), f_file)
--			end

			Result := f
		end

	on_package_edit_form_processed (fd: WSF_FORM_DATA; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: like new_response_message
			s,t: STRING
			k: READABLE_STRING_GENERAL
			p: IRON_NODE_PACKAGE
			l_path_id: detachable READABLE_STRING_32
			cl_path: CELL [detachable PATH]
			pv: detachable IRON_NODE_VERSION_PACKAGE
			l_name: detachable READABLE_STRING_32
			pif: detachable IRON_PACKAGE_INFO_FILE
		do
			m := new_response_message (req)
			create s.make_empty
			if fd.has_error or not fd.is_valid then
				if attached fd.errors as errs then
					across
						errs as e
					loop
						t := "<strong>[Error]</strong> "
						if attached e.message as err_msg then
							m.add_error_message (err_msg)
						end
					end
				end
				res.send (m)
			else
				fd.apply_to_associated_form
				if attached {WSF_STRING} req.path_parameter ("id") as p_id then
					l_path_id := p_id.value
				end
				l_name := fd.string_item ("name")
				if attached fd.string_item ("package_info") as l_package_info_text then
					pif := iron.package_info_from_text (l_package_info_text)
					if l_name = Void and pif /= Void then
						l_name := pif.package_name
					end
				else
					pif := Void
				end
				if attached fd.string_item ("id") as l_id then
					if l_path_id /= Void then
						if l_id.is_case_insensitive_equal (l_path_id) then
							if attached iron.database.version_package (iron_version (req), l_id) as l_package then
								p := l_package.package
							else
									-- Error
								debug
									fd.report_error ("Package ["+ l_id +"] not found")
								end
								create p.make (l_id)
							end
						else
							fd.report_error ("Package id mismatch! " + l_path_id.out + " and " + l_id.out)
							create p.make (l_id)
						end
					else
						fd.report_error ("Package id is missing from URI!")
						create p.make (l_id)
					end
				elseif l_name /= Void then
					check no_id_item: fd.string_item ("id") = Void end
					if attached iron.database.package_by_name (l_name) as l_package then
						p := l_package
						if l_path_id /= Void then
							if not l_package.id.is_case_insensitive_equal (l_path_id) then
								fd.report_error ("Package id mismatch! " + l_path_id.out + " and " + l_package.id.out)
							end
						end
					elseif l_path_id /= Void then
						if attached iron.database.package (l_path_id) as l_package then
							p := l_package
						else
								-- Error
							fd.report_error ("Package ["+ l_path_id +"] not found")
							create p.make_empty
							p.set_name (l_name)
						end
					else
							-- Error
--						fd.report_error ("Package named ["+ url_encoder.encoded_string (l_name) +"] not found, and id " + l_path_id + " is precised!") -- FIXME: check encoding for API
						create p.make_empty
						p.set_name (l_name)
					end
				elseif l_path_id /= Void then
					fd.report_error ("Missing package id from post!")
					create p.make (l_path_id)
				else
					create p.make_empty
				end

				if attached current_user (req) as l_user then
					if p.owner = Void then
						p.set_owner (l_user)
					elseif not user_has_permission_to_modify_package (l_user, p) then
						fd.report_error ("Only owner and administrator can modify current package.")
					end
				else
					fd.report_error ("Operation restricted to allowed user.")
				end
				if not fd.has_error then
					l_name := fd.string_item ("name")
					if l_name = Void and pif /= Void then
						l_name := pif.package_name
					end
					if l_name /= Void then
						p.set_name (l_name)
					end
					if attached fd.string_item ("title") as l_title then
						p.set_title (l_title)
					elseif pif /= Void then
						p.set_title (pif.title)
					end
					if attached fd.string_item ("description") as l_description then
						p.set_description (l_description)
					elseif pif /= Void then
						p.set_description (pif.description)
					end
					if pif /= Void then
						if attached pif.tags as l_tags then
							across
								l_tags as ic
							loop
								p.add_tag (ic)
							end
						end
							-- Links
						across
							pif.notes as ic
						loop
							k := @ ic.key
							if
								k.is_case_insensitive_equal ("title") or
								k.is_case_insensitive_equal ("description") or
								k.is_case_insensitive_equal ("tags")
							then
									-- Already handled
							elseif
								k.starts_with ("link[") and then
								ic.is_valid_as_string_8
							then
								p.add_link (k.substring (6, k.count - 1), create {IRON_NODE_LINK}.make (ic.to_string_8, Void))
							elseif
								k.starts_with ("links[") and then
								ic.is_valid_as_string_8
							then
								p.add_link (k.substring (7, k.count - 1), create {IRON_NODE_LINK}.make (ic.to_string_8, Void))
							else
								p.put (ic, k)
							end
						end
					end
				end
				if has_permission_to_modify_package (req, p) then
					if fd.has_error then
						if attached fd.errors as errs then
							across
								errs as e
							loop
								t := "<strong>[Error]</strong> "
								if attached e.message as err_msg then
									m.add_error_message (err_msg)
								end
							end
						end
						m.set_status_code ({HTTP_STATUS_CODE}.expectation_failed)
					else
						if p.has_id then
							iron.database.update_package (p)
							m.add_normal_message ("Package updated [" + p.id + "]")
						else
							iron.database.update_package (p)
							m.add_normal_message ("Package created [" + p.id + "]")
						end
						pv := database.version_package (iron_version (req), p.id)
						if pv = Void then
							create pv.make (p, iron_version (req))
							m.add_normal_message ("Package version created [" + p.id + "] v:" + pv.version.value)
							iron.database.update_version_package (pv)
						end
						if pv /= Void then
							if attached {WSF_UPLOADED_FILE} fd.item ("archive") as l_file then
								iron.database.save_uploaded_package_archive (pv, l_file)
							elseif attached {WSF_STRING} fd.item ("archive-url") as l_archive_url and then not l_archive_url.is_empty then
								create cl_path.put (Void)
								download (l_archive_url.url_encoded_value, cl_path, req)
								if attached cl_path.item as l_downloaded_path then
									iron.database.save_package_archive (pv, l_downloaded_path, False)
								end
							end
						end
					end
					if pv /= Void then
						m.set_location (req.absolute_script_url (iron.package_version_view_resource (pv)))
					else
						m.set_location (req.absolute_script_url (iron.package_view_resource (p)))
					end
					res.send (m)
				else
					m := new_not_permitted_response_message (req)
					res.send (m)
				end
			end
		end

feature -- Factory

	new_response_message (req: WSF_REQUEST): IRON_NODE_API_RESPONSE
		do
			create Result.make (req, iron)
			Result.set_iron_version (iron_version (req))
		end

	new_not_permitted_response_message (req: WSF_REQUEST): IRON_NODE_API_RESPONSE
		do
			create Result.make_not_permitted (req, iron)
			Result.set_iron_version (iron_version (req))
		end

	new_not_found_response_message (req: WSF_REQUEST): IRON_NODE_API_RESPONSE
		do
			create Result.make_not_found (req, iron)
			Result.set_iron_version (iron_version (req))
		end

feature {NONE} -- Implementation

	url_encoder: URL_ENCODER
		once
			create Result
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
