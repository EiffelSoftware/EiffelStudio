note
	description: "Summary description for {ADMIN_USER_ROLES_CMS_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_USER_ROLES_CMS_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature -- Execution

	process
		do
			if request.is_post_request_method then
				process_post
			else
				process_get
			end
		end

	process_get
			-- Computed response message.
		local
			b: STRING_8
			f: CMS_FORM
			l_roles: LIST [CMS_USER_ROLE]
		do
			set_title ("User roles")
			-- check Permission !!!
			create b.make_empty
			if has_permission ("administrate user roles") then
				l_roles := service.storage.user_roles
				f := new_edit_form (url (request.path_info, Void), l_roles, True)
				f.append_to_html (theme, b)
			else
				b.append ("<div class=%"denied%">Access denied</div>")
			end
			set_main_content (b)
		end

	process_post
			-- Computed response message.
		local
			b: STRING_8
			f: CMS_FORM
			l_roles: LIST [CMS_USER_ROLE]
		do
			set_title ("User roles")
			create b.make_empty

			debug ("cms")
				across
					request.form_parameters as c
				loop
					b.append ("<li>")
					b.append (html_encoded (c.item.name))
					b.append ("=")
					b.append (html_encoded (c.item.string_representation))
					b.append ("</li>")
				end
			end

			if has_permission ("administer user roles") then
				l_roles := service.storage.user_roles
				f := new_edit_form (url (request.path_info, Void), l_roles, False)
				f.submit_actions.extend (agent edit_form_submit (?, l_roles))
				f.process (Current)
				f.append_to_html (theme, b)
			else
				b.append ("<div class=%"denied%">Access denied</div>")
			end

			set_main_content (b)
		end

feature -- Forms

	edit_form_submit (fd: WSF_FORM_DATA; a_roles: LIST [CMS_USER_ROLE])
		local
			l_role: CMS_USER_ROLE
		do
			if fd.item_same_string ("op", "Apply") then
				across
					a_roles as r
				loop
					if attached fd.table_item (r.item.name) as perms then
						r.item.permissions.wipe_out
						across
							perms as c
						loop
							if attached {WSF_STRING} c.item as s then
								r.item.add_permission (s.value)
							end
						end
						service.storage.save_user_role (r.item)
					end
				end
			elseif fd.item_same_string ("op", "Add role") then
				if attached fd.string_item ("new-role") as l_new_role then
					create l_role.make (l_new_role)
					service.storage.save_user_role (l_role)
					set_redirection (url (request.path_info, Void))
				end
			elseif fd.item_same_string ("op", "Add permission") then
				if attached fd.string_item ("new-permission") as l_new_permission then
					l_role := service.storage.authenticated_user_role
					l_role.add_permission (l_new_permission)
					service.storage.save_user_role (l_role)
					set_redirection (url (request.path_info, Void))
				end
			end
		end

	new_edit_form (a_action: READABLE_STRING_8; a_roles: LIST [CMS_USER_ROLE]; a_use_data: BOOLEAN): CMS_FORM
		local
			perms: ARRAYED_SET [READABLE_STRING_8]
			tb: WSF_WIDGET_AGENT_TABLE [READABLE_STRING_8]
			i: INTEGER
			tf: WSF_FORM_TEXT_INPUT
		do
			create perms.make (10)
			perms.compare_objects
			across
				service.modules as m
			loop
				across
					m.item.permissions (service) as p
				loop
					perms.extend (p.item.name)
				end
			end
			across
				a_roles as c
			loop
				across
					c.item.permissions as p
				loop
					perms.extend (p.item)
				end
			end

			create tb.make
			tb.set_column_count (1 + a_roles.count)
			i := 1
			tb.column (i).set_title ("Permissions")
			across
				a_roles as r
			loop
				i := i + 1
				tb.column (i).set_title (r.item.name)
			end

			tb.add_css_style ("border: solid 1px #999;")
			tb.set_data (perms)
			tb.set_compute_item_function (agent (p: READABLE_STRING_8; ia_roles: LIST [CMS_USER_ROLE]; ia_use_data: BOOLEAN): WSF_WIDGET_TABLE_ROW
				local
					it: WSF_WIDGET_TABLE_ITEM
					cb: WSF_FORM_CHECKBOX_INPUT
				do
					create Result.make (1 + ia_roles.count)
					create it.make_with_text (p)
					Result.set_item (it, 1)
					across
						ia_roles as r
					loop
						create cb.make (r.item.name + "[" + p + "]")
						cb.set_text_value (p)

						if ia_use_data then
							if r.item.has_permission (p) then
								cb.set_checked (True)
							else
								cb.set_checked (False)
							end
						end
						create it.make_with_content (cb)
						Result.add_item (it)
					end
				end(?, a_roles, a_use_data)
			)

			create Result.make (a_action, "edit-user-roles")
			Result.set_method_post
			Result.extend (tb.to_computed_table)
			Result.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("op", "Apply"))

			create tf.make ("new-role")
			tf.add_css_class ("horizontal")
			tf.set_size (24)
			tf.set_label ("New user role")
			Result.extend (tf)
			Result.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("op", "Add role"))

			create tf.make ("new-permission")
			tf.add_css_class ("horizontal")
			tf.set_size (24)
			tf.set_label ("New permission")
			Result.extend (tf)
			Result.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("op", "Add permission"))



		end

end
