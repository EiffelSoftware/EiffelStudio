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
			u: CMS_USER_ROLE
			l_count: INTEGER
			user_api: CMS_USER_API
		do
				-- At the moment the template are hardcoded, but we can
				-- get them from the configuration file and load them into
				-- the setup class.


			user_api := api.user_api

			l_count := user_api.roles_count

			create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)

			create s.make_empty
			if l_count > 1 then
				l_response.set_title ("Listing " + l_count.out + " Roles")
			else
				l_response.set_title ("Listing " + l_count.out + " Role")
			end

			if attached user_api.roles as lst then
				s.append ("<ul class=%"cms-roles%">%N")
				across
					lst as ic
				loop
					u := ic.item
					s.append ("<li class=%"cms_role%">")
					s.append ("<a href=%"")
					s.append (req.absolute_script_url (api.administration_path ("/role/") + u.id.out))
					s.append ("%">")
					s.append (html_encoded (u.name))
					s.append ("</a>")
					s.append ("</li>%N")
				end
				s.append ("</ul>%N")
			end

			if l_response.has_permission ("admin roles") then
				s.append (l_response.link ("Add Role", api.administration_path_location ("add/role"), Void))
			end


			l_response.set_main_content (s)
			l_response.execute
		end
end

