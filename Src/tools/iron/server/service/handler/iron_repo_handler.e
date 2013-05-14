note
	description: "Summary description for {IRON_REPO_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_REPO_HANDLER

inherit
	WSF_HANDLER

	WSF_SELF_DOCUMENTED_HANDLER

feature -- Change

	set_iron (i: like iron)
		do
			iron := i
		end

feature -- Access

	iron: IRON_REPO

	database: IRON_REPO_DATABASE
		do
			Result := iron.database
		end

feature -- Access

	is_authenticated (req: WSF_REQUEST): BOOLEAN
		do
			Result := current_user (req) /= Void
		end

	current_user (req: WSF_REQUEST): detachable IRON_REPO_USER
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

	iron_version (req: WSF_REQUEST): IRON_REPO_VERSION
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

	redirect_to_package_view (req: WSF_REQUEST; res: WSF_RESPONSE; a_package: IRON_REPO_PACKAGE)
		local
			html: IRON_REPO_HTML_RESPONSE
		do
			create html.make (req, iron)
			html.set_location (iron.package_view_web_page (iron_version (req), a_package))
			res.send (html)
		end

feature -- Download

	download (a_url: READABLE_STRING_8; cl_path: CELL [detachable PATH]; req: WSF_REQUEST)
		local
			cl: LIBCURL_HTTP_CLIENT
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			f: detachable RAW_FILE
			bp: detachable PATH
			i: INTEGER
		do
			if attached current_user (req) as l_user then
				create cl.make
				if attached cl.new_session (a_url) as l_sess and then l_sess.is_available then
					create ctx.make
					l_sess.set_max_redirects (-1)
					l_sess.set_is_insecure (True)
					create bp.make_from_string ("tmp-download-" + l_user.name)
					from
						i := 0
					until
						f /= Void or i > 100
					loop
						i := i + 1
						create f.make_with_path (bp.appended ("__" + i.out))
						if f.exists then
							f := Void
						else
							f.open_write
						end
					end
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

feature -- Package

	package_from_id_path_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL): detachable IRON_REPO_PACKAGE
		do
			if
				attached {WSF_STRING} req.path_parameter (a_name) as s_id and then
				attached iron.database.package (iron_version (req), s_id.value) as l_package
			then
				Result := l_package
			end
		end

feature -- Package form		

	new_package_edit_form (p: detachable IRON_REPO_PACKAGE; req: WSF_REQUEST; validating: BOOLEAN): WSF_FORM
		local
			f: WSF_FORM
			f_id: WSF_FORM_HIDDEN_INPUT
			f_name: WSF_FORM_TEXT_INPUT
			f_desc: WSF_FORM_TEXTAREA
			f_archive: WSF_FORM_FILE_INPUT
			f_archive_url: WSF_FORM_TEXT_INPUT
			f_submit: WSF_FORM_SUBMIT_INPUT
			f_fieldset: WSF_FORM_FIELD_SET
		do
			if p /= Void then
				create f.make (req.script_url (iron.package_update_page (iron_version (req), p)), "edit_package")
				if validating then
					create f_id.make ("id")
				else
					create f_id.make_with_text ("id", p.id.to_string_32)
				end
				f.extend (f_id)
			else
				create f.make (req.script_url (iron.package_create_page (iron_version (req))), "create_package")
			end
			f.set_multipart_form_data_encoding_type
			create f_name.make ("name")
			f_name.set_label ("Name")
			f.extend (f_name)

			create f_desc.make ("description")
			f_desc.set_label ("Description")
			f.extend (f_desc)

			create f_fieldset.make
			f_fieldset.set_legend ("Associated Archive")

			create f_archive.make ("archive")
			f_archive.set_label ("Upload archive zip file")
			f_fieldset.extend (f_archive)

			create f_archive_url.make ("archive-url")
			f_archive_url.set_label ("Get archive from url")
			f_archive_url.set_description ("If you have trouble uploading the archive file, the server can download from a public URL.")
			f_fieldset.extend (f_archive_url)

			if p /= Void and then p.has_archive then
--				f_fieldset.insert_after (create {WSF_FORM_RAW_TEXT}.make ("Has already an archive (" + p.archive_file_size.out + " octets)"), f_archive)
				f_fieldset.extend_text ("Has already an archive (" + p.archive_file_size.out + " octets)")
				f_fieldset.extend_text ("<div>You can delete this archive by clicking <a href=%""+ iron.package_archive_web_page (iron_version (req), p) +"?_method=DELETE%">[DELETE]</a></div>")
			end
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

							else
								fd.report_invalid_field ("name", "Package name should contain at least 1 characters!")
							end
						end
					)
			elseif p /= Void then
				if attached p.name as l_name then
					f_name.set_text_value (l_name)
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
			m: IRON_REPO_HTML_RESPONSE
			s,t: STRING
			p: IRON_REPO_PACKAGE
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
						if attached e.item.message as err_msg then
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
							if attached iron.database.package (iron_version (req), l_id) as l_package then
								p := l_package
							else
									-- Error
								fd.report_error ("Package ["+ l_id +"] not found")
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
				elseif l_path_id /= Void then
					fd.report_error ("Missing package id from post!")
					create p.make (l_path_id)
				else
					create p.make_empty
				end

				if attached current_user (req) as l_user then
					if attached p.owner as o and then not o.name.is_case_insensitive_equal (l_user.name) then
						fd.report_error ("Onbly owner can modify current package.")
					else
						p.set_owner (l_user)
					end
				else
					fd.report_error ("Operation restricted to allowed user.")
				end
				if not fd.has_error then
					if attached fd.string_item ("name") as l_name then
						p.set_name (l_name)
					end
					if attached fd.string_item ("description") as l_description then
						p.set_description (l_description)
					end
				end
				if not fd.has_error then
					if p.has_id then
						iron.database.update_package (iron_version (req), p)
						m.add_normal_message ("Package updated [" + p.id + "]")
					else
						iron.database.update_package (iron_version (req), p)
						m.add_normal_message ("Package created [" + p.id + "]")
					end

					if attached {WSF_UPLOADED_FILE} fd.item ("archive") as l_file then
						iron.database.save_uploaded_package_archive (iron_version (req), p, l_file)
					elseif attached {WSF_STRING} fd.item ("archive-url") as l_archive_url then
						create cl_path.put (Void)
						download (l_archive_url.url_encoded_value, cl_path, req)
						if attached cl_path.item as l_downloaded_path then
							iron.database.save_package_archive (iron_version (req), p, l_downloaded_path, False)
						end
					end
				end

				m.set_title ("Package [" + p.id  + "]")
				s.prepend ("<a href=%"" + req.script_url (iron.package_view_web_page (iron_version (req), p)) + "%">View package</a>")

				m.set_location (req.absolute_script_url (iron.package_view_web_page (iron_version (req), p)))

				m.set_body (s)
				res.send (m)
			end
		end

feature -- Factory

	new_response_message (req: WSF_REQUEST): IRON_REPO_HTML_RESPONSE
		do
			create Result.make (req, iron)
			Result.set_iron_version (iron_version (req))
			if attached current_user (req) as u then
				Result.add_menu ("Account (" + u.name + ")", iron.page (Void, ""))
			else
				Result.add_menu ("Account", iron.page (Void, ""))
			end
			if has_iron_version (req) then
				Result.add_menu ("List of packages", iron.package_list_web_page (iron_version (req)))
				Result.add_menu ("New package", iron.package_create_web_page (iron_version (req)))
			end
		end

end
