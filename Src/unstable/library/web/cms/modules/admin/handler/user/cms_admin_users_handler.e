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
			s,ms: STRING
			u: CMS_USER
			l_page_helper: CMS_PAGINATION_GENERATOR
			s_pager: STRING
			l_total_user_count: INTEGER
			user_api: CMS_USER_API
			l_display_name: READABLE_STRING_32
			ago: DATE_TIME_AGO_CONVERTER
			lst: ITERABLE [CMS_USER]
			nb: NATURAL_32
			f: CMS_FORM

			l_name_filter: READABLE_STRING_32
			q: CMS_DATA_QUERY_PARAMETERS
		do
				-- At the moment the template are hardcoded, but we can
				-- get them from the configuration file and load them into
				-- the setup class.

			if api.has_permission ({CMS_ADMIN_MODULE_ADMINISTRATION}.perm_admin_users) then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)

				user_api := api.user_api
				l_total_user_count := user_api.users_count
				if l_total_user_count > 1 then
					l_response.set_title ("Total: " + l_total_user_count.out + " users")
				else
					l_response.set_title ("One user")
				end

				if attached {WSF_STRING} req.query_parameter ("name") as p_name then
					l_name_filter := p_name.value
					if l_name_filter.is_whitespace then
						l_name_filter := Void
					end
				end

				create l_page_helper.make (api.administration_path_location ("users/?page={page}&size={size}"), l_total_user_count.as_natural_64, 25) -- FIXME: Make this default page size a global CMS settings
				l_page_helper.get_setting_from_request (req)

				create q.make (l_page_helper.current_page_offset, l_page_helper.page_size)
				if l_name_filter /= Void then
					q.set_parameter (l_name_filter, "name")
				end
				lst := user_api.recent_users (q)
				if lst /= Void then
					nb := 0
					across
						lst as ic
					loop
						nb := nb + 1
					end
				end

				create ms.make_empty

				create s_pager.make_empty
				if l_page_helper.has_upper_limit and then l_page_helper.pages_count > 1 then
					l_page_helper.append_to_html (l_response, s_pager)
					if l_page_helper.page_size > 25 then
						ms.append (s_pager)
					end
				end

				create f.make (req.percent_encoded_path_info, "users-form")
				f.set_method_get
--				f.add_css_style ("display: inline-block")
				f.extend_text_field ("name", l_name_filter)

				if lst /= Void then
					if l_name_filter /= Void then
						if nb = 0 then
							l_response.set_title ("No user found (out of "+ l_total_user_count.out +")")
						elseif nb = 1 then
							l_response.set_title ("One user found (out of "+ l_total_user_count.out +")")
						elseif nb > 1 then
							l_response.set_title (nb.out + " users found (out of "+ l_total_user_count.out +")")
						end
					end

					create s.make (1024)
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

					f.extend_html_text (s)
					f.append_to_html (l_response.wsf_theme, ms)
--					ms.append (s)
				end
					-- Again the pager at the bottom, if needed
				ms.append (s_pager)

				if l_response.has_permission ("manage " + {CMS_ADMIN_MODULE}.name) then
					ms.append (api.link ("Add User", api.administration_path_location ("add/user"), Void))
				end

				l_response.set_main_content (ms)
				l_response.execute
			else
				send_access_denied (req, res)
			end
		end
end
