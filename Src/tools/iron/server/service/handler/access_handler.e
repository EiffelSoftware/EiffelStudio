note
	description: "Summary description for {ACCESS_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ACCESS_HANDLER

inherit
	WSF_URI_HANDLER
		rename
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		select
			new_mapping
		end

	IRON_REPO_HANDLER
		rename
			set_iron as make
		end

create
	make

feature -- Execution	

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_get_request_method then
				handle_admin_package (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_admin_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: like new_response_message
			s: STRING
		do
			if req.is_content_type_accepted ("text/html") then
				m := new_response_message (req)
				if has_iron_version (req) then
					s := "<ul>"
					s.append ("<li><a href=%"" + req.script_url (iron.package_list_web_page (iron_version (req))) + "%">Package list</a></li>")
					s.append ("<li><a href=%"" + req.script_url (iron.package_create_web_page (iron_version (req))) + "%">New package</a></li>")
					s.append ("</ul>")
				elseif attached iron.database.versions as l_versions then
					s := "<ul>"
					across
						l_versions as c
					loop
						s.append ("<li><a href=%"" + req.script_url (iron.page (c.item, "/")) + "%">Version "+ c.item.value +"</a></li>")

					end
					s.append ("</ul>")
				else
					s := "..."
				end

				if attached current_user (req) as u then
					s.append ("<h2>")
					s.append ("Account ")
					s.append (m.html_encoded_string (u.name))
					s.append ("</h2>")
					if attached u.roles as l_roles then
						s.append ("<div>")
						s.append ("<span>Roles:")
						across
							l_roles as c
						loop
							s.append (" ")
							s.append (m.html_encoded_string (c.item.name))
						end
						s.append ("</span>")
						s.append ("</div>")
					end
				end

				if attached {WSF_STRING} req.item ("redirection") as l_redir then
					m.set_location (l_redir.value)
				end

				m.set_title ("Administration")
				m.set_body (s)
				res.send (m)
			else
				res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
			end
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("Index of action (authentication required).")
		end

end
