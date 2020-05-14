note
	description: "Summary description for {CMS_ADMIN_ROLE_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_ROLES_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			execute as uri_template_execute,
			new_mapping as new_uri_template_mapping
		select
			new_uri_template_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	CMS_SHARED_SORTING_UTILITIES

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_response: CMS_RESPONSE
			s: STRING
			l_role: CMS_USER_ROLE
			l_perm: READABLE_STRING_8
			l_count: INTEGER
			user_api: CMS_USER_API
			l_full: BOOLEAN
			l_modname: READABLE_STRING_GENERAL
			l_mods: ARRAYED_LIST [READABLE_STRING_GENERAL]
			l_perms: LIST [READABLE_STRING_8]
		do
				-- At the moment the template are hardcoded, but we can
				-- get them from the configuration file and load them into
				-- the setup class.
			if api.has_permission ("admin roles") then
				user_api := api.user_api
				l_count := user_api.roles_count

				l_full := attached {WSF_STRING} req.query_parameter ("full") as p and then p.is_case_insensitive_equal ("yes")

				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)

				create s.make_empty
				if l_count > 1 then
					l_response.set_title ("Listing " + l_count.out + " Roles")
				else
					l_response.set_title ("Listing " + l_count.out + " Role")
				end

				if attached user_api.roles as lst then
					l_response.add_to_primary_tabs (api.local_link ("Permissions", l_response.location + "?full=yes"))
					l_response.add_to_primary_tabs (api.local_link ("Roles", l_response.location))

					if l_full then
						s.append ("<table class=%"cms-roles%"><tr><th>Permissions</th>")
						across
							lst as ic
						loop
							l_role := ic.item
							s.append ("<th class=%"cms_role%">")
							s.append ("<a href=%"")
							s.append (req.absolute_script_url (api.administration_path ("/role/") + l_role.id.out))
							s.append ("%">")
							s.append (html_encoded (l_role.name))
							s.append ("</a>")
							s.append ("</th>%N")
						end
						s.append ("</tr>")
						if attached user_api.role_permissions as l_role_permissions then
							create l_mods.make (l_role_permissions.count)
							across
								l_role_permissions as m_ic
							loop
								l_modname := m_ic.key
								l_mods.force (l_modname)
							end
							string_sorter.sort (l_mods)
							across
								l_mods as m_ic
							loop
								l_modname := m_ic.item
								l_perms := l_role_permissions.item (l_modname)
								s.append ("<tr><th colspan=%"" + (1 + lst.count).out + "%">")
								if l_modname.is_whitespace then
									s.append ("...")
								else
									s.append (html_encoded (l_modname))
								end
								s.append ("</th></tr>")
								if l_perms /= Void then
									across
										l_perms as p_ic
									loop
										l_perm := p_ic.item
										if not l_perm.is_whitespace then
											s.append ("<tr><td class=%"cms_role_permission%">")
											s.append (html_encoded (l_perm))
											s.append ("</td>")
											across
												lst as ic
											loop
												l_role := ic.item
												s.append ("<td>")
												if l_role.has_permission (l_perm) then
													s.append ("X")
												end
												s.append ("</td>")
											end
											s.append ("</tr>")
										end
									end
								end
							end
						end
						s.append ("</table>")
					else
						s.append ("<ul class=%"cms-roles%">%N")
						across
							lst as ic
						loop
							l_role := ic.item
							s.append ("<li class=%"cms_role%">")
							s.append ("<a href=%"")
							s.append (req.absolute_script_url (api.administration_path ("/role/") + l_role.id.out))
							s.append ("%">")
							s.append (html_encoded (l_role.name))
							s.append ("</a>")
							s.append ("</li>%N")
						end
						s.append ("</ul>%N")
					end
				end
				s.append ("<br/>")
				if l_response.has_permission ("admin roles") then
					s.append (l_response.link ("Add Role", api.administration_path_location ("add/role"), Void))
				end

				l_response.set_main_content (s)
				l_response.execute
			else
				api.response_api.send_access_denied (Void, req, res)
			end
		end
end

