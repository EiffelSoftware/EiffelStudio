note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_NODE_HANDLER

inherit
	WSF_HANDLER

	WSF_SELF_DOCUMENTED_HANDLER

	SHARED_HTML_ENCODER

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

feature -- Permission		

	has_permission_to_administrate_versions (req: WSF_REQUEST): BOOLEAN
		do
			Result := attached current_user (req) as u and then user_has_permission_to_administrate_versions (u)
		end

	has_permission_to_modify_package (req: WSF_REQUEST; a_package: IRON_NODE_PACKAGE): BOOLEAN
		do
			Result := attached current_user (req) as u and then user_has_permission_to_modify_package (u, a_package)
		end

	has_permission_to_modify_package_version (req: WSF_REQUEST; a_package: IRON_NODE_VERSION_PACKAGE): BOOLEAN
		do
			Result := attached current_user (req) as u and then user_has_permission_to_modify_package_version (u, a_package)
		end

feature -- Permission user.				

	user_has_permission_to_administrate_versions (a_user: IRON_NODE_USER): BOOLEAN
		do
			Result := user_has_permission (a_user, "admin versions")
		end

	user_has_permission_to_modify_package (a_user: IRON_NODE_USER; a_package: IRON_NODE_PACKAGE): BOOLEAN
		do
			if attached a_package.owner as o then
				Result := a_user.same_user (o) or else a_user.is_administrator
			else
				Result := user_has_permission (a_user, "modify any package")
			end
		end

	user_has_permission_to_modify_package_version (a_user: IRON_NODE_USER; a_package: IRON_NODE_VERSION_PACKAGE): BOOLEAN
		do
			if attached a_package.owner as o then
				Result := a_user.same_user (o) or else a_user.is_administrator
			else
				Result := user_has_permission (a_user, "modify any package version")
			end
		end

