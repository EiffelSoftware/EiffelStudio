note
	description: "Summary description for {CMS_ADMIN_USER_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_USERS_HANDLER

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
			u: CMS_USER
			l_page_helper: CMS_PAGINATION_GENERATOR
			s_pager: STRING
			l_count: INTEGER
			user_api: CMS_USER_API
			l_display_name: READABLE_STRING_32
			ago: DATE_TIME_AGO_CONVERTER
		do
				-- At the moment the template are hardcoded, but we can
				-- get them from the configuration file and load them into
				-- the setup class.

			if api.has_permission ({CMS_ADMIN_MODULE_ADMINISTRATION}.perm_admin_users) then
				user_api := api.user_api

				l_count := user_api.users_count

				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)

				create s.make_empty
				if l_count > 1 then
					l_response.set_title ("Listing " + l_count.out + " users")
				else
					l_response.set_title ("A single user")
				end

				create s_pager.make_empty
				create l_page_helper.make (api.administration_path_location ("users/?page={page}&size={size}"), user_api.users_count.as_natural_64, 25) -- FIXME: Make this default page size a global CMS settings
				l_page_helper.get_setting_from_request (req)
				if l_page_helper.has_upper_limit and then l_page_helper.pages_count > 1 then
					l_page_helper.append_to_html (l_response, s_pager)
					if l_page_helper.page_size > 25 then
						s.append (s_pager)
					end
				end

				if attached user_api.recent_users (create {CMS_DATA_QUERY_PARAMETERS}.make (l_page_helper.current_page_offset, l_page_helper.page_size)) as lst then
					s.append ("<ul class=%"cms-users%">%N")
					create ago.make
					across
						lst as ic
					loop
						u := ic.item
						s.append ("<li class=%"user%">")
						s.append ("<span class=%"identifier%"><a href=%"")
						s.append (req.absolute_script_url (api.administration_path ("/user/" + u.id.out)))
						s.append ("%">")
						l_display_name := user_api.user_display_name (u)
						s.append (html_encoded (l_display_name))
						if not l_display_name.same_string (u.name) then
							s.append (" [")
							s.append (html_encoded (u.name))
							s.append ("]")
						end
						s.append ("</a></span>")
						if attached u.email as l_email then
							s.append (" <span class=%"email%">")
							s.append (api.html_encoded (l_email))
							s.append ("</span>")
						end
						s.append (" <span class=%"roles%">")
						if attached user_api.user_roles (u) as l_roles and then not l_roles.is_empty then
							across
								l_roles as ic_roles
							loop
								s.append (html_encoded (ic_roles.item.name))
								s.append (" ")
							end
						end
						s.append ("</span>")
						s.append (" <span>Last signed in: ")
						if attached u.last_login_date as dt then
							s.append (api.html_encoded (ago.smart_date_duration (dt)))
						else
							s.append ("Never")
						end
						s.append ("</span>")
						s.append (" <span>Created: ")
						s.append (api.html_encoded (ago.short_date (u.creation_date)))
						s.append ("</span>")

						s.append ("</li>%N")
					end
					s.append ("</ul>%N")
				end
					-- Again the pager at the bottom, if needed
				s.append (s_pager)

				if l_response.has_permission ("manage " + {CMS_ADMIN_MODULE}.name) then
					s.append (api.link ("Add User", api.administration_path_location ("add/user"), Void))
				end

				l_response.set_main_content (s)
				l_response.execute
			else
				send_access_denied (req, res)
			end
		end
end
