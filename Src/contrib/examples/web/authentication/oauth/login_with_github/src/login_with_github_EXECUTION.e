note
	description: "[
				application execution
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_GITHUB_EXECUTION

inherit
	WSF_FILTERED_ROUTED_EXECUTION

	WSF_URI_HELPER_FOR_ROUTED_EXECUTION

	WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_EXECUTION

	SHARED_DATABASE

create
	make

feature -- Access

	github_service (req: WSF_REQUEST): detachable LOGIN_WITH_GITHUB_SERVICE
 		local
 			l_setup: LOGIN_WITH_GITHUB_SETUP
		do
			create l_setup.make_from_path (create {PATH}.make_from_string ("github.ini"))
			if l_setup.is_valid then
				create Result.make (l_setup, "/login_with_github_callback", req)
			end
		end

feature -- Filter

	create_filter
			-- Create `filter'
		do
				--| Example using Maintenance filter.
			create {WSF_MAINTENANCE_FILTER} filter
		end

	setup_filter
			-- Setup `filter'
		local
			f: like filter
		do
			create {WSF_CORS_FILTER} f
			f.set_next (create {LOGIN_WITH_GITHUB_FILTER})

				--| Chain more filters like {WSF_CUSTOM_HEADER_FILTER}, ...
				--| and your owns filters.

			filter.append (f)
		end