feature -- Permission core.		

	user_has_permission (a_user: IRON_NODE_USER; a_permission: READABLE_STRING_GENERAL): BOOLEAN
		do
			if a_user.is_administrator then
				Result := True
			elseif attached a_user.roles as l_roles then
				Result := across l_roles as ic some user_role_has_permission (ic, a_permission) end
			end
		end

	user_role_has_permission (a_role: IRON_NODE_USER_ROLE; a_permission: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := False
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

	redirect_to_package_view (req: WSF_REQUEST; res: WSF_RESPONSE; a_package: IRON_NODE_VERSION_PACKAGE)
		local
			html: IRON_NODE_HTML_RESPONSE
		do
			create html.make (req, iron)
			html.set_location (req.absolute_script_url (iron.package_version_view_web_page (a_package)))
			res.send (html)
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

	package_version_from_id_path_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable IRON_NODE_VERSION_PACKAGE
		do
			if
				attached {WSF_STRING} req.path_parameter (a_name) as s_id and then
				attached iron.database.version_package (iron_version (req), s_id.value) as l_package
			then
				Result := l_package
			end
		end

--	package_from_id_path_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable IRON_NODE_PACKAGE
--		do
--			if
--				attached {WSF_STRING} req.path_parameter (a_name) as s_id and then
--				attached iron.database.package (s_id.value) as l_package
--			then
--				Result := l_package
--			end
--		end

feature -- Package form		

	new_package_edit_form (vp: detachable IRON_NODE_VERSION_PACKAGE; req: WSF_REQUEST; validating: BOOLEAN): WSF_FORM
		local
			f: WSF_FORM
			f_id: WSF_FORM_HIDDEN_INPUT
			f_name: WSF_FORM_TEXT_INPUT
			f_title: WSF_FORM_TEXT_INPUT
			f_desc: WSF_FORM_TEXTAREA
			f_tags: WSF_FORM_TEXT_INPUT
			f_archive: WSF_FORM_FILE_INPUT
			f_archive_url: WSF_FORM_TEXT_INPUT
			f_submit: WSF_FORM_SUBMIT_INPUT
			f_fieldset: WSF_FORM_FIELD_SET
			s: STRING_32
		do
			if vp /= Void then
				create f.make (req.script_url (iron.package_version_update_page (vp)), "edit_package")
				if validating then
					create f_id.make ("id")
				else
					create f_id.make_with_text ("id", vp.id.to_string_32)
				end
				f.extend (f_id)
			else
				create f.make (req.script_url (iron.package_version_create_page (iron_version (req))), "create_package")
			end
			f.set_multipart_form_data_encoding_type
			create f_name.make ("name")
			f_name.set_label ("Name")
			f_name.set_size (50)
			f.extend (f_name)

			create f_title.make ("title")
			f_title.set_label ("Title")
			f_title.set_description ("Optional title, if unset, use `name' in user interfaces")
			f_title.set_size (50)
			f.extend (f_title)

			create f_desc.make ("description")
			f_desc.set_label ("Description")
			f_desc.set_rows (6)
			f_desc.set_cols (70)
			f.extend (f_desc)

			create f_tags.make ("tags")
			f_tags.set_label ("Tags")
			f_tags.set_description ("Comma separated keywords")
			f_tags.set_size (50)
			f.extend (f_tags)

			if vp /= Void then
				create f_fieldset.make
				f_fieldset.set_legend ("Associated URIs")
				f.extend (f_fieldset)
				f_fieldset.extend_html_text ("<a href=%""+ iron.package_version_map_web_page (vp, Void) +"%">Manage associated URIs</a>")
			end

			create f_fieldset.make
			f_fieldset.set_legend ("Associated Archive")

			create f_archive.make ("archive")
			f_archive.set_label ("Upload archive file")
			f_fieldset.extend (f_archive)

			create f_archive_url.make ("archive-url")
			f_archive_url.set_label ("Get archive from url")
			f_archive_url.set_description ("If you have trouble uploading the archive file, the server can download from a public URL.")
			f_archive_url.set_size (50)
			f_fieldset.extend (f_archive_url)

			if vp /= Void and then vp.has_archive then
--				f_fieldset.insert_after (create {WSF_FORM_RAW_TEXT}.make ("Has already an archive (" + p.archive_file_size.out + " octets)"), f_archive)
				f_fieldset.extend_html_text ("Has already an archive (" + vp.archive_file_size.out + " octets)")
				f_fieldset.extend_html_text ("<div>You can delete this archive by clicking <a href=%""+ iron.package_version_archive_web_page (vp) +"?" + Method_query_parameter + "=DELETE%">[DELETE]</a></div>")
			end
			f.extend (f_fieldset)

--			f.extend (f_file)
			if vp /= Void then
				create f_submit.make_with_text ("op", "Update")
			else
				create f_submit.make_with_text ("op", "Create")
			end
			f.extend (f_submit)

			if validating then
				f_name.set_validation_action (agent (fd: WSF_FORM_DATA)
						do
							if attached {WSF_STRING} fd.item ("name") as if_name and then if_name.value.count >= 1 then

							else
								fd.report_invalid_field ("name", "Package name should contain at least 1 characters!")
							end
						end
					)
			elseif vp /= Void then
				if attached vp.name as l_name then
					f_name.set_text_value (l_name)
				end
				if attached vp.title as l_title then
					f_title.set_text_value (l_title)
				end
				if attached vp.description as l_description then
					f_desc.set_text_value (l_description)
				end
				if attached vp.tags as l_tags then
					create s.make_empty
					across
						l_tags as ic
					loop
						if not s.is_empty then
							s.append_character (',')
						end
						s.append (ic)
					end
					f_tags.set_text_value (s)
				end
			end
--			if vp /= Void and then vp.has_archive then
--				f.insert_after (create {WSF_FORM_RAW_TEXT}.make ("Has already an archive (" + vp.archive_file_size.out + " octets)"), f_file)
--			end

			Result := f
		end

	on_package_edit_form_processed (fd: WSF_FORM_DATA; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: IRON_NODE_HTML_RESPONSE
			s,t: STRING
			p: IRON_NODE_PACKAGE
			vp: detachable IRON_NODE_VERSION_PACKAGE
			l_path_id: detachable READABLE_STRING_32
			cl_path: CELL [detachable PATH]
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
							t.append (err_msg)
						end
						m.add_error_message (t)
					end
				end
				fd.apply_to_associated_form
				s.append (fd.form.to_html (create {WSF_REQUEST_THEME}.make_with_request (req)))

				m.set_title ("Edit package")
				m.set_body (s)
				res.send (m)
			else
				fd.apply_to_associated_form
				s.append (fd.form.to_html (create {WSF_REQUEST_THEME}.make_with_request (req)))
				if attached {WSF_STRING} req.path_parameter ("id") as p_id then
					l_path_id := p_id.value
				end
				if attached fd.string_item ("id") as l_id then
					if l_path_id /= Void then
						if l_id.is_case_insensitive_equal (l_path_id) then
							if attached iron.database.version_package (iron_version (req), l_id) as l_package_version then
								vp := l_package_version
								p := vp.package
							elseif attached iron.database.package (l_id) as l_package then
								p := l_package
							else
									-- Error
								fd.report_error ("Package version["+ l_id +"] not found")
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
				elseif attached fd.string_item ("name") as l_name then
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
						create p.make_empty
						p.set_name (l_name)
					end
				elseif l_path_id /= Void then
					fd.report_error ("Missing package id from post!")
					create p.make (l_path_id)
				else
					create p.make_empty
				end
				if vp = Void then
					create vp.make (p, iron_version (req))
				else
					check vp.package ~ p end
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
					if attached fd.string_item ("name") as l_name then
						p.set_name (l_name)
					end
					if attached fd.string_item ("title") as l_title then
						p.set_title (l_title)
					end
					if attached fd.string_item ("description") as l_description then
						p.set_description (l_description)
					end
					if attached fd.string_item ("tags") as l_tags then
						if attached p.tags as p_tags then
							p_tags.wipe_out
						end
						across
							l_tags.split (',') as tic
						loop
							p.add_tag (tic)
						end
					end
--					if attached fd.table_item ("links") as l_links then
--						if attached p.links as p_links then
--							p_links.wipe_out
--						end
--						across
--							l_links as l_ic
--						loop
--							p.add_link (...)
--						end
--					end
				end
				if has_permission_to_modify_package (req, p) then
					if not fd.has_error then
						if p.has_id then
							iron.database.update_package (p)

							m.add_normal_message ("Package updated [" + p.id + "]")
						else
							iron.database.update_package (p)

							m.add_normal_message ("Package created [" + p.id + "]")
						end
						iron.database.update_version_package (vp)

						if attached {WSF_UPLOADED_FILE} fd.item ("archive") as l_file then
							iron.database.save_uploaded_package_archive (vp, l_file)
						elseif attached {WSF_STRING} fd.item ("archive-url") as l_archive_url and then not l_archive_url.is_empty then
							create cl_path.put (Void)
							download (l_archive_url.url_encoded_value, cl_path, req)
							if attached cl_path.item as l_downloaded_path then
								iron.database.save_package_archive (vp, l_downloaded_path, False)
							end
						end
					end
					m.set_title ("Package [" + p.id  + "]")
					s.prepend ("<a href=%"" + req.script_url (iron.package_version_view_web_page (vp)) + "%">View package</a>")

					m.set_location (req.absolute_script_url (iron.package_version_view_web_page (vp)))

					m.set_body (s)
					res.send (m)
				else
					res.send (create {IRON_NODE_HTML_RESPONSE}.make_not_permitted (req, iron))
				end
			end
		end

feature -- Factory

	new_response_message (req: WSF_REQUEST): IRON_NODE_HTML_RESPONSE
		do
			create Result.make (req, iron)
			Result.set_iron_version (iron_version (req))
			if attached current_user (req) as u then
				Result.add_menu ("Home", iron.page (Void, ""))
				Result.add_menu ("Account (" + html_encoder.encoded_string (u.name) + ")", iron.page (Void, "/user"))
			else
				Result.add_menu ("Home", iron.page (Void, ""))
				Result.add_menu ("Account", iron.page (Void, "/user"))
			end
			if has_iron_version (req) then
				Result.add_menu ("New package", iron.package_version_create_web_page (iron_version (req)))
				Result.add_menu ("All packages", iron.package_version_list_web_page (iron_version (req)))
			end
		end

	new_not_permitted_response_message (a_package: detachable IRON_NODE_VERSION_PACKAGE; req: WSF_REQUEST): IRON_NODE_HTML_RESPONSE
		local
			s: STRING
		do
			Result := new_response_message (req)
			create s.make_from_string ("<p class=%"error%">Operation not permitted.</p>%N")
			if a_package /= Void then
				s.append ("<p><a href=%"")
				s.append (iron.package_version_view_web_page (a_package))
				s.append ("%">Back to package page %"")
				s.append (html_encoder.encoded_string (a_package.human_identifier))
				s.append ("%"</a>.</p>%N")
			end
			if attached req.http_referer as l_referer then
				s.append ("<p><a href=%"")
				s.append (l_referer)
				s.append ("%">Back to previous page</a>.</p>%N")
			end
			Result.set_body (s)
		end

	new_not_found_response_message (req: WSF_REQUEST): IRON_NODE_HTML_RESPONSE
		local
			s: STRING
		do
			Result := new_response_message (req)
			create s.make_from_string ("<p class=%"error%">Resource not found.</p>%N")
			if attached req.http_referer as l_referer then
				s.append ("<p><a href=%"")
				s.append (l_referer)
				s.append ("%">Back to previous page</a>.</p>%N")
			end
			Result.set_body (s)
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
