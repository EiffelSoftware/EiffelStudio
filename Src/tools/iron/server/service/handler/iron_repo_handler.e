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
		do
			if attached {like current_user} req.execution_variable ("{IRON_REPO}.user") as u then
				Result := u
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

feature -- Package

	new_package_edit_form (p: detachable IRON_REPO_PACKAGE; req: WSF_REQUEST; validating: BOOLEAN): WSF_FORM
		local
			f: WSF_FORM
			f_id: WSF_FORM_HIDDEN_INPUT
			f_name: WSF_FORM_TEXT_INPUT
			f_desc: WSF_FORM_TEXTAREA
			f_file: WSF_FORM_FILE_INPUT
			f_submit: WSF_FORM_SUBMIT_INPUT
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

			create f_file.make ("archive")
			f_file.set_label ("Upload archive zip file")
			f.extend (f_file)
			if p /= Void then
				create f_submit.make_with_text ("op", "Update")
			else
				create f_submit.make_with_text ("op", "Create")
			end
			f.extend (f_submit)


			if validating then
				f_name.set_validation_action (agent (fd: WSF_FORM_DATA)
						do
							if attached {WSF_STRING} fd.item ("name") as if_name and then if_name.value.count >= 3 then

							else
								fd.report_invalid_field ("name", "Package name should contain at least 3 characters!")
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
			if p /= Void and then p.has_archive then
				f.insert_after (create {WSF_FORM_RAW_TEXT}.make ("Has already an archive (" + p.archive_file_size.out + " octets)"), f_file)
			end

			Result := f
		end

	on_package_edit_form_processed (fd: WSF_FORM_DATA; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: IRON_REPO_HTML_RESPONSE
			s,t: STRING
			p: IRON_REPO_PACKAGE
			l_path_id: detachable READABLE_STRING_32
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
						iron.database.save_package_archive (iron_version (req), p, l_file)
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