feature -- Router

	setup_router
			-- Setup `router'
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
			l_path: PATH
		do

				 -- HTML uri/uri templates.
 			map_uri_agent ("/", agent handle_home_page, router.methods_GET)
 			map_uri_agent ("/about", agent handle_about_page, router.methods_GET)
 			map_uri_agent ("/messages", agent handle_messages_page, router.methods_get_post)
 			map_uri_agent ("/login_with_github", agent handle_login_with_github, router.methods_get)
 			if attached github_service (request) as l_github_service then
 				map_uri_agent (l_github_service.callback_uri_path, agent handle_login_with_github_callback, router.methods_get)
 			end

 			map_uri_agent ("/logout", agent handle_logout, router.methods_get)
 			map_uri_template_agent ("/messages/{id}", agent handle_item_page, router.methods_get)


					--| Files publisher
			create l_path.make_from_string ("www")
			create fhdl.make_hidden_with_path (l_path)
			fhdl.disable_index
			router.handle ("/", fhdl, router.methods_GET)
		end

feature  -- Handle HTML pages

 	handle_home_page (req: WSF_REQUEST; res: WSF_RESPONSE)
 		local
 			l_hp: HOME_PAGE
 		do
 			if attached req.http_host as l_host then
 				create l_hp.make (req.absolute_script_url (""), req.execution_variable ("user"))
 				if attached l_hp.representation as l_home_page then
 					compute_response_get (req, res, l_home_page)
 				end
 			end
 		end

 	handle_about_page (req: WSF_REQUEST; res: WSF_RESPONSE)
 		local
 			l_ap: ABOUT_PAGE
 		do
 			if attached req.http_host as l_host then
 				create l_ap.make (req.absolute_script_url (""), req.execution_variable ("user"))
 				if attached l_ap.representation as l_about_page then
 					compute_response_get (req, res, l_about_page)
 				end
 			end
  		end

 	handle_messages_page (req: WSF_REQUEST; res: WSF_RESPONSE)
  		local
 			l_lp: LIST_PAGE
 			l_401: UNAUTHORIZED_PAGE
  		do
 			if attached req.http_host as l_host and then
 			   attached {STRING_32} req.execution_variable ("user") as l_user
 			then
 				if req.is_get_request_method then
 					create l_lp.make (req.absolute_script_url (""), db_items (database), l_user)
 					if attached l_lp.representation as l_list_page then
 						compute_response_get (req, res, l_list_page)
 					end
 				elseif req.is_post_request_method then
 					if attached {WSF_VALUE} req.form_parameter ("message") as l_value then
 						db_put (database,l_user, l_value.as_string.value)
 						compute_response_redirect (req, res, req.absolute_script_url ("/messages/" + db_count (database).out ))
 					end
 				else
 					 -- Method not allowed.
 				end
 			else
 				create l_401.make (req.absolute_script_url (""))
 				if attached l_401.representation as l_unauthorized then
 					compute_response_401 (req, res, l_unauthorized )
 				end
 			end
  		end

 	handle_item_page (req: WSF_REQUEST; res: WSF_RESPONSE)
 		local
 			l_ip: ITEM_PAGE
 			l_401: UNAUTHORIZED_PAGE
 		do
 			if
 				attached req.http_host as l_host and then
 			   	attached {STRING_32} req.execution_variable ("user") as l_user and then
 				attached req.path_parameter ("id") as l_id
 			then
 			   	if attached db_exclusive_search (database, l_id.as_string.value.to_integer_64) as l_message then
 			   		create l_ip.make ( req.absolute_script_url (""), l_message, l_user)
 			   		if attached l_ip.representation as l_item then
 			   			compute_response_get (req, res, l_item)
 			   		end
 			   	end
 			else
 				create l_401.make (req.absolute_script_url (""))
 				if attached l_401.representation as l_unauthorized then
 					compute_response_401 (req, res, l_unauthorized )
 				end
 			end
 		end

 	handle_login_with_github (req: WSF_REQUEST; res: WSF_RESPONSE)
 		local
 			l_github_service: LOGIN_WITH_GITHUB_SERVICE
 		do
			l_github_service := github_service (req)
			if l_github_service /= Void then
				l_github_service.set_error_procedure (agent handle_login_error)
				l_github_service.process_login (req, res)
 			else
 				handle_login_error (req, res, "Internal error! Set Github settings in %"github.ini%".")
 			end
 		end

 	handle_login_with_github_callback (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_github_service: LOGIN_WITH_GITHUB_SERVICE
	 	do
	 		l_github_service := github_service (req)
	 		if l_github_service = void then
	 			handle_login_error (req, res, "Internal error (please set Github settings!)")
	 		else
	 			l_github_service.set_error_procedure (agent handle_login_error)
	 			l_github_service.process_oauth_callback (req, res,
	 				agent (i_req: WSF_REQUEST; i_res: WSF_RESPONSE; i_access_token: OAUTH_TOKEN; i_user: READABLE_STRING_GENERAL)
						local
	 						l_cookie: WSF_COOKIE
	 						conv: UTF_CONVERTER
	 						dt: DATE_TIME
	 						l_expires_in: INTEGER
	 					do
							if i_access_token.expires_in = 0 then
								l_expires_in := 3600
							else
								l_expires_in := i_access_token.expires_in
							end
							create dt.make_now_utc
							dt.second_add (l_expires_in)

							create l_cookie.make ({LOGIN_WITH_GITHUB_CONSTANTS}.oauth_session_token, i_access_token.token)
							l_cookie.set_max_age (l_expires_in)
							l_cookie.set_expiration_date (dt)
							l_cookie.set_path ("/")
							i_res.add_cookie (l_cookie)

							create l_cookie.make ({LOGIN_WITH_GITHUB_CONSTANTS}.oauth_user_login, conv.utf_32_string_to_utf_8_string_8 (i_user))
							l_cookie.set_max_age (l_expires_in)
							l_cookie.set_expiration_date (dt)
							l_cookie.set_path ("/")
							i_res.add_cookie (l_cookie)
							compute_response_redirect (i_req, i_res, i_req.absolute_script_url (""))
	 					end
	 				)
	 		end
		end

	handle_login_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_error_message: READABLE_STRING_GENERAL)
 		local
 			err: ERROR_PAGE
			msg: WSF_HTML_PAGE_RESPONSE
		do
	   		create err.make (req.absolute_script_url (""), a_error_message, Void)
	   		if attached err.representation as str then
	   			compute_response_get (req, res, str)
			else
	 			create msg.make
				msg.set_body (msg.html_encoded_string (a_error_message.to_string_32))
				res.send (msg)
		   	end
		end

	handle_logout (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_cookie: WSF_COOKIE
		do
			if
				attached {WSF_STRING} req.cookie ({LOGIN_WITH_GITHUB_CONSTANTS}.oauth_session_token) as l_cookie_token
			then
				req.unset_execution_variable ("user")
					-- Logout OAuth
				create l_cookie.make ({LOGIN_WITH_GITHUB_CONSTANTS}.oauth_session_token, "")
				l_cookie.set_path ("/")
				invalidate_cookie (l_cookie)
				res.add_cookie (l_cookie)

					-- Logout OAuth
				create l_cookie.make ({LOGIN_WITH_GITHUB_CONSTANTS}.oauth_user_login, "")
				l_cookie.set_path ("/")
				invalidate_cookie (l_cookie)
				res.add_cookie (l_cookie)

				req.unset_execution_variable ("user")
			end
			compute_response_redirect (req, res, req.absolute_script_url (""))
		end

	invalidate_cookie (a_cookie: WSF_COOKIE)
		do
			a_cookie.set_value ("") -- Remove data for security
			a_cookie.set_expiration_date (create {DATE_TIME}.make_from_epoch (0)) -- expiration in the past!
			a_cookie.set_max_age (0) -- Instructs the user-agent to delete the cookie
		end

 feature -- Response

 	compute_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
 		local
 			msg: WSF_HTML_PAGE_RESPONSE
 		do
 			create msg.make
 			msg.set_body (output)
 			msg.header.put_current_date
 			res.send (msg)
 		end

 	compute_response_401 (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
 		local
 			msg: WSF_HTML_PAGE_RESPONSE
 		do
 			create msg.make
 			msg.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
 			msg.set_body (output)
 			msg.header.put_current_date
 			res.send (msg)
 		end

 	compute_response_redirect (req: WSF_REQUEST; res: WSF_RESPONSE; a_url: STRING)
 		do
 			res.redirect_now (a_url)
 		end

 feature -- Database Access

	db_exclusive_search (a_db: like database; a_id: INTEGER_64): detachable MESSAGES
		do
			if attached a_db.search (a_id) as l_item then
				create Result.make_from_separate (l_item)
			end
		end

	db_items (a_db: like database): LIST [MESSAGES]
		local
			l_msg: MESSAGES
		do
			create {ARRAYED_LIST [MESSAGES]} Result.make (0)
			across a_db.items as ic loop
				create l_msg.make_from_separate (ic.item)
				Result.force (l_msg)
			end
		end

	db_put (a_db: like database; a_user, a_value: separate READABLE_STRING_32)
		do
			a_db.put (a_user,a_value)
		end

	db_count (a_database: like database): INTEGER
		do
			Result := a_database.items.count
		end

end
