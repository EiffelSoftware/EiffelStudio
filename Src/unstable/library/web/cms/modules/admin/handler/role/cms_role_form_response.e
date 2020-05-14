note
	description: "Summary description for {CMS_ROLE_FORM_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ROLE_FORM_RESPONSE

inherit
	CMS_RESPONSE

	CMS_SHARED_SORTING_UTILITIES

create
	make

feature -- Query

	role_id_path_parameter (req: WSF_REQUEST): INTEGER_64
			-- Role id passed as path parameter for request `req'.
		local
			s: READABLE_STRING_GENERAL
		do
			if attached {WSF_STRING} req.path_parameter ("id") as p_nid then
				s := p_nid.value
				if s.is_integer_64 then
					Result := s.to_integer_64
				end
			end
		end

feature -- Process

	process
			-- Computed response message.
		local
			b: STRING_8
			uid: INTEGER_64
			user_api: CMS_USER_API
			lnk: CMS_LINK
		do
			user_api := api.user_api
			create b.make_empty
			uid := role_id_path_parameter (request)
			if uid > 0 and then attached user_api.user_role_by_id (uid.to_integer) as l_role then
				if l_role.has_id then
					lnk := api.administration_link (translation ("View", Void), "role/" + l_role.id.out)
					lnk.set_weight (1)
					add_to_primary_tabs (lnk)
					lnk := api.administration_link (translation ("Edit", Void), "role/" + l_role.id.out + "/edit")
					lnk.set_weight (2)
					add_to_primary_tabs (lnk)

					lnk := api.administration_link (translation ("Delete", Void), "role/" + l_role.id.out + "/delete")
					lnk.set_weight (3)
					add_to_primary_tabs (lnk)

				end

				fixme ("Issues with  WSD_FORM_DATA.apply_to_associated_form")
					-- if we have a WSF_FORM_CHECKBOK_INPUT, cheked inputs, are not preserverd in case of error.
				if location.ends_with_general ("/edit") then
					edit_form (l_role)
				elseif location.ends_with_general ("/delete") then
					delete_form (l_role)
				end
			else
				new_form
			end
			lnk := api.administration_link (translation ("<< Roles", Void), "roles")
			lnk.set_weight (10)
			add_to_primary_tabs (lnk)

		end

feature -- Process Edit

	edit_form (a_role: CMS_USER_ROLE)
		local
			f: like new_edit_form
			b: STRING
			fd: detachable WSF_FORM_DATA
		do
			create b.make_empty
			f := new_edit_form (a_role, request_url (Void), "edit-user-role")
			api.hooks.invoke_form_alter (f, fd, Current)
			if request.is_post_request_method then
				f.validation_actions.extend (agent edit_form_validate(?,a_role, b))
				f.submit_actions.extend (agent edit_form_submit(?, a_role, b))
				f.process (Current)
				fd := f.last_data
			end

			if attached redirection as l_location then
					-- FIXME: Hack for now
				set_title (a_role.name)
				b.append (html_encoded (a_role.name) + " saved")
			else
				set_title (formatted_string (translation ("Edit $1 #$2", Void), [a_role.name, a_role.id]))
				f.append_to_html (wsf_theme, b)
			end
			set_main_content (b)
		end

feature -- Process Delete

	delete_form (a_role: CMS_USER_ROLE)
		local
			f: like new_delete_form
			b: STRING
			fd: detachable WSF_FORM_DATA
		do
			create b.make_empty
			f := new_delete_form (a_role, request_url (Void), "delete-user-role")
			api.hooks.invoke_form_alter (f, fd, Current)
			if request.is_post_request_method then
				f.process (Current)
				fd := f.last_data
			end

			if attached redirection as l_location then
					-- FIXME: Hack for now
				set_title (a_role.name)
				b.append (html_encoded (a_role.name) + " deleted")
			else
				set_title (formatted_string (translation ("Delete $1 #$2", Void), [a_role.name, a_role.id]))
				f.append_to_html (wsf_theme, b)
			end
			set_main_content (b)
		end

feature -- Process New

	new_form
		local
			f: like new_edit_form
			b: STRING
			fd: detachable WSF_FORM_DATA
			l_role: detachable CMS_USER_ROLE
		do
			create b.make_empty
			f := new_edit_form (l_role, request_url (Void), "create-role")
			api.hooks.invoke_form_alter (f, fd, Current)
			if request.is_post_request_method then
				f.validation_actions.extend (agent new_form_validate(?, b))
				f.submit_actions.extend (agent edit_form_submit(?, l_role, b))
				f.process (Current)
				fd := f.last_data
			end
			if attached redirection as l_location then
					-- FIXME: Hack for now
				if attached l_role then
					set_title (l_role.name)
					b.append (html_encoded (l_role.name) + " Saved")
				end
			else
				if attached l_role then
					set_title (formatted_string (translation ("Saved $1 #$2", Void), [l_role.name, l_role.id]))
				end
				f.append_to_html (wsf_theme, b)
			end
			set_main_content (b)
		end

feature -- Form

	edit_form_submit (fd: WSF_FORM_DATA; a_role: detachable CMS_USER_ROLE; b: STRING)
		local
			l_save_role: BOOLEAN
			l_update_role: BOOLEAN
		do
			l_save_role := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string ("Create role")
			if l_save_role then
				debug ("cms")
					across
						fd as c
					loop
						b.append ("<li>" + html_encoded (c.key) + "=")
						if attached c.item as v then
							b.append (html_encoded (v.string_representation))
						end
						b.append ("</li>")
					end
				end
				create_role (fd)
			else
				l_update_role := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string ("Update role")
				if l_update_role then
					debug ("cms")
						across
							fd as c
						loop
							b.append ("<li>" + html_encoded (c.key) + "=")
							if attached c.item as v then
								b.append (html_encoded (v.string_representation))
							end
							b.append ("</li>")
						end
					end
					if a_role /= Void then
						update_role (fd, a_role)
					else
						fd.report_error ("Missing Role")
					end
				end
			end
		end

	edit_form_validate (fd: WSF_FORM_DATA; a_role: CMS_USER_ROLE; b: STRING)
		do
			if attached fd.string_item ("op") as f_op then
				if f_op.is_case_insensitive_equal_general ("Update role") then
					if
						attached fd.string_item ("role") as l_role and then
					   	not a_role.name.is_case_insensitive_equal (l_role)
					then
						if attached api.user_api.user_role_by_name (l_role) then
							fd.report_invalid_field ("role", "Role already taken!")
						end
					else
						if fd.string_item ("role") = Void then
							fd.report_invalid_field ("role", "missing role")
						end
					end
					if attached {WSF_TABLE} fd.item ("new_cms_permissions[]") as l_perm then
						a_role.permissions.compare_objects
						across
							l_perm.values as ic
						loop
							if attached {WSF_STRING} ic.item as p then
								if not p.value.is_valid_as_string_8 then
									fd.report_invalid_field ("new_cms_permissions[]", "Permission " + html_encoded (p.value) + " should not have any unicode character!")
								elseif across a_role.permissions as p_ic some p_ic.item.is_case_insensitive_equal_general (p.value) end then
									fd.report_invalid_field ("new_cms_permissions[]", "Permission " + html_encoded (p.value) + " already exists!")
								end
							end
						end
					end
				end
			end
		end

	new_edit_form (a_role: detachable CMS_USER_ROLE; a_url: READABLE_STRING_8; a_name: STRING;): CMS_FORM
			-- Create a web form named `a_name' for uSER `a_YSER' (if set), using form action url `a_url'.
		local
			f: CMS_FORM
			th: WSF_FORM_HIDDEN_INPUT
		do
			create f.make (a_url, a_name)
			create th.make ("role-id")
			if a_role /= Void then
				th.set_text_value (a_role.id.out)
			else
				th.set_text_value ("0")
			end
			f.extend (th)
			populate_form (f, a_role)
			Result := f
		end

	new_form_validate (fd: WSF_FORM_DATA; b: STRING)
		do
			if attached fd.string_item ("op") as f_op then
				if f_op.is_case_insensitive_equal_general ("Create role") then
					if attached fd.string_item ("role") as l_role then
						if attached api.user_api.user_role_by_name (l_role) then
							fd.report_invalid_field ("role", "Role already taken!")
						end
					else
						fd.report_invalid_field ("role", "missing role")
					end
				end
			end
		end

	new_delete_form (a_role: detachable CMS_USER_ROLE; a_url: READABLE_STRING_8; a_name: STRING;): CMS_FORM
			-- Create a web form named `a_name' for role `a_role' (if set), using form action url `a_url'.
		local
			f: CMS_FORM
			ts: WSF_FORM_SUBMIT_INPUT
		do
			create f.make (a_url, a_name)
			f.extend_html_text ("<br/>")
			f.extend_html_text ("<legend>Are you sure you want to delete?</legend>")

				-- TODO check if we need to check for has_permissions!!
			if a_role /= Void and then a_role.has_id then
				create ts.make ("op")
				ts.set_default_value ("Delete")
				fixme ("[
					ts.set_default_value (translation ("Delete"))
				]")
				f.extend (ts)
				create ts.make ("op")
				ts.set_default_value ("Cancel")
				ts.set_formmethod ("GET")
				ts.set_formaction (api.administration_path ("/role/" + a_role.id.out))
				f.extend (ts)
			end
			Result := f
		end

	populate_form (a_form: WSF_FORM; a_role: detachable CMS_USER_ROLE)
			-- Fill the web form `a_form' with data from `a_node' if set,
			-- and apply this to content type `a_content_type'.
		local
			ti: WSF_FORM_TEXT_INPUT
--			fe: WSF_FORM_EMAIL_INPUT
			fs: WSF_FORM_FIELD_SET
			cb: WSF_FORM_CHECKBOX_INPUT
			ts: WSF_FORM_SUBMIT_INPUT
--			tb: WSF_FORM_BUTTON_INPUT
			lab: WSF_WIDGET_TEXT
			l_role_permissions: detachable LIST [READABLE_STRING_8]
			l_module_names: ARRAYED_LIST [READABLE_STRING_GENERAL]
			l_mod_name: READABLE_STRING_GENERAL
		do
			if attached a_role as l_role then
				create fs.make
				fs.set_legend ("User Role")
				create ti.make_with_text ("role", a_role.name)
				ti.set_label ("Role")
				ti.enable_required
				fs.extend (ti)
				a_form.extend (fs)

				a_form.extend_html_text ("<br/>")

				create fs.make
				fs.set_legend ("Permissions")

				if
					attached api.user_api.role_permissions as l_permissions_by_module
				then
					l_role_permissions := l_role.permissions
					l_role_permissions.compare_objects

					create l_module_names.make (l_permissions_by_module.count)
					across
						l_permissions_by_module as mod_ic
					loop
						l_module_names.force (mod_ic.key)
					end
					string_sorter.sort (l_module_names)
					across
						l_module_names as mod_ic
					loop
						l_mod_name := mod_ic.item
						if
							attached l_permissions_by_module.item (l_mod_name) as l_permissions and then
							not l_permissions.is_empty
						then
							if l_mod_name.is_whitespace then
								l_mod_name := "... "
							end

							create lab.make_with_text ("<strong>" + html_encoded (l_mod_name) + " module</strong>")

							fs.extend (lab)
							string_sorter.sort (l_permissions)
							across l_permissions as ic loop
								create cb.make_with_value ("cms_permissions", ic.item.to_string_32)
								cb.set_checked (across l_role_permissions as rp_ic some rp_ic.item.is_case_insensitive_equal (ic.item) end)
								cb.set_title (ic.item.to_string_32)
								fs.extend (cb)
							end
						end
					end
				end
				create ti.make ("new_cms_permissions[]")
				fs.extend (ti)
				fs.extend_html_text ("<div class=%"input_fields_wrap%"></div>")
				fs.extend_html_text ("<button class=%"add_field_button%">Add More Permissions</button>")


				a_form.extend (fs)
				add_javascript_content (script_add_remove_items)

				create ts.make ("op")
				ts.set_default_value ("Update role")
				a_form.extend (ts)
				a_form.extend_html_text ("<hr>")

			else
				create fs.make
				fs.set_legend ("User Role")
				create ti.make ("role")
				ti.set_label ("Role")
				ti.enable_required
				fs.extend (ti)
				a_form.extend (fs)
				a_form.extend_html_text ("<br/>")
				create ts.make ("op")
				ts.set_default_value ("Create role")
				a_form.extend (ts)
				a_form.extend_html_text ("<hr>")
			end
		end

	update_role (a_form_data: WSF_FORM_DATA; a_role: CMS_USER_ROLE)
			-- Update node `a_node' with form_data `a_form_data' for the given content type `a_content_type'.
		local
			l_perm: READABLE_STRING_GENERAL
		do
			if attached a_form_data.string_item ("op") as f_op then
				if f_op.is_case_insensitive_equal_general ("Update role") then
					if
						attached a_form_data.string_item("role") as l_role_name and then
						attached a_form_data.string_item ("role-id") as l_role_id
						and then attached {CMS_USER_ROLE} api.user_api.user_role_by_id (l_role_id.to_integer) as l_role
					then
						if attached {WSF_STRING} a_form_data.item ("cms_permissions") as u_role then
							a_role.permissions.wipe_out
							a_role.add_permission (api.utf_8_encoded (u_role.value)) -- TODO: utf-8 or require valid string 8?
						elseif attached {WSF_MULTIPLE_STRING} a_form_data.item ("cms_permissions") as u_permissions then
							a_role.permissions.wipe_out
								-- Enable checked permissions.
							across
								u_permissions as ic
							loop
								l_perm := ic.item.value
								if not l_perm.is_whitespace then
									a_role.add_permission (api.utf_8_encoded (l_perm)) -- TODO: utf-8 or require valid string 8?
								end
							end
						else
							a_role.permissions.wipe_out
						end
						if attached {WSF_TABLE} a_form_data.item ("new_cms_permissions[]") as l_cms_perms then
								-- Add new permissions as checked.
							across
								l_cms_perms.values as ic
							loop
								if attached {WSF_STRING} ic.item as p then
									l_perm := p.value
									if not l_perm.is_whitespace then
										a_role.add_permission (api.utf_8_encoded (l_perm))
									end
								end
							end
						end

						if not a_form_data.has_error then
							a_role.set_name (l_role_name)
							api.user_api.save_user_role (a_role)
							if not api.user_api.has_error then
								add_success_message ("Permissions updated")
								set_redirection (absolute_url (api.administration_path_location ("role/" + a_role.id.out), Void))
							else
								add_error_message ("Error during permissions update operation.")
							end
						end
					else
						a_form_data.report_error ("Missing Role")
					end
				end
			end
		end

	create_role (a_form_data: WSF_FORM_DATA)
		local
			u: CMS_USER_ROLE
		do
			if attached a_form_data.string_item ("op") as f_op then
				if f_op.is_case_insensitive_equal_general ("Create role") then
					if attached a_form_data.string_item ("role") as l_role then
						create u.make (l_role)
						api.user_api.save_user_role (u)
						if api.user_api.has_error then
								-- handle error
						else
							add_success_message ("Created Role " + link (l_role, api.administration_path_location ("role/" + u.id.out), Void))
							set_redirection (absolute_url (api.administration_path_location ("role/" + u.id.out), Void))
						end
					else
						a_form_data.report_invalid_field ("username", "Missing role!")
					end
				end
			end
		end

feature -- Generation

	script_add_remove_items: STRING = "[
				$(document).ready(function() {
			    var wrapper         = $(".input_fields_wrap"); //Fields wrapper
			    var add_button      = $(".add_field_button"); //Add button ID

			    $(add_button).click(function(e){ //on add input button click
			        e.preventDefault();
			        $(wrapper).append('<div><input type="text" name="new_cms_permissions[]"/><a href="#" class="remove_field">Remove</a></div>'); //add input box
			    });

			    $(wrapper).on("click",".remove_field", function(e){ //user click on remove text
			        e.preventDefault(); $(this).parent('div').remove(); x--;
			    })
			});
	]"

end
